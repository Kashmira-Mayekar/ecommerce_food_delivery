import 'package:flutter/material.dart';
import 'package:ecommerce_food_delivery/utils/constants/number_constants.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
///
class CustomTextStyles {
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: NumberConstants.d24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: NumberConstants.d18,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: NumberConstants.d16,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  // Add more text styles as needed for your application

  // Example of a method to create a custom TextStyle
  static TextStyle customTextStyle({
    double fontSize = NumberConstants.d14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    FontStyle? fontStyle,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
    );
  }
}
