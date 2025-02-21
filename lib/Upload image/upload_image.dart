import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_api_app_flutter/Upload%20image/imageservice.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String isImageUploaded = ""; // To store the uploaded image URL
  bool isLoading = false; // To track the upload status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text(
          "Upload Image",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to upload image
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    isLoading = true; // Start the loading process
                  });

                  Uint8List bytes = await image.readAsBytes();
                  UploadApiImage().uploadImage(bytes, image.name).then((value) {
                    setState(() {
                      isImageUploaded = value['location'].toString();
                      isLoading = false; // Stop loading after upload completes
                    });
                    print("Upload successful with link: ${value.toString()}");
                  }).onError((error, stackTrace) {
                    setState(() {
                      isLoading = false; // Stop loading on error
                    });
                    print("Error during upload: ${error.toString()}");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error uploading image!')));
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Upload Photo",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Show loading indicator while uploading
            if (isLoading)
              CircularProgressIndicator(),
            SizedBox(height: 20),
            // Display uploaded image if available
            if (isImageUploaded.isNotEmpty)
              Column(
                children: [
                  Text(
                    "Image Uploaded Successfully!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Image.network(isImageUploaded, width: 200, height: 200), // Display the uploaded image
                ],
              ),
          ],
        ),
      ),
    );
  }
}
