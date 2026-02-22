import 'package:flutter/material.dart';

class AppStyles {
  static TextStyle titleX({double size = 40, Color color = Colors.black}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle subText({double size = 40, Color color = Colors.black}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

}