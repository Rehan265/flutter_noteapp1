import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final double fontSize;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: title,
          hintStyle: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
