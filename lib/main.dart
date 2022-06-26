// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_equal_for_default_values, invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: MyPage()));
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var imageFile;

  _pickfromGallery(BuildContext context) async {
    var pictureFile = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);

    setState(() {
      imageFile = File(pictureFile!.path);
    });
    Navigator.of(context).pop();
  }

  _pickfromCamera(BuildContext context) async {
    var pictureFile = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.camera);

    setState(() {
      imageFile = File(pictureFile!.path);
    });
    Navigator.of(context).pop();
  }

  Widget displayImage() {
    if (imageFile == null) {
      return Text("No Image Selected");
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Image.file(imageFile),
      );
    }
  }

  Future imagepickerdialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose the image source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                InkWell(
                  onTap: () {
                    _pickfromGallery(context);
                  },
                  child: Text("Gallery"),
                ),
                Padding(padding: EdgeInsets.all(8)),
                InkWell(
                  onTap: () {
                    _pickfromCamera(context);
                  },
                  child: Text("Camera"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            displayImage(),
            ElevatedButton(
                onPressed: () {
                  imagepickerdialogue(context);
                },
                child: Text("Pick Image"))
          ],
        ),
      ),
    );
  }

  /// Get from gallery
}
