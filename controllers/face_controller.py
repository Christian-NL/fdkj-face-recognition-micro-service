from flask import jsonify
from services.face_service import FaceService
from utils.exception import InvalidRequestError, FaceDetectionError

class FaceController:
    @staticmethod
    def compare_faces(request):
        if 'image1' not in request.files or 'image2' not in request.files:
            raise InvalidRequestError("Veuillez fournir image1 et image2")

        try:
            is_same = FaceService.compare_faces(
                request.files['image1'],
                request.files['image2']
            )
            return bool(is_same)
            # return jsonify({"same_face": bool(is_same)})
        except ValueError as e:
            raise FaceDetectionError(str(e))