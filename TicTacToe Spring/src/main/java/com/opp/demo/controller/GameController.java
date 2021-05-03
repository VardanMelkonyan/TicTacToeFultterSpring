package com.opp.demo.controller;


import com.opp.demo.exceptions.InvalidParamException;
import com.opp.demo.model.ConnectRequest;
import com.opp.demo.model.Game;
import com.opp.demo.model.GamePlay;
import com.opp.demo.service.GameService;
import com.opp.demo.storage.GameStorage;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/game")
public class GameController {
    private final GameService gameService;
    private final SimpMessagingTemplate simpMessagingTemplate;

    public GameController(SimpMessagingTemplate simpMessagingTemplate) {
        this.simpMessagingTemplate = simpMessagingTemplate;
        this.gameService = new GameService();
    }

    @PostMapping("/start")
    public ResponseEntity<Game> start() {
        return ResponseEntity.ok(gameService.createGame());
    }

    @GetMapping("/check")
    public ResponseEntity<Boolean> checkIfTheGameExists(@RequestParam(value = "gameId", defaultValue = "0") int gameId) {
        return ResponseEntity.ok(gameService.gameExists(gameId));
    }

    @PostMapping("/connect")
    public ResponseEntity<Game> connectToGame(@RequestBody ConnectRequest request) throws InvalidParamException {
        System.out.println(request.getPlayer().getName() + ", " + request.getGameId());
        Game game = gameService.connectToGame(request.getPlayer(), request.getGameId());

        return ResponseEntity.ok(game);
    }


    @PostMapping("/play")
    public  ResponseEntity<Game> gamePlay(@RequestBody GamePlay gamePlay) throws InvalidParamException {
        Game game = gameService.gamePlay(gamePlay);
        return ResponseEntity.ok(game);
    }

}
