package com.example.demo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class DoorController {
    private boolean doorOpened = false;
    private volatile boolean doorRing = false;

    @PostMapping("/openDoor")
    public void ordenarAbrir() {
        doorOpened = true;
    }

    @GetMapping("/openDoor")
    public synchronized boolean consultarAbrir() {
        if (doorOpened) {
            doorOpened = false; // reset automático
            return true;
        }
        return false;
    }

    @PostMapping("/ring")
    public void pulsarTimbre() {
        doorRing = true;

        new Thread(() -> {
            try {
                Thread.sleep(5000); // 5 segundos
            } catch (InterruptedException e) {}
            doorRing = false;
        }).start();
    }

    @GetMapping("/ring")
    public boolean consultarTimbre() {
        return doorRing;
    }

    @GetMapping("/status")
    public String statusDoor() {
        return "Backend OK | Door: " + (doorOpened ? "Open" : "Closed") + " | Ring: " + (doorRing ? "Ringing" : "NO");
    }
}
