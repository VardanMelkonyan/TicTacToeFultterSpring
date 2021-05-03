package com.opp.demo.storage;


import com.opp.demo.model.Game;

public class GameStorage {
    private static Game game;

    public static void setGame(Game game) {
        GameStorage.game = game;
    }

    public static Game getGame() {
        return game;
    }
}
