// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:lost_item_recovery_network/constants/colors.dart';

// PostItemScreen class definition
class PostItemScreen extends StatefulWidget {
  @override
  _PostItemScreenState createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      final XFile? imageFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        setState(() {
          _image = File(imageFile.path);
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  // Method to upload the item
  Future<void> _uploadItem() async {
    if (_descriptionController.text.isNotEmpty && _image != null) {
      try {
        String filePath =
            'lost_items/${FirebaseAuth.instance.currentUser!.uid}/${DateTime.now().millisecondsSinceEpoch}.png';
        UploadTask uploadTask =
            FirebaseStorage.instance.ref().child(filePath).putFile(_image!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('lost_items').add({
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'description': _descriptionController.text,
          'imageUrl': downloadUrl,
          'timestamp': Timestamp.now(),
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Item posted successfully')));
        _descriptionController.clear();
        setState(() {
          _image = null;
        });
      } catch (e) {
        print('Error posting item: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error posting item: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide a description and an image')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(primaryColor),
      appBar: AppBar(
        title: Text('Post Lost Item', style: TextStyle(color: HexColor(textColor))),
        backgroundColor: HexColor(secondaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description', 
                labelStyle: TextStyle(color: HexColor(secondaryColor)),
              )
            ),
            SizedBox(height: 10),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 150),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image', style: TextStyle(color: HexColor(secondaryColor))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadItem,
              child: Text('Post Item', style: TextStyle(color: HexColor(secondaryColor))),
            ),
          ],
        ),
      ),
    );
  }
}
