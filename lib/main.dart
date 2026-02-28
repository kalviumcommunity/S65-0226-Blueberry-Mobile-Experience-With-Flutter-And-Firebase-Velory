import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const SafeRouteApp());
}

class SafeRouteApp extends StatelessWidget {
  const SafeRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeRoute',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
