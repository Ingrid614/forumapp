import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget{
  const InputWidget({super.key, required this.hintText, required this.controller, required this.obscureText});

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20)
            ),
      ),
    );
  }
}