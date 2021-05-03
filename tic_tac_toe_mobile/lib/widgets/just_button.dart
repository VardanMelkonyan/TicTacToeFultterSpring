import 'package:flutter/material.dart';

class JustButton extends StatelessWidget {
  final String title;
  final Text text;
  final Color color;
  final double width;
  final double height;
  final Function onPressed;

  const JustButton(
      {this.title,
      this.color,
      this.onPressed,
      this.text,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52,
      width: width ?? 200,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: color,
        child: Center(
          child: text == null
              ? Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              : text,
        ),
        onPressed: onPressed ??
            () {
              print(title);
            },
      ),
    );
  }
}
