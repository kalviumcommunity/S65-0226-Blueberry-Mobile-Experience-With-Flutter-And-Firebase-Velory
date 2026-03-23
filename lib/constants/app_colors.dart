import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors - Strictly use only these
  static const Color primaryBlue = Color(0xFF3D45AA);      // Primary / Brand Blue
  static const Color actionRed = Color(0xFFDA3D20);        // Action Red
  static const Color warmOrange = Color(0xFFF8843F);       // Warm Orange
  static const Color softYellow = Color(0xFFFFF19B);       // Soft Yellow

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF333333);
  static const Color mediumGrey = Color(0xFF666666);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color veryLightGrey = Color(0xFFF5F5F5);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = actionRed;

  // Gradient - Safety Rating
  static const LinearGradient safetyRatingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [warmOrange, primaryBlue],
  );

  // Transparent variants
  static Color primaryBlueTransparent = primaryBlue.withOpacity(0.1);
  static Color actionRedTransparent = actionRed.withOpacity(0.1);
  static Color warmOrangeTransparent = warmOrange.withOpacity(0.1);
  static Color softYellowTransparent = softYellow.withOpacity(0.1);
}
