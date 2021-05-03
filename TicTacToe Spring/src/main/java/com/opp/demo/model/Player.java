package com.opp.demo.model;

public class Player {
    private final String name;
    private int sign;

    public Player(String name, int sign) {
        this.name = name;
        this.sign = sign;
    }

    public Player(String name){
        this.name = name;
    }

    public void setSign(int sign) {
        this.sign = sign;
    }

    public String getName() {
        return name;
    }

    public int getSign() {
        return sign;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Player)) return false;

        Player player = (Player) o;

        if (sign != player.sign) return false;
        return name != null ? name.equals(player.name) : player.name == null;
    }
}
