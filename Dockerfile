# Usar imagen base ligera
FROM python:3.9-slim

# Definir directorio de trabajo
WORKDIR /app

# Agregar variables de entorno para PIP (sin credenciales expuestas)
ARG PIP_INDEX_URL
ENV PIP_INDEX_URL=${PIP_INDEX_URL}
ENV PIP_NO_CACHE_DIR=off

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copiar los archivos del proyecto (primero requirements.txt para aprovechar cache)
COPY requirements.txt .

# Instalar dependencias desde Artifactory y PyPI como fallback
RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir -i "$PIP_INDEX_URL"  -r requirements.txt

# Copiar el resto del código fuente
COPY . .

# Crear un usuario no root para seguridad
RUN useradd -m appuser
USER appuser

# Exponer puerto
EXPOSE 8080

# Comando de inicio
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]


