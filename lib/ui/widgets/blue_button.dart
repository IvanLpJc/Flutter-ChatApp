import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  BlueButton({super.key, required this.text, this.onPressed});

  final ButtonStyle buttonStyle = TextButton.styleFrom(
      elevation: 2,
      foregroundColor: Colors.white,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const StadiumBorder());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (onPressed == null) {
            return Colors.grey;
          } else {
            return Colors.blue;
          }
        }),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
