// Importing necessary packages
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

// ImageUploadService class definition
class ImageUploadService {
  final ImagePicker _picker = ImagePicker();

  // Method to pick and upload image
  Future<void> pickAndUploadImage(CollectionReference messagesCollection) async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      File image = File(imageFile.path);
      await _uploadImage(image, messagesCollection);
    }
  }

  // Method to upload image to Firebase Storage
  Future<void> _uploadImage(File image, CollectionReference messagesCollection) async {
    try {
      String filePath = 'images/${FirebaseAuth.instance.currentUser!.uid}/${DateTime.now()}.png';
      UploadTask uploadTask = FirebaseStorage.instance.ref().child(filePath).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Adding image message to Firestore
      messagesCollection.add({
        'senderId': FirebaseAuth.instance.currentUser!.uid,
        'text': '',
        'imageUrl': downloadUrl,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}
