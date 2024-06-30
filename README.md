# Comandos docker
Docker es un software de código abierto utilizado para desplegatr aplicaciones dentro de contenedores virtuales. Docker nos permite empaquetar una aplicación con todas sus dependencias (bibliotecas, herramientas y archivos necesarios) dentro de 1 solo paquete llamado imagen.

## Imagenes
Las imagenes son plantillas inmutables que tienen todo lo necesario para ejecutar la aplicación, incluyendo el código, las dependencias, las bibliotecas, el entorno de ejecución y las configuraciones.

### Comandos imagenes

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

4) Este comando nos permite eliminar las imagenes descargadas.

```
docker image rm node:18
```

## Contenedores
Podemos ver a los contenedores como cajas que tienen adentro todo lo necesario para iniciar una aplicación (las imágenes), independientemente del sistema operativo en el que nos encontremos, esto funciona gracias a la virtualización. Los contenedores poseen su propio sistema de archivos, recursos de CPU, red y memoria, lo que les permite ser portátiles y consistentes entre diferentes entornos de desarrollo. A diferencia de las máquinas virtuales tradicionales, los contenedores comparten el núcleo del sistema operativo del host, lo que los hace más ligeros y eficientes.

### Comandos contenedores

#### Proceso

1) Descargamos una imagen.

```
docker pull mongo
```

2) Comando para crear un contenedor.

```
docker create mongo
```

3) Alternativa para crear un contenedor.

```
docker container create mongo
```

4) Comando para ejecutar nuestro contenedor.

```
docker start id
```

5) Comando para verificar que el contenedor este levantado.

```
docker ps
```

6) Comando para detener el contenedor.

```
docker stop id
```

7) Comando para mostrar todos los contenedores que se enceuntran en nuestro sistema incluso si no están levantados.

```
docker ps -a
```

8) Comando para eliminar el contenedor, en este caso estoy haciendo referencia al nombre del contenedor, este se crea 
de forma arbitraría.

```
docker rm focused_varahamihira
```

9) Comando para darle un nombre al contenedor en este caso se llama: contenedor_monguito

```
docker create --name contenedor_monguito mongo
```

10) Comando para mapear los pueros (-p27017 = Puerto de nuestra maquina):(27017 = Puerto del contenedor que mapearemos con nuestra maquina) 

```
docker create -p27017:27017 --name monguito mongo
```

11) Con este comando docker escoge cual será el puerto anfitrión que utilizara para mapear
NOTA: No es buena practica ya que entrega puertos más arriba del 5000, lo que se debe hacer en este ejemplo seria utilizar este comando: Docker create -p27018:27017 --name monguito mongo

```
docker create -p27017 --name monguito2 mongo
```
12) Comando para verificar si se ejecuto correctamente el contenedor

```
docker logs monguito
```

13) Comando para quedarse escuchando los logs que emita nuestro contenedor

```
docker logs --follow monguito
```

#### Forma rápida de crear un contenedor

1) Comando que nos devuelve inmediatamente los logs.

```
docker run mongo
```

2) Con este comando se ejecuta inmediatamente el contenedor y nos devuelve a la línea de comandos.

```
docker run -d mongo
```

3) Con este comando le asignamos un nombre y un puerto de nuestra preferencía y lo colocamos en modo dettached (-d) para activar nuestro contenedor inmediatamente.

```
docker run --name monguito -p27017:27017 -d mongo
```

### Conectándose a los contenedores
1) Para este punto necesitaremos nuestro archivo index.js y una imagen de mongo, descargaremos la imagen de mongo y nos conectaremos a ella a traves del siguiente comando.

```
docker create -p27017:27017 --name monguito -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password mongo
```

2) Una ves hecho esto y se haya verificado que nuestra aplicación esta corriendo crearemos un archivo llamado "Dockerfile" para poder comunicarnos con Docker.

3) Necesitamos que nuestros contenedores se comuniquen entre ellos así que debemos agrupar nuestrso contenedores, para ello comprobaremos que redes tiene docker con el comando: 

```
docker network ls
```

4) Para crear nuestra propia red utilizaremos

```
docker network create mired
```

5) Si necesitaramos eliminarlo utilizamos

```
docker network rm mired
```

6) Para que nosotros podamos conectarnos a travez de docker este debe tener el mismo nombre del contenedor en nuestro código fuente, en este caso es monguito

7) Con este comando nosotros podremos construir imagenes en base al archivo Dockerfile, para este ejemplo se utiliza el nombre miapp y el segundo argumento es donde se encuentra nuestro archivo Dockerfile (se representa con el punto)

```
docker build -t miapp:1 .
```

8) Ahora cuando nosotros construyamos nuestros contenedores debemos indicarles que se deben conectar a una red en especifico y utilizaremos la que ya habiamos creado "mired"

```
docker create -p27017:27017 --name monguito --network mired -e MONGO_INITDB_ROOT_USERNAME=root -e MONGO_INITDB_ROOT_PASSWORD=password mongo
```

9) Ahora crearemos el contenedor de la aplicación que colocamos dentro de una imagen con el siguiente comando:

```
docker create -p3000:3000 --name chanchito --network mired miapp:1
```

### Docker compose

1) Para utilizar el siguiente comando, deberemos crear un archivo llamado `docker-compose.yml`, donde incluiremos los argumentos necesarios para su funcionamiento, tales como: la versión que estamos utilizando, el nombre de los contenedores, las imágenes, sus respectivos puertos y las variables de entorno tambien conocidos como enviroments.

```
docker compose up
```

2) Si quisieramos llegar a eliminar estos contenedores e imagenes creados por el mismo docker debemos ejecutar el comando:

```
docker compose down
```

### Volumes

Utilizamos los volumes para que nuestros datos persistan en el tiempo así eliminemos nuestro contenedor o realicemos cambios al momento de crear una nueva aplicación, esto nos sirve para agilizar el desarrollo.

Nota: 
Si quisieramos ejecutar un archivo docker en especifico debemos utilizar este comando:

```
docker compose -f docker-compose-dev.yml up
```