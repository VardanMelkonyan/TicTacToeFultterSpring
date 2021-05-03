import 'package:flutter/material.dart';
import 'package:tic_tac_toe_mobile/model/game.dart';
import 'package:tic_tac_toe_mobile/screens/game.dart';
import 'package:tic_tac_toe_mobile/service/networking.dart';
import 'package:tic_tac_toe_mobile/service/storage.dart';

class Name extends StatefulWidget {
  final int gameId;

  Name({@required this.gameId});

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  Future<void> _submit(String name, BuildContext context) async {
    Game game = await Networking.connectToTheGame(name, widget.gameId);
    Storage.game = game;
    if (game != null)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameScreen()),
      );
    else
      print("Game is null: connection failed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_left,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              Center(
                  child: Column(
                children: [
                  Spacer(),
                  Text(
                    "Type your name:",
                    style: TextStyle(
                        color: Color(0xaaffffff),
                        fontSize: 24,
                        fontFamily: 'FredokaOne'),
                  ),
                  SizedBox(
                    width: 256,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onSubmitted: (name) => {_submit(name, context)},
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'FredokaOne',
                        fontSize: 36,
                      ),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "name",
                        hintStyle: TextStyle(
                            color: Color(0x99ffffff), fontFamily: 'FredokaOne'),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3)),
                        border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
