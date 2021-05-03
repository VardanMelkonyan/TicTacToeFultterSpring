import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_mobile/model/game.dart';
import 'package:tic_tac_toe_mobile/service/networking.dart';
import 'package:tic_tac_toe_mobile/service/storage.dart';
import 'package:tic_tac_toe_mobile/widgets/tic_tac_button.dart';

class GameScreen extends StatefulWidget {
  // final WebSocketChannel channel = IOWebSocketChannel.connect(
  //   Uri.parse('ws://localhost:8080/gameplay/topic/game-progress'),
  //   // Uri(scheme: "ws", host: "locahost", port: 8080, path: "/socket"),
  // );

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Game game = Storage.game;
  List board;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('game').doc('game').update({
      "player1": {"name": game.player1.name, "sign": game.player1.sign},
      "player2": {"name": game.player2.name, "sign": game.player2.sign},
      "gameId": game.gameId,
      "board0": game.board[0],
      "board1": game.board[1],
      "board2": game.board[2],
      "winner": game.winner == null
          ? null
          : {"name": game.winner.name, "sign": game.winner.sign}
    });
    board = game.board;
  }

  Future _onSubmit(int x, int y) async {
    Game g = await Networking.play(x, y);
    if (g != null) {
      FirebaseFirestore.instance.collection('game').doc('game').update({
        "player1": {"name": g.player1.name, "sign": g.player1.sign},
        "player2": {"name": g.player2.name, "sign": g.player2.sign},
        "gameId": g.gameId,
        "board0": g.board[0],
        "board1": g.board[1],
        "board2": g.board[2],
        "winner": g.winner == null
            ? null
            : {"name": g.winner.name, "sign": g.winner.sign}
      });
    }
    setState(() {
      if (g != null) {
        board = g.board;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Tic Tac Toe"),
      ),
      body: Center(
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance.collection('game').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot data = snapshot.data;

                board[0] = data.docs[0]["board0"] ?? board[0];
                board[1] = data.docs[0]["board1"] ?? board[0];
                board[2] = data.docs[0]["board2"] ?? board[0];
              }

              return Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TicTacButton(board[0][0], _onSubmit, 0, 0),
                        TicTacButton(board[0][1], _onSubmit, 0, 1),
                        TicTacButton(board[0][2], _onSubmit, 0, 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TicTacButton(board[1][0], _onSubmit, 1, 0),
                        TicTacButton(board[1][1], _onSubmit, 1, 1),
                        TicTacButton(board[1][2], _onSubmit, 1, 2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TicTacButton(board[2][0], _onSubmit, 2, 0),
                        TicTacButton(board[2][1], _onSubmit, 2, 1),
                        TicTacButton(board[2][2], _onSubmit, 2, 2),
                      ],
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('game')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                            snapshot.hasData
                                ? '${snapshot.data.docs.length}'
                                : 'No data',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
