import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  final FocusNode? focusNode;
  final TextEditingController controller;
  const MyTextfield({
    super.key,
    required this.obscureText,
    required this.hintText,
    this.focusNode,
    this.keyboardType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
        ),
      ),
    );
  }
}
