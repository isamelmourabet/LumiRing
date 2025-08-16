package com.example.demo;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class DoorController {
    private boolean doorOpened = false;
    private boolean doorRing = false;

    @PostMapping("/openDoor")
    public String openDoor() {
        doorOpened = true;
        System.out.println("Door opened");
        return "Door opened.\n";
    }

    @GetMapping("openDoor")
    public boolean getDoor() {
        if (doorOpened) {
            doorOpened = false;
        } else {
            return true;
        }
        return false;
    }

    @PostMapping("/ring")
    public String ringDoor() {
        doorRing = true;
        System.out.println("Someone is ringing this door");
        return "Someone is ringing this door.\n";
    }

    @GetMapping("/ring")
    public boolean getRing() {
        if (doorRing) {
            doorRing = false;
        } else {
            return true;
        }
        return false;
    }

    @GetMapping("/status")
    public String statusDoor() {
        return "Backend OK | Door: " + (doorOpened ? "Open" : "Closed") + " | Ring: " + (doorRing ? "Ringing" : "NO");
    }
}
