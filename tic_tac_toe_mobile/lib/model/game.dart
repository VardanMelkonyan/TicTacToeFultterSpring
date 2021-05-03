import 'package:tic_tac_toe_mobile/model/player.dart';

class Game {
  Player player1;
  Player player2;
  int gameId;
  List board;
  Player winner;

  Game({this.player1, this.player2, this.board, this.gameId, this.winner});

  Map<String, dynamic> toMap() {
    return {
      "player1": {
        "name": player1.name,
        "sign": player1.sign,
      },
      "player2":
          player2 == null ? null : {"name": player2.name, "sign": player2.sign},
      "gameId": gameId,
      "board": board,
      "winner":
          winner == null ? null : {"name": winner.name, "sign": winner.sign},
    };
  }
}
