# 1) Indicamos la imagen base y su versión
# En este caso usaremos Python 3.12.11 basado en Debian Trixie
FROM python:3.12.11-trixie

# 2) Establecemos el directorio de trabajo dentro del contenedor
# Aquí se copiarán y ejecutarán los archivos de la aplicación
WORKDIR /app

# 3) Copiamos el archivo de dependencias desde el entorno local al contenedor
COPY requirements.txt requirements.txt

# 4) Instalamos las dependencias de Python dentro del contenedor
RUN pip install --no-cache-dir -r requirements.txt

# 5) Copiamos todo el contenido del proyecto (directorio actual) al directorio de trabajo en el contenedor
# NOTA: Docker ejecuta estas instrucciones en capas, por eso el orden es importante
COPY . .

# 6) Definimos el comando por defecto que se ejecutará al iniciar el contenedor
# Lo escribimos en formato lista para que Docker lo interprete correctamente
# Comando original: python -m flask run
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
