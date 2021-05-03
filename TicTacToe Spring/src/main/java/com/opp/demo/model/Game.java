package com.opp.demo.model;


import com.opp.demo.storage.GameStorage;

public class Game {
    private Player player1;
    private Player player2;
    private int gameId;
    public  int[][] board;
    private Player winner;
    private int steps;
    private boolean turn;

    public Game() {
        turn = true;
        steps = 0;
        board = new int[3][3];
        gameId = (int) (Math.random() * 10000);
        GameStorage.setGame(this);
    }

    public Player getPlayer1() {
        return player1;
    }

    public Player getPlayer2() {
        return player2;
    }

    public Player getWinner() {
        return winner;
    }

    public void nextPlayer() {
        turn = !turn;
    }

    public void setPlayer1(Player player1) {
        this.player1 = player1;
    }

    public void setPlayer2(Player player2) {
        this.player2 = player2;
    }

    public int getGameId() {
        return gameId;
    }

    public boolean isTurn() {
        return turn;
    }

    public void check() {
        int winner = checkWinner();
        steps++;
        if ( winner != 0){
            GameStorage.getGame().winner = (winner == 1) ? player1 : player2;
        }
        if (steps == 9) {
            this.winner = new Player("Tie");
        }
    }

    private int checkWinner() {
        int i = 0;

        if (board[0][0] == board[1][1] &&  board[0][0] == board[2][2])
            return board[0][0];
        if (board[0][2] == board[1][1] &&  board[0][2] == board[2][0])
            return board[0][2];

        while(i < 3){
            int s = board[i][0];
            int same = 0;
            int j = 0;
            while (j < 3)
                if (s == board[i][j++])
                    same++;
            i++;
            if (same == 3)
                return s;
        }

        i = 0;
        while(i < 3){
            int s = board[0][i];
            int same = 0;
            int j = 0;
            while (j < 3)
                if (s == board[j++][i])
                    same++;
            i++;
            if (same == 3)
                return s;
        }

        return 0;
    }

}
