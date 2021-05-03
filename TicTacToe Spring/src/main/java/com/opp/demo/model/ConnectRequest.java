package com.opp.demo.model;

public class ConnectRequest {
    private Player player;
    private int gameId;

    public ConnectRequest(Player p, int id) {
        player = p;
        gameId = id;
    }

    public int getGameId() {
        return gameId;
    }

    public Player getPlayer() {
        return player;
    }
}
