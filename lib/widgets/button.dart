import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPress;

  const Button(this.text, this.onPress, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFF181A18)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
