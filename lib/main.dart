import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/responsive_home.dart';

void main() {
  runApp(const VeloryApp());
}

class VeloryApp extends StatelessWidget {
  const VeloryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Velory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ResponsiveHome(),
    );
  }
}
