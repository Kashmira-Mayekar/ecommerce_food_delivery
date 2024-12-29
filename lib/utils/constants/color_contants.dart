import 'package:flutter/material.dart';

class ColorContants {
  // Solid Colors
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color accentColor = Color(0xFFFFD600);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6200EE), Color(0xFF03DAC6)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF03DAC6), Color(0xFFFFD600)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

// Add more gradients as needed for your application
}
