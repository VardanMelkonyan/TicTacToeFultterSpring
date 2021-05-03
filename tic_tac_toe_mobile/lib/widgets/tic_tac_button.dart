import 'package:flutter/material.dart';

class TicTacButton extends StatelessWidget {
  final int sign;
  final Function onPressed;
  final int x;
  final int y;

  TicTacButton(this.sign, this.onPressed, this.x, this.y);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.white,
        width: 100,
        height: 100,
        child: TextButton(
          child: Text(
            sign == 0
                ? ""
                : sign == 1
                    ? "X"
                    : sign == 2
                        ? "O"
                        : " ",
            style: TextStyle(color: Colors.black, fontSize: 50),
          ),
          onPressed: () {
            onPressed(x, y);
          },
        ),
      ),
    );
  }
}
