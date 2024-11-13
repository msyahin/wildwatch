import 'package:flutter/material.dart';
import 'get_started.dart'; // Import the GetStartedPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GetStartedPage(), // Set GetStartedPage as the home page
    );
  }
}
