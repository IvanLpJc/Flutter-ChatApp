import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String navigationRoute;
  final String message;
  final String suggestion;

  const Labels({
    super.key,
    required this.navigationRoute,
    required this.message,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          message,
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, navigationRoute);
          },
          child: Text(
            suggestion,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
