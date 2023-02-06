import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: theme.colorScheme.onSurfaceVariant.withAlpha(100)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: theme.colorScheme.onSurfaceVariant.withAlpha(50))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.primaryColor)),
            fillColor: theme.colorScheme.onInverseSurface,
            filled: true),
      ),
    );
  }
}
