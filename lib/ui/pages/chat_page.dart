import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static const String route = 'chat_page';
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            const SizedBox(
              height: 3,
            ),
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
              child: const Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'María',
              style: TextStyle(color: Colors.black87, fontSize: 10),
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  reverse: true,
                  itemCount: 100,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => Text('$index')),
            ),
            const Divider(
              height: 1,
            ),
            _inputChat()
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  //TODO I need to know when there is text
                },
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(child: Text('Send'), onPressed: () {})
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue[600],
                        ),
                        onPressed: () {},
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    print(text);
    _focusNode.requestFocus();
    _textController.clear();
  }
}
