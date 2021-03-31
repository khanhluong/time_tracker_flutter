import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;

  const CustomRaisedButton(
      {this.color,
      this.borderRadius: 2.0,
      this.onPressed,
      this.child,
      this.height: 50.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
          child: child,
          color: color,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ))),
    );
  }
}
