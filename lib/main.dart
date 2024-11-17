import 'package:flutter/material.dart';
import 'get_started.dart';
import 'login.dart';
import 'home.dart';
import 'sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildWatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Minecraft', // Apply the Minecraft font globally
      ),
      initialRoute: '/get-started', // Set the initial route to GetStartedScreen
      routes: {
        '/get-started': (context) => const GetStartedScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
