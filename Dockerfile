# ---------- Étape 1 : build ----------
FROM python:3.9-slim AS builder

WORKDIR /app

# Installer les outils de compilation et dépendances
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libjpeg-dev \
    libpng-dev \
    libopenblas-dev \
    liblapack-dev \
    libtiff-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---------- Étape 2 : image finale ----------
FROM python:3.9-slim

WORKDIR /app

# Installer les dépendances runtime avec les noms corrects pour Debian Bookworm
RUN apt-get update && apt-get install -y \
    libjpeg62-turbo \
    libpng16-16 \
    libopenblas0 \
    liblapack3 \
    libtiff6 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local
COPY . .

EXPOSE 5000
CMD ["python", "app.py"]