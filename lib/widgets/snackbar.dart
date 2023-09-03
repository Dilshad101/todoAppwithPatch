import 'package:flutter/material.dart';

showSnackBarMessenger(
    {required BuildContext context,
    required String msg,
    required Color color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        msg,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}
