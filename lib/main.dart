import 'package:flutter/material.dart';
import 'constants/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/app_navigation.dart';

void main() {
  runApp(const VeloryApp());
}

class VeloryApp extends StatelessWidget {
  const VeloryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Velory',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const AppNavigation(initialIndex: 0),
        '/my-routes': (context) => const AppNavigation(initialIndex: 1),
        '/favorites': (context) => const AppNavigation(initialIndex: 2),
        '/profile': (context) => const AppNavigation(initialIndex: 3),
        '/add-route': (context) => const AppNavigation(
          initialIndex: 0,
          showAddRoute: true,
        ),
      },
    );
  }
}
