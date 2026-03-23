import 'package:flutter/material.dart';

class AppColors {
  // Strict Palette
  static const Color primaryBlue = Color(0xFF093FB4);
  static const Color white = Color(0xFFFFFCFB);
  static const Color softYellow = Color(0xFFFFD8D8);
  static const Color actionRed = Color(0xFFED3500);

  // Compatibility aliases used across existing screens/widgets
  static const Color warmOrange = softYellow;
  static const Color black = primaryBlue;
  static const Color darkGrey = primaryBlue;
  static const Color mediumGrey = Color(0xB3093FB4);
  static const Color lightGrey = softYellow;
  static const Color veryLightGrey = white;

  // Semantic aliases
  static const Color success = primaryBlue;
  static const Color warning = softYellow;
  static const Color error = actionRed;

  // Gradient - Safety Rating
  static const LinearGradient safetyRatingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softYellow, primaryBlue],
  );

  // Transparent variants
  static Color primaryBlueTransparent = primaryBlue.withValues(alpha: 0.12);
  static Color actionRedTransparent = actionRed.withValues(alpha: 0.12);
  static Color warmOrangeTransparent = warmOrange.withValues(alpha: 0.12);
  static Color softYellowTransparent = softYellow.withValues(alpha: 0.12);
}
