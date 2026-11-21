# Dev Container para análisis de datos en Python.

# ✅ Imagen base ligera de Python 3.14.5 sobre Debian ("bookworm" = Debian 12)
FROM python:3.14.5-slim-bookworm

# ⚙️ Evita mensajes interactivos durante instalaciones con apt
ENV DEBIAN_FRONTEND=noninteractive

# 🔧 Dependencias de sistema base (compiladores para paquetes sin wheel + certificados HTTPS)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ─────────────────────────────────────────────────────────────────────────────
# 🧰 (OPCIONAL) Paquetes del sistema que han pedido proyectos reales.
#    Descomenta solo lo que tu proyecto necesite. Lo que se instala a mano dentro del
#    contenedor se pierde al recrearlo; lo que vive aquí, no.
# ─────────────────────────────────────────────────────────────────────────────
# Excel con macros o conversión a PDF (LibreOffice sin interfaz + puente UNO, que usa el
# python3 del sistema, no el de esta imagen):
# RUN apt-get update && apt-get install -y --no-install-recommends libreoffice-calc python3-uno \
#     && apt-get clean && rm -rf /var/lib/apt/lists/*
#
# Geoespacial (solo si alguna dependencia no trae wheel para tu versión de Python):
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         gdal-bin libgdal-dev libgeos-dev libproj-dev ghostscript \
#     && apt-get clean && rm -rf /var/lib/apt/lists/*
#
# Metadatos de fotos y video:
# RUN apt-get update && apt-get install -y --no-install-recommends libimage-exiftool-perl \
#     && apt-get clean && rm -rf /var/lib/apt/lists/*
#
# Binario externo FIJADO y VERIFICADO (patrón; ejemplo con rclone):
#   - versión = la release de seguridad vigente (búscala), no la que recuerdes;
#   - el ARG se llama PIN_<HERRAMIENTA>_VERSION: rclone lee las variables RCLONE_* como
#     opciones y un ARG RCLONE_VERSION rompe el build.
# ARG PIN_RCLONE_VERSION=vX.Y.Z
# RUN apt-get update && apt-get install -y --no-install-recommends curl unzip \
#     && curl -fsSLO "https://downloads.rclone.org/${PIN_RCLONE_VERSION}/rclone-${PIN_RCLONE_VERSION}-linux-amd64.zip" \
#     && curl -fsSL "https://downloads.rclone.org/${PIN_RCLONE_VERSION}/SHA256SUMS" \
#         | grep "rclone-${PIN_RCLONE_VERSION}-linux-amd64.zip" | sha256sum -c - \
#     && unzip -q "rclone-${PIN_RCLONE_VERSION}-linux-amd64.zip" \
#     && install -m 0755 "rclone-${PIN_RCLONE_VERSION}-linux-amd64/rclone" /usr/local/bin/ \
#     && rm -rf rclone-* && apt-get clean && rm -rf /var/lib/apt/lists/*

# 📦 Instalar uv desde la imagen oficial de Astral (versión fijada)
COPY --from=ghcr.io/astral-sh/uv:0.11.13 /uv /uvx /bin/