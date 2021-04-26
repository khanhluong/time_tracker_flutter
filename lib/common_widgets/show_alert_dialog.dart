import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<bool> showAlertDialog(BuildContext context,
    {@required String title,
    @required String content,
    String cancelActionText,
    @required String defaultActionContext}) {
  if (!Platform.isIOS) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(defaultActionContext),
                ),
                if (cancelActionText != null)
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(cancelActionText)),
              ],
            ));
  } else {
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(defaultActionContext),
                ),
                if (cancelActionText != null)
                  CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(cancelActionText)),
              ],
            ));
  }
}
