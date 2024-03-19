import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilsForApp {
  static showToast({String? message, bool? isError = false}) {
    Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError! ? Colors.red : Colors.lightGreen,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
