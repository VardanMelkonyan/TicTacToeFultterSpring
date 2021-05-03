package com.opp.demo.service;


import com.opp.demo.exceptions.InvalidParamException;
import com.opp.demo.model.GamePlay;
import com.opp.demo.model.Player;
import com.opp.demo.model.Game;
import com.opp.demo.storage.GameStorage;
import org.springframework.stereotype.Service;

@Service
public class GameService {
    public Game createGame() {
        return new Game();
    }

    public boolean gameExists(int gameId) {
        return (GameStorage.getGame().getGameId() == gameId);
    }

    public Game connectToGame(Player player, int gameId) throws InvalidParamException {
        if (GameStorage.getGame().getGameId() == gameId) {
            if (GameStorage.getGame().getPlayer1() == null){
                player.setSign(1);
                GameStorage.getGame().setPlayer1(player);
                return GameStorage.getGame();
            }
            if (GameStorage.getGame().getPlayer2() == null){
                player.setSign(2);
                GameStorage.getGame().setPlayer2(player);
                return GameStorage.getGame();
            }
            throw new InvalidParamException("The Game is not valid anymore");
        }
        throw new InvalidParamException("GameID is invalid");
    }

    public Game gamePlay(GamePlay gamePlay) throws InvalidParamException {
        Game g = GameStorage.getGame();
        if (!(g.isTurn() ? g.getPlayer1() : g.getPlayer2()).equals(gamePlay.getPlayer()))
            throw new InvalidParamException("Not your turn buddy");
        if (g.board[gamePlay.getCoordinateX()][gamePlay.getCoordinateY()] == 0) {
            g.board[gamePlay.getCoordinateX()][gamePlay.getCoordinateY()] = gamePlay.getPlayer().getSign();
            g.check();
            g.nextPlayer();
            return GameStorage.getGame();
        }
        throw new InvalidParamException("The move already have been taken");
    }

    public Game getGame() {
        return GameStorage.getGame();
    }
}
