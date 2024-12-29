import 'package:flutter/material.dart';

class TheamConstants {
  // Light theme
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    hintColor: Colors.orangeAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      elevation: 0, // removes shadow under app bar
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        textStyle: TextStyle(color: Colors.white),
      ),
    ),
    // Define other properties such as typography, icons, etc.
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.teal,
    hintColor: Colors.amberAccent,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        textStyle: TextStyle(color: Colors.white),
      ),
    ),
    // Define other properties for dark theme
  );

  // Method to get current theme based on a boolean flag (isDarkMode)
  static ThemeData getCurrentTheme(bool isDarkMode) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
