import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:friend_private/utils/platform_utils.dart';

//TODO: switch to required named parameters
getDialog(
  BuildContext context,
  Function onCancel,
  Function onConfirm,
  String title,
  String content, {
  bool singleButton = false,
  String okButtonText = 'Ok',
  String cancelButtonText = 'Cancel',
}) {
  var actions = singleButton
      ? [
          TextButton(
            onPressed: () => onCancel(),
            child: Text(okButtonText, style: const TextStyle(color: Colors.white)),
          )
        ]
      : [
          TextButton(
            onPressed: () => onCancel(),
            child: Text(cancelButtonText, style: TextStyle(color: Colors.white)),
          ),
          TextButton(
              onPressed: () => onConfirm(), child: Text(okButtonText, style: const TextStyle(color: Colors.white))),
        ];
  if (PlatformUtils.isIOS) {
    return CupertinoAlertDialog(title: Text(title), content: Text(content), actions: actions);
  }
  return AlertDialog(title: Text(title), content: Text(content), actions: actions);
}
