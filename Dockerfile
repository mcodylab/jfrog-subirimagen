

# Primera etapa: Builder con todas las dependencias
FROM python:3.10 AS builder
# Definir la variable como un argumento de build
ARG PIP_INDEX_URL

# Hacer que esté disponible en el entorno
ENV PIP_INDEX_URL=${PIP_INDEX_URL}

WORKDIR /app
COPY requirements.txt .
RUN echo "Usando PIP_INDEX_URL: $PIP_INDEX_URL"
RUN python -m pip install --upgrade pip && \
    pip install --no-cache-dir --index-url "$PIP_INDEX_URL" -r requirements.txt

# Segunda etapa: Imagen final más liviana
FROM python:3.10-slim AS final
WORKDIR /app

# Copia solo las dependencias ya instaladas del builder
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copia el código fuente
COPY . .

# Comando de inicio
CMD ["python", "app.py"]
