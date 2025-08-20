#include <WiFi.h>
#include <HTTPClient.h>

// ===== CONFIG WiFi =====
const char* ssid = "DIGIFIBRA-k3z2";
const char* password = "Mm916083616";

// ===== CONFIG BACKEND =====
const char* backendURLTimbre = "http://192.168.1.143:8080/api/ring";
const char* backendURLAbrir = "http://192.168.1.143:8080/api/openDoor";

// ===== PINES =====
const int pinRelePuerta = 26;
const int pinDeteccionTimbre = 33;
const int pinBuzzer = 25;

// ===== VARIABLES =====
unsigned long ultimoAvisoTimbre = 0;
const unsigned long tiempoEntreAvisos = 3000;
unsigned long ultimaConsultaPuerta = 0;
const unsigned long intervalConsultaPuerta = 2000;

void sonarBuzzer(int duracion) {
  digitalWrite(pinBuzzer, HIGH);
  delay(duracion);
  digitalWrite(pinBuzzer, LOW);
}

void abrirPuerta() {
  Serial.println("Abriendo puerta...");
  
  sonarBuzzer(200);
  delay(100);
  sonarBuzzer(200);
  
  digitalWrite(pinRelePuerta, LOW);
  delay(2500);
  digitalWrite(pinRelePuerta, HIGH);
  Serial.println("Puerta abierta y cerrada");
}

void enviarTimbre() {
  Serial.println("Enviando aviso de timbre...");
  
  sonarBuzzer(500);
  
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("WiFi desconectado");
    return;
  }
  
  HTTPClient http;
  http.begin(backendURLTimbre);
  http.setTimeout(5000);
  
  int httpResponseCode = http.POST("");
  
  if (httpResponseCode > 0) {
    Serial.printf("Timbre enviado - Código: %d\n", httpResponseCode);
    if (httpResponseCode == 200) {
      String response = http.getString();
      Serial.println("Respuesta: " + response);
    }
  } else {
    Serial.printf("Error timbre: %d\n", httpResponseCode);
  }
  
  http.end();
}

bool revisarAbrirPuerta() {
  if (WiFi.status() != WL_CONNECTED) {
    return false;
  }
  
  HTTPClient http;
  http.begin(backendURLAbrir);
  http.setTimeout(3000);
  
  int httpResponseCode = http.GET();
  bool abrir = false;
  
  if (httpResponseCode == 200) {
    String payload = http.getString();
    
    if (payload.indexOf("true") >= 0) {
      abrir = true;
    }
  } else if (httpResponseCode > 0) {
    Serial.printf("HTTP puerta: %d\n", httpResponseCode);
  }
  
  http.end();
  return abrir;
}

void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("Iniciando sistema timbre/puerta...");
  
  pinMode(pinRelePuerta, OUTPUT);
  digitalWrite(pinRelePuerta, HIGH);
  
  pinMode(pinDeteccionTimbre, INPUT_PULLUP);
  
  pinMode(pinBuzzer, OUTPUT);
  digitalWrite(pinBuzzer, LOW);
  
  Serial.println("Test buzzer...");
  sonarBuzzer(200);
  
  WiFi.begin(ssid, password);
  Serial.print("Conectando WiFi");
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println();
  Serial.println("WiFi conectado");
  Serial.println("IP: " + WiFi.localIP().toString());
  
  // Test inicial
  Serial.println("Probando backend...");
  delay(2000);
  
  Serial.println("Sistema listo");
  Serial.println("Esperando timbre...");
}

void loop() {
  int estadoTimbre = digitalRead(pinDeteccionTimbre);
  
  if (estadoTimbre == LOW) {
    unsigned long ahora = millis();
    
    if (ahora - ultimoAvisoTimbre > tiempoEntreAvisos) {
      Serial.println("¡TIMBRE DETECTADO!");
      Serial.println("Pin 33 = LOW (timbre activo)");
      
      enviarTimbre();
      ultimoAvisoTimbre = ahora;
    }
  }
  
  unsigned long ahora = millis();
  if (ahora - ultimaConsultaPuerta > intervalConsultaPuerta) {
    bool abrir = revisarAbrirPuerta();
    if (abrir) {
      Serial.println("¡Orden de abrir recibida!");
      abrirPuerta();
    }
    ultimaConsultaPuerta = ahora;
  }
  
  delay(100);
}