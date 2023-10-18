import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: 170,
        child: Column(
          children: [
            Image.asset('assets/tag-logo.png'),
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
