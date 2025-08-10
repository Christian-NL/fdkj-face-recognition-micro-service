# Utiliser une image Python optimisée avec Debian Slim
FROM python:3.9-slim-bullseye

# Dossier de travail
WORKDIR /app

# Installer les dépendances système nécessaires à face_recognition et opencv
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake \
    g++ \
    libopenblas-dev \
    liblapack-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    && rm -rf /var/lib/apt/lists/*

# Copier les fichiers de l'application
COPY requirements.txt .
COPY app.py .
COPY config.py .
COPY ReadMe .

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Exposer le port Flask
EXPOSE 5000

# Commande par défaut
CMD ["python", "app.py"]
