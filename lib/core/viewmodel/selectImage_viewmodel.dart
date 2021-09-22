import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SelectImageViewModel extends GetxController {
  File? imageFile;
  String? picUrl;

  cameraImage() async {
    final _pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 400,
      maxWidth: 400,
    );
    imageFile = File(_pickedFile!.path);
    update();
  }

  galleryImage() async {
    final _pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 400,
      maxWidth: 400,
    );
    imageFile = File(_pickedFile!.path);
    update();
  }

  uploadImageToFirebase() async {
    String _fileName = basename(imageFile!.path);
    Reference _firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profilePics/$_fileName');
    UploadTask _uploadTask = _firebaseStorageRef.putFile(imageFile!);
    picUrl = await (await _uploadTask).ref.getDownloadURL();
  }
}
