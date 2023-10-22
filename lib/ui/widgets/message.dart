import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final String uuid;
  final AnimationController animationController;

  const Message(
      {super.key,
      required this.message,
      required this.uuid,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.elasticOut),
        child: Container(
          child: uuid == '123' ? _sentMessage() : _receivedMessage(),
        ),
      ),
    );
  }

  Widget _sentMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 8),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: const Color(0xff4d9ef6),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _receivedMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 8, right: 50),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: const Color(0xffe4e5e8),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
