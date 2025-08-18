package com.example.demo;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api")
public class DoorController {
    private boolean doorOpened = false;
    private volatile boolean doorRing = false;

    @PostMapping("/openDoor")
    public ResponseEntity<String> ordenarAbrir() {
        doorOpened = true;
        return ResponseEntity.ok("Puerta abierta satisfactoriamente");
    }

    @GetMapping("/openDoor")
    public synchronized ResponseEntity<Boolean> consultarAbrir() {
        if (doorOpened) {
            doorOpened = false; // reset automático
            return ResponseEntity.ok(true);
        }
        return ResponseEntity.ok(false);
    }

    @PostMapping("/ring")
    public ResponseEntity<String> pulsarTimbre() {
        doorRing = true;

        new Thread(() -> {
            try {
                Thread.sleep(5000); // 5 segundos
            } catch (InterruptedException e) {}
            doorRing = false;
        }).start();

        return ResponseEntity.ok("Timbre activado");
    }

    @GetMapping("/ring")
    public ResponseEntity<Boolean> consultarTimbre() {
        return ResponseEntity.ok(doorRing);
    }

    @GetMapping("/status")
    public ResponseEntity<String> statusDoor() {
        return ResponseEntity.ok("Backend OK | Door: " + (doorOpened ? "Open" : "Closed") + " | Ring: " + (doorRing ? "Ringing" : "NO"));
    }
}
