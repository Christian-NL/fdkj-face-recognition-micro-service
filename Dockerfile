# Utilise une image Python officielle
FROM python:3.9-slim

# Dossier de travail dans le container
WORKDIR /app

# Copie les fichiers nécessaires
COPY requirements.txt .
COPY app.py .
COPY config.py .
COPY ReadMe .
COPY templates/ ./templates/
COPY static/ ./static/

# Installe les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Port exposé (le même que dans ton app Flask)
EXPOSE 5000

# Commande pour lancer l'application
CMD ["python", "app.py"]