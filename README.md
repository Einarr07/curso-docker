# Comandos docker
Docker es un software de código abierto utilizado para desplegatr aplicaciones dentro de contenedores virtuales.
Docker nos permite empaquetar una aplicación con todas sus dependencias (bibliotecas, herramientas y archivos necesarios)
deontro de 1 solo paquete llamado imagen.

## Imagenes
Las imagenes son plantillas inmutables que tienen todo lo necesario para ejecutar la aplicación, incluyendo el código, las
dependencias, las bibliotecas, el entorno de ejecución y las configuraciones.

### Comandos de docker images

1) Trae todas las imágenes que hayamos descargado.

```
docker images
```

2) Descargamos la imagen que nosotros deseamos, en este ejemplo estamos descargando la imagen de node.

```
docker pull node
```

3) Descargamos la imagen pero esta vez le especificamos la versión que necesitamos.

```
docker pull node:18
```

4) Este comando nos permite eliminar las imagenes descargadas

```
docker image rm node:18
```

## Contenedores
Los contenedores son instancias ejecutables de imagenes Docker. Representan una aplicación o 1 servicio de ejecución

- Docker pull mongo
(Descargamos una imagen)
- Docker create mongo
(Comando para crear un contendeor)
- Docker container create mongo 
(Alternativa)
- Docker start (id del contenedor)
(Comando para ejecutar nuestro contenedor)
- Docker ps
(Comando para verificar que el contenedor esta corriendo)
- Docker stop (id del contenedor)
(Comando para detener el contenedor)
- Docker ps -a
(Comando para mostrar todos los contenedores que se encuentran en nuestro sistema incluso si no están corriendo)
- docker rm focused_varahamihira
(Comando para eliminar el contenedor, en este caso estoy haciendo referencia al nombre del contenedor, este se crea de forma
arbitraría)
-  docker create --name contenedor_mongito mongo
(Comando para darle un nombre al contenedor en este caso se llama: contenedor_mongito)
- Docker create -p27017:27017 --name monguito mongo
(Comando para mapear los pueros (-p27017 = Puerto de nuestra maquina):(27017 = Puerto del contenedor que mapearemos con nuestra maquina))
- docker create -p27017 --name monguito2 mongo
(Con este comando Docker escoge cual será el puerto anfitrión que utilizara para mapear)
(NOTA: No es buena practica ya que entrega puertos más arriba del 5000, lo que se debe hacer en este ejemplo seria
utilizar este comando: Docker create -p27018:27017 --name monguito mongo)
- Docker logs monguito
(Comando para verificar si se ejecuto correctamente el contenedor)
- Docker logs --follow monguito
(Comando para quedarse escuchando los logs que emita nuestro contenedor)

------ Forma más rápida de crear un contenedor -------------------------
- Docker run mongo
(Con este comando nos devuelve inmediatamente los logs)
- Docker run -d mongo
(Con este comando se ejecuta inmediatamente el contenedor y nos devuelve a la linea de comandos)
- docker run --name monguito -p27017:27017 -d mongo
(Con este comando le asignamos un nombre y un puerto de nuestra preferencia y lo colocamos en modo dettached (-d) para activar nuestro
contenedor inmediatamente)