# ✅ Imagen base ligera de Python 3.13.5 sobre Debian (versión "bookworm")
# Usamos la variante "slim" para evitar componentes innecesarios y reducir el tamaño
FROM python:3.13.5-slim-bookworm

# ⚙️ Evita que se muestren mensajes interactivos durante instalaciones con apt
# Esto hace que la imagen se construya automáticamente sin pausas
ENV DEBIAN_FRONTEND=noninteractive

# 🧱 Instalamos herramientas básicas para compilar paquetes de Python que lo requieran (como pandas, numpy, etc.)
# 🔧 También actualizamos pip y agregamos ipykernel, que permite correr notebooks en VS Code sin necesidad de instalar JupyterLab completo
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir ipykernel 

# 🧹 Eliminamos archivos temporales y cachés del sistema para reducir el tamaño final de la imagen
# Mejora la eficiencia del contenedor y evita incluir datos innecesarios
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
