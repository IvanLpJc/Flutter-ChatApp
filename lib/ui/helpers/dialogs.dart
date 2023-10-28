import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context,
    {required String title, required String subtitle}) {
  if (!Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            MaterialButton(
              shape: const RoundedRectangleBorder(),
              onPressed: () => Navigator.pop(context),
              elevation: 5,
              textColor: Colors.blue,
              child: const Text('Dismiss'),
            ),
          ],
        );
      },
    );
  }

  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Dismiss'),
        ),
      ],
    ),
  );
}

showLoading(BuildContext context,
    {required String title, required String subtitle}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(),
          elevation: 0,
          child: Center(child: CircularProgressIndicator()),
        );
      });
}

hideLoading(
  BuildContext context,
) {
  Navigator.pop(context);
}
