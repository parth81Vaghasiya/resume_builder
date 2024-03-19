import 'package:flutter/material.dart';

class AppColour {
  static const whiteColor = Color(0xFFFFFFFF);
  static const primaryColor = Color(0xFF007AFF);
  static const secondaryColor = Color(0xFF29323D);
  static const lightYellowColor = Color(0xfffcf0e0);
  static const blackColor = Color(0xff2d2d2d);
}

extension SizedBoxes on int {
  height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  width() {
    return SizedBox(
      width: toDouble(),
    );
  }
}
