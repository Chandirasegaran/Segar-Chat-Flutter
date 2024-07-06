import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageService() {}
  Future<String?> uploadUserProfilePic(
      {required File file, required String userId}) async {
    Reference fileRef = _firebaseStorage
        .ref('users/user_profile_pics')
        .child('$userId${p.extension(file.path)}');
    UploadTask uploadTask = fileRef.putFile(file);
    return uploadTask.then(
      (p) {
        if (p.state == TaskState.success) {
          return fileRef.getDownloadURL();
        }
      },
    );
  }
}
