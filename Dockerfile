# 1) Imagen base
# Usamos la imagen oficial de Nginx desde Docker Hub.
# "latest" toma la última versión estable disponible.
# (Recomendación: fijar una versión específica para mayor control,
#   ej: nginx:1.27-alpine)
FROM nginx:latest

# 2) Copiar archivos del sitio estático
# Se copian los archivos locales de la carpeta "sitio"
# al directorio por defecto de Nginx donde sirve contenido.
# Origen: ./sitio (local)
# Destino: /usr/share/nginx/html (contenedor)
COPY ./sitio /usr/share/nginx/html

# 3) Volumen
# Los volúmenes permiten **persistir datos** y hacer cambios en tiempo de ejecución
# (se crean como carpetas compartidas entre el host y el contenedor).
#
# ⚠️ IMPORTANTE:
# - Si tu proyecto es **estático** (ejemplo: sitio web terminado),
#   lo correcto es usar **COPY**, ya que solo necesitas empaquetar
#   los archivos dentro de la imagen.
# - Si tu proyecto es **dinámico** (ejemplo: estás desarrollando y
#   quieres ver cambios sin reconstruir la imagen),
#   entonces un **VOLUME o -v en docker run** es la mejor opción.
#
# Definición de volumen dentro del Dockerfile (poco común en proyectos estáticos).
# -> VOLUME ["/sitio","/usr/share/nginx/html"]

# 4) Exponer el puerto
# (Nginx sirve contenido en el puerto 80 por defecto)
EXPOSE 80
