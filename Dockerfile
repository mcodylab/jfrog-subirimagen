FROM python:3.9-slim

WORKDIR /app

ARG PIP_INDEX_URL
ENV PIP_INDEX_URL=${PIP_INDEX_URL}

# Configurar pip.conf dentro del contenedor
RUN mkdir -p /root/.pip && \
    echo "[global]\nindex-url = ${PIP_INDEX_URL}" > /root/.pip/pip.conf && \
    cat /root/.pip/pip.conf  # <-- Verifica que la URL realmente está bien

# Copiar dependencias
COPY requirements.txt .

# Instalar dependencias con depuración
RUN python -m pip install --upgrade pip && \
    pip install --verbose --no-cache-dir -r requirements.txt  # <-- Agrega --verbose

COPY . .

CMD ["python", "app.py"]
