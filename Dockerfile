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
COPY /sitio /usr/share/nginx/html

# 3) Exponer el puerto
# (Nginx sirve contenido en el puerto 80 por defecto)
EXPOSE 80
