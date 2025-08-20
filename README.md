# LumiRing  

Upgrade your **4+N intercom** with an external **Smart Device** ✨  

LumiRing lets you know when your doorbell rings — anywhere in the world!  
Receive instant notifications on your iPhone, talk to your visitor, and even open the door remotely. All of this without ever touching your intercom.  

---

## 🚪 What is LumiRing?  
LumiRing is a smart device that connects to your existing 4+N intercom system.  
It brings your old intercom to the modern era by adding:  
- 📲 **Mobile notifications** when someone rings.  
- 🎙 **Two-way audio** with your visitors.  
- 🔑 **Remote door unlock** from your iPhone.  
- 🌍 **Works anywhere** — not only when you’re at home.  

---

## 🛠 How it Works  
1. **Install** LumiRing next to your existing intercom.  
2. **Connect** it to your Wi-Fi network.  
3. **Control** everything from the LumiRing app (iOS).  

No need to replace your intercom or do major rewiring.  

---

## 📱 LumiRing App  
The LumiRing iOS app (built with **SwiftUI**) is your control center:  
- Modern and intuitive design.  
- Instant push notifications.  
- One-tap door opening.  

---

## 🧑‍💻 Build & Run  

This project has three main components: **Backend (Spring Boot)**, **iOS App (SwiftUI)**, and **Arduino/ESP32 Firmware**.  

### 🔙 Backend (Spring Boot)  
1. Clone the repository
   
2.	Build the project with Maven:
   ```bash
	./mvnw clean install
	```
4.	Run the server:
	```bash
	./mvnw spring-boot:run
	```

4.	The API will be available at:
  http://localhost:8080

### ⚡ Arduino / ESP32 Firmware
1.	Open the Arduino project:
  ```bash
  cd LumiRing/Lumi-EmbeddedSystem/LumiRing/
  open LumiRing.ino

---

2.	Install dependencies in the Arduino IDE:
	•	WiFi.h (for ESP32 Wi-Fi connection).
	•	HTTPClient.h (for REST calls).
	•	ArduinoJson (for JSON parsing).

3.	Select the board:
	•	Tools > Board > ESP32 Dev Module.

4.	Connect your ESP32 via USB.

5.	Upload the firmware (→ button in Arduino IDE).
---

## 🚧 Roadmap  
- [ ] Video streaming
- [ ] HomeKit integration   
- [ ] Android support  
- [ ] Multi-user access  
 

---

## 🤝 Contributing  
We’re building LumiRing openly — contributions are welcome!  
If you’d like to help, feel free to open an issue or a pull request.  

---

## 📜 License  
[MIT License](LICENSE)  
