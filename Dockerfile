# Utilise l'image officielle miniconda (plus léger que Anaconda)
FROM continuumio/miniconda3:4.9.2

# Crée l'environnement conda avec les dépendances pré-compilées
RUN conda create -n myenv python=3.9 \
    && conda install -n myenv -c conda-forge \
    dlib=19.24 \
    face_recognition=1.3.0 \
    flask=2.0.1 \
    numpy=1.21.2 \
    opencv=4.5.2 \
    && conda clean -afy

# Configure l'environnement
ENV PATH /opt/conda/envs/myenv/bin:$PATH

# Dossier de travail
WORKDIR /app

# Copie des fichiers (seulement le nécessaire)
COPY app.py .
COPY config.py .
COPY requirements.txt .

# Installation des dépendances pip supplémentaires si nécessaire
RUN pip install --no-cache-dir -r requirements.txt

# Port exposé
EXPOSE 5000

# Commande de lancement
CMD ["python", "app.py"]