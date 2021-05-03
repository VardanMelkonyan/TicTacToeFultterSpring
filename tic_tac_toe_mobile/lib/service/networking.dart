import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tic_tac_toe_mobile/model/game.dart';
import 'package:tic_tac_toe_mobile/model/player.dart';
import 'package:tic_tac_toe_mobile/service/storage.dart';

class Networking {
  static final String _base = "http://localhost:8080/game";

  static Future<bool> checkIfGameExists(int gameId) async {
    var response = await http.get(Uri.parse('$_base/check?gameId=$gameId'));
    return jsonDecode(response.body);
  }

  static Future<Game> getGame() async {
    var response = await http.get(Uri.parse('$_base/get-game'));
    if (response.statusCode != 200) {
      print("getGame: ${response.statusCode}");
      return null;
    }
    print(response.body);
    var decodedData = jsonDecode(response.body);
    Game result = Game(
      player1: Player(decodedData["player1"]),
      player2: Player(decodedData["player2"]),
      board: decodedData["board"],
      gameId: decodedData["gameId"],
      winner: Player(decodedData["winner"]),
    );

    return result;
  }

  static Future<Game> connectToTheGame(String player, int gameId) async {
    String body = jsonEncode(
      <String, dynamic>{
        "player": {
          "name": player,
        },
        "gameId": gameId,
      },
    );
    print(body);
    var response = await http.post(
      Uri.parse('$_base/connect'),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );
    if (response.statusCode != 200) {
      print("connectToGame: ${response.statusCode}");
      return null;
    }
    print(response.body);
    var decodedData = jsonDecode(response.body);
    Game result = Game(
      player1: Player(decodedData["player1"]),
      player2: Player(decodedData["player2"]),
      board: decodedData["board"],
      gameId: decodedData["gameId"],
      winner: Player(decodedData["winner"]),
    );

    Storage.me =
        (result.player1.name == player) ? result.player1 : result.player2;
    return result;
  }

  static Future<Game> play(int x, int y) async {
    String body = jsonEncode(
      <String, dynamic>{
        "player": {
          "name": Storage.me.name,
          "sign": Storage.me.sign,
        },
        "coordinateX": x,
        "coordinateY": y,
        "gameId": Storage.game.gameId,
      },
    );
    print(body);
    var response = await http.post(
      Uri.parse('$_base/play'),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );
    if (response.statusCode != 200) {
      print("gamePlay: ${response.statusCode}");
      return null;
    }
    print(response.body);
    var decodedData = jsonDecode(response.body);
    Game result = Game(
      player1: Player(decodedData["player1"]),
      player2: Player(decodedData["player2"]),
      board: decodedData["board"],
      gameId: decodedData["gameId"],
      winner: Player(decodedData["winner"]),
    );
    Storage.game = result;

    return result;
  }
}
