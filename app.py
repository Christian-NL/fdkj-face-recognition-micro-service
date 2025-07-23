# from flask import Flask, request, jsonify
# import face_recognition
# import cv2
# import numpy as np

# app = Flask(__name__)

# @app.route('/api/compare-faces', methods=['POST'])
# def compare_faces():
#     # Vérifier si les fichiers sont bien envoyés
#     if 'image1' not in request.files or 'image2' not in request.files:
#         return jsonify({"error": "Veuillez fournir image1 et image2"}), 400

#     # Charger les images
#     file1 = request.files['image1']
#     file2 = request.files['image2']

#     # Convertir en format OpenCV (numpy array)
#     img1 = face_recognition.load_image_file(file1)
#     img2 = face_recognition.load_image_file(file2)

#     # Extraire les encodages des visages
#     try:
#         encoding1 = face_recognition.face_encodings(img1)[0]  # Premier visage trouvé
#         encoding2 = face_recognition.face_encodings(img2)[0]
#     except IndexError:
#         return jsonify({"error": "Aucun visage détecté dans une des images"}), 400

#     # Comparer les visages
#     results = face_recognition.compare_faces([encoding1], encoding2, tolerance=0.6)  # Tolerance ajustable
#     is_same = bool(results[0])

#     return jsonify({"same_face": is_same})

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5000, debug=True)


from flask import Flask, request, jsonify
from controllers.face_controller import FaceController
from utils.exception import InvalidRequestError, FaceDetectionError

app = Flask(__name__)

@app.route('/api/compare-faces', methods=['POST'])
def compare_faces():
    try:
        result = FaceController.compare_faces(request)
        return jsonify(result)
    except InvalidRequestError as e:
        return jsonify({"error": str(e)}), 400
    except FaceDetectionError as e:
        return jsonify({"error": str(e)}), 400
    except Exception as e:
        return jsonify({"error": "Erreur interne du serveur"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)