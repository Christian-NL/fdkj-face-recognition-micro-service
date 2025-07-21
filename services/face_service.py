import face_recognition
from config import Config

class FaceService:
    @staticmethod
    def compare_faces(image1_path, image2_path):
        """
        Compare deux images et retourne si les visages correspondent.
        """
        img1 = face_recognition.load_image_file(image1_path)
        img2 = face_recognition.load_image_file(image2_path)

        encodings1 = face_recognition.face_encodings(img1)
        encodings2 = face_recognition.face_encodings(img2)

        if not encodings1 or not encodings2:
            raise ValueError("Aucun visage détecté dans une des images")

        return face_recognition.compare_faces(
            [encodings1[0]], 
            encodings2[0], 
            tolerance=Config.FACE_COMPARISON_TOLERANCE
        )[0]