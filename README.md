# 📦 Curso Docker

Este repositorio contiene una guía práctica para aprender los **conceptos básicos de Docker**, incluyendo comandos esenciales, construcción de imágenes, ejecución de contenedores y gestión de recursos.

---

## 📑 Índice

- [🚀 Comandos básicos](#-comandos-básicos)
- [🔍 Exploración de comandos](#-exploración-de-comandos)
- [📂 Flujo de trabajo](#-flujo-de-trabajo)
- [🛠️ Construcción de imágenes con Dockerfile](#️-construcción-de-imágenes-con-dockerfile)
  - [1. Crear la imagen](#1-crear-la-imagen)
  - [2. Construir con nombre y tag](#2-construir-con-nombre-y-tag)
- [🖥️ Construcción y ejecución de contenedores](#️-construcción-y-ejecución-de-contenedores)
- [🗂️ Gestión de imágenes](#️-gestión-de-imágenes)
- [🛠️ Gestión de contenedores](#️-gestión-de-contenedores)
  - [Ejecutar múltiples contenedores](#ejecutar-múltiples-contenedores-de-la-misma-imagen)
  - [Listar todos los contenedores](#listar-todos-los-contenedores-incluidos-detenidos)
  - [Ver tamaño de los contenedores](#ver-tamaño-de-los-contenedores)
  - [Detener un contenedor](#detener-un-contenedor)
  - [Monitorear recursos](#monitorear-recursos-de-los-contenedores)
- [📦 Volúmenes](#-volúmenes)
- [🌐 Redes](#-redes-networks)
- [🐳 Docker hub](#-docker-hub)
- [🐙 Docker compose](#-docker-compose)
- [✅ Conclusión](#-conclusión)

---

## 🚀 Comandos básicos

Verificar la versión instalada:
```bash
docker -v
```

Ver información general del sistema Docker:
```bash
docker info
```

Listar imágenes disponibles:
```bash
docker images
```

Listar contenedores en ejecución:
```bash
docker ps
```

---

## 🔍 Exploración de comandos

Para obtener ayuda sobre un comando específico:
```bash
docker <comando> --help
```

Ejemplo:
```bash
docker images --help
docker ps --help
```

---

## 📂 Flujo de trabajo

![flujo de trabajo](images/flujo_trabajo.png)

---

## 🛠️ Construcción de imágenes con Dockerfile

### 1. Crear la imagen
Si el `Dockerfile` está en el mismo directorio, utilizamos:
```bash
docker build .
```

Esto genera una imagen **sin nombre ni tag**, lo cual no es recomendable.  
Ejemplo:
```
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
<none>       <none>    13e33a3c9fb2   90 minutes ago   279MB
```

Para eliminar esa imagen anónima:
```bash
docker rmi -f <IMAGE ID>
```

---

### 2. Construir con nombre y tag
Para asignar un nombre y versión a la imagen:
```bash
docker build -t sitioweb:latest .
```

Ejemplo:
```
REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
sitioweb     latest    2d0934cdba2b   9 minutes ago   279MB
```

Ahora la imagen tiene un **nombre (repository)** y un **tag (versión)** claros.

---

## 🖥️ Construcción y ejecución de contenedores

Ejecutar un contenedor a partir de la imagen:
```bash
docker run -it --rm -d -p 8080:80 --name web sitioweb
```

**Parámetros importantes:**
- `-it` → modo interactivo (permite ver logs).
- `--rm` → elimina el contenedor cuando se detiene.
- `-d` → ejecuta en segundo plano.
- `-p 8080:80` → expone el puerto 80 del contenedor en el puerto 8080 del host.
- `--name web` → asigna un nombre al contenedor.
- `sitioweb` → nombre de la imagen.

### Detener o eliminar contenedores
Detener un contenedor:
```bash
docker stop <CONTAINER ID>
```

Eliminar un contenedor forzado:
```bash
docker rm -f <CONTAINER ID>
```

---

## 🗂️ Gestión de imágenes

Ver una imagen específica:
```bash
docker images <nombre-imagen>
```

Filtrar imágenes por versión (ejemplo: `1.0`):
```bash
docker images --filter=reference='*:1.0'
```

### Crear un nuevo tag para una imagen existente
```bash
docker image tag sitioweb:latest usuario/sitioweb:latest
```

### Eliminar una etiqueta de imagen
```bash
docker rmi <tag>
```

### Eliminar una imagen
> ⚠️ Nota: no puedes eliminar una imagen si está siendo utilizada por un contenedor.
```bash
docker rmi <IMAGE ID>
```

---

## 🛠️ Gestión de contenedores

### Ejecutar múltiples contenedores de la misma imagen
Para ejecutar 2 contenedores a partir de la **misma imagen**, se debe usar un puerto distinto y un nombre diferente:

Primer contenedor:
```bash
docker run -it --rm -d -p 8080:80 --name web sitioweb
```

Segundo contenedor:
```bash
docker run -it --rm -d -p 8085:80 --name web85 sitioweb
```

> ⚠️ No pueden existir **dos contenedores con el mismo nombre** ejecutándose al mismo tiempo.

---

### Listar todos los contenedores (incluidos detenidos)
```bash
docker ps -a
```

### Ver tamaño de los contenedores
```bash
docker ps --size
```

El tamaño que aparece entre paréntesis es el **espacio que ocupa cada vez que el contenedor se ejecuta**.  
Ejemplo:
```
81.9kB (virtual 207MB)
```

Representación de bits:  
![tamaño de los bits](images/tamaño_bits.png)

---
Un bit representa:
- 1 bit → Unidad básica (puede ser 0 o 1).
- 1 byte (B) = 8 bits.
- 1 kilobyte (KB) = 1,024 bytes.
- 1 megabyte (MB) = 1,024 KB.
- 1 gigabyte (GB) = 1,024 MB.
- 1 terabyte (TB) = 1,024 GB.
---

### Detener un contenedor
Esto también lo elimina de **Docker Desktop**:
```bash
docker stop <CONTAINER ID>
```

---

### Monitorear recursos de los contenedores
```bash
docker stats
```

Este comando muestra el uso de CPU, memoria, red y disco en tiempo real.

---

## 📦 Volúmenes

Los **volúmenes en Docker** permiten almacenar y compartir datos entre el host y los contenedores, asegurando persistencia incluso si el contenedor se elimina.

Ejemplo de ejecución con volumen:
```bash
docker run -it --rm -d -p 8080:80 -v ./sitio:/usr/share/nginx/html/sitio --name web sitioweb
```

- `-v ./sitio:/usr/share/nginx/html/sitio` → monta la carpeta local `./sitio` dentro del contenedor en `/usr/share/nginx/html/sitio`.  
  Esto permite **editar archivos en tu máquina y ver cambios reflejados en tiempo real** dentro del contenedor.

Listar volúmenes:
```bash
docker volume ls
```

Eliminar un volumen:
```bash
docker volume rm <nombre-volumen>
```

Eliminar todos los volúmenes no usados:
```bash
docker volume prune
```

---

## 🌐 Redes (Networks)

Inspeccionar un contenedor y ver su configuración de red:
```bash
docker inspect <NAME>
```

En la sección `Networks` podrás ver la red asignada (por defecto `bridge`) y dentro de `NetworkSettings` los puertos expuestos.

Ejemplo al asignar una IP específica:
```bash
docker run -it --rm -d -p 127.0.0.1:8080:80 --name web sitioweb
```

Listar todas las redes:
```bash
docker network ls
```

### Tipos de redes
- **Bridge (por defecto):** útil para comunicación entre contenedores en un mismo proyecto.
- **Host:** el contenedor comparte la red del host. Más rápido, pero menos aislado.
- **None:** el contenedor queda sin red, aislado totalmente.

Crear una red personalizada:
```bash
docker network create <nombre>
```

Eliminar una red existente:
```bash
docker network rm <nombre>
```

---

## 🐳 Docker Hub

### 1. Iniciar sesión
```bash
docker login
```

### 2. Construir la imagen con nombre y tag
```bash
docker build -t <usuario>/<nombre_imagen>:<version> .
```

### 3. Publicar la imagen en Docker Hub
```bash
docker push <usuario>/<nombre_imagen>:<version>
```

### 4. Descargar y ejecutar imágenes
```bash
docker run --name <nombre_contenedor> -it --rm -d -p 8080:80 <usuario>/<nombre_imagen>:<version>
```

### 5. Compartir imágenes sin Docker Hub

Guardar una imagen:
```bash
docker save <nombre_imagen>:<version> -o <archivo>.tar
```

Cargar una imagen:
```bash
docker load --input <archivo>.tar
```

---

## 🐙 Docker Compose

**Docker Compose** es una herramienta que nos permite **definir, configurar y orquestar múltiples contenedores** mediante un archivo `docker-compose.yml`.  
Con él podemos manejar de forma sencilla:
- **Servicios** (ej. frontend, backend, base de datos)
- **Redes** (comunicación entre contenedores)
- **Volúmenes** (persistencia de datos)
- **Config y Secrets** (manejo seguro de configuraciones y credenciales)

### Comandos principales
Construir servicios:
```bash
docker compose build
```

Levantar servicios:
```bash
docker compose up
```

Detener servicios:
```bash
docker compose down
```

### Ejemplo simple
```yaml
services:
  backend:
    build:
      context: ./backend
    ports:
      - "5000:5000"

  frontend:
    build:
      context: ./frontend
    ports:
      - "8080:80"
    depends_on:
      - backend
```

📌 `depends_on` asegura que `backend` arranque antes que `frontend`, pero **no espera a que esté listo**.  
Para asegurarlo, se recomienda usar un **healthcheck** en `backend`.

---

## ✅ Conclusión

Docker y Docker Compose son herramientas fundamentales para el desarrollo moderno.  
Permiten empaquetar aplicaciones, crear entornos reproducibles y gestionar múltiples servicios de forma sencilla.  
