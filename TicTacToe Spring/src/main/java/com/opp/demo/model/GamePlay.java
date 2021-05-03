package com.opp.demo.model;

public class GamePlay {
    private Player player;
    private int coordinateX;
    private int coordinateY;
    private int gameId;

    public GamePlay(Player player, int x, int y, int gameId) {
        this.player = player;
        this.coordinateX = x;
        this.coordinateY = y;
        this.gameId = gameId;
    }

    public int getCoordinateX() {
        return coordinateX;
    }

    public int getCoordinateY() {
        return coordinateY;
    }

    public Player getPlayer() {
        return player;
    }

    public int getGameId() {
        return gameId;
    }
}
