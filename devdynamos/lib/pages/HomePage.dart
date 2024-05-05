import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseImageExample extends StatefulWidget {
  @override
  _FirebaseImageExampleState createState() => _FirebaseImageExampleState();
}

class _FirebaseImageExampleState extends State<FirebaseImageExample> {
  List<String> imageUrls = []; // List to store image URLs

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Fetch image URLs from Firebase Storage
    fetchImageUrls();
  }

  void fetchImageUrls() async {
    try {
      // Replace 'image/' with your actual path where images are stored
      final ListResult result =
          await FirebaseStorage.instance.ref('image/').listAll();
      final List<String> urls = [];
      for (final Reference ref in result.items) {
        final url = await ref.getDownloadURL();
        urls.add(url);
      }
      setState(() {
        imageUrls = urls;
      });
    } catch (error) {
      print('Error fetching image URLs: $error');
    }
  }

  Future<void> uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      try {
        final Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('image/${DateTime.now().millisecondsSinceEpoch}');
        await firebaseStorageRef.putFile(_image!);
        fetchImageUrls();
      } catch (error) {
        print('Error uploading image: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Image Example'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Upload Image'),
              onTap: () {
                uploadImage();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue, // Background color for the info container
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Devedyanomes application for winners',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: imageUrls.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          1, // Adjust the number of grid columns here
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Text('Error loading image');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
