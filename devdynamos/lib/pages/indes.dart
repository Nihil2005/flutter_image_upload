import 'package:devdynamos/pages/HomePage.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.black], // Change colors as needed
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome to DevDynamos",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirebaseImageExample(),
                    ));
                // Add navigation to the "Read More" page
              },
              style: ElevatedButton.styleFrom(
                // Text color
                elevation: 5, // Elevation, controls shadow
                shape: RoundedRectangleBorder(
                  // Button border shape
                  borderRadius: BorderRadius.circular(10),
                  // You can customize border side if needed
                  // side: BorderSide(color: Colors.black, width: 2),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 15, horizontal: 30), // Button padding
              ),
              child: Text("Get Start"),
            ),
          ],
        ),
      ),
    );
  }
}
