import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final bool obscureText;
  final TextInputType inputType;
  final IconData prefixIcon;
  final String placeholder;
  final TextEditingController textController;
  final bool showClearButton;

  const CustomInput(
      {super.key,
      required this.obscureText,
      required this.placeholder,
      this.inputType = TextInputType.text,
      required this.prefixIcon,
      required this.textController,
      this.showClearButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 5),
            blurRadius: 5)
      ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextField(
        autocorrect: false,
        keyboardType: inputType,
        controller: textController,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffixIcon: showClearButton
              ? IconButton(
                  icon: const Icon(
                    Icons.highlight_remove_outlined,
                    size: 20,
                  ),
                  onPressed: () => textController.clear(),
                )
              : null,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: placeholder,
        ),
      ),
    );
  }
}
