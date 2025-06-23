import 'package:flutter/material.dart';

class Helper {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.black, behavior: SnackBarBehavior.floating),
    );
  }
}
