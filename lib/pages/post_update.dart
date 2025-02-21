import 'package:flutter/material.dart';
import 'package:post_api_app_flutter/model/updatemodel.dart';
import '../services/update_service.dart';

class PostUpdateScreen extends StatefulWidget {
  const PostUpdateScreen({super.key});

  @override
  State<PostUpdateScreen> createState() => _PostUpdateScreenState();
}

class _PostUpdateScreenState extends State<PostUpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  UpdateModel updatedData = UpdateModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: jobController,
              decoration: InputDecoration(
                hintText: "Job",
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreenAccent,
              ),
              onPressed: () {
                // Call the update service
                Updateservice().updatedata(nameController.text, jobController.text).then((value) {
                  setState(() {
                    updatedData = value!; // Update the data

                    // Navigate to a new screen and pass the updated data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(updatedData: updatedData), // Pass data here
                      ),
                    );
                  });
                });
              },
              child: Text(
                "Update",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateScreen extends StatelessWidget {
  final UpdateModel updatedData;

  // Constructor to accept the data passed from the previous screen
  UpdateScreen({required this.updatedData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Updated Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Name: ${updatedData.name}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Job: ${updatedData.job}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Updated At: ${updatedData.updatedAt}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
