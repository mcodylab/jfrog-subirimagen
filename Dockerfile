# Usar imagen base ligera
FROM python:3.9-slim

# Definir directorio de trabajo
WORKDIR /app

# Agregar variables de entorno para PIP (sin credenciales expuestas)
ARG PIP_INDEX_URL
ENV PIP_INDEX_URL=${PIP_INDEX_URL}
ENV PIP_NO_CACHE_DIR=off

# Debug: Imprimir PIP_INDEX_URL dentro del contenedor
RUN echo "PIP_INDEX_URL dentro del contenedor: $PIP_INDEX_URL"

COPY requirements.txt .


# Instalar dependencias
COPY requirements.txt .
RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir -i "$PIP_INDEX_URL" -r requirements.txt


