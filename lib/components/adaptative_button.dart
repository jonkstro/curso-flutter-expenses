import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: () {
              onPressed();
            },
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            child: Text(label),
            onPressed: () {
              onPressed();
            },
          );
  }
}
