import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaServices {
  final ImagePicker _picker = ImagePicker();
  MediaServices() {}

  Future<File?> getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
