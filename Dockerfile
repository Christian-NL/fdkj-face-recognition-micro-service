# Utilise une image Python officielle
FROM python:3.9

# Dossier de travail dans le container
WORKDIR /app

# Installer les dépendances système
RUN apt-get update && \
    apt-get install -y \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Copie les fichiers nécessaires
COPY requirements.txt .
COPY app.py .
COPY config.py .
COPY ReadMe .

# Installe les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Port exposé (le même que dans ton app Flask)
EXPOSE 5000

# Commande pour lancer l'application
CMD ["python", "app.py"]