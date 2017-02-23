/*

      CÓDIGO ARDUINO PARA FUNCIONAMENTO DO BOTÃO 

*/

int switchPin = 4;  // Define para a ultilização da porta 4 no arduino
 
void setup() { 
  pinMode(switchPin, INPUT);  // Seta o pino 4 como Imput, ou seja, entrada
  Serial.begin(9600);         // Inicia a comunicação com o serial do programa
} 
 
void loop() { 
  if (digitalRead(switchPin) == HIGH) {  // Se o switch estiver com estado igual a ON
    Serial.write(1);                     // Mandará 1 ao  Processing
  } else {                               // Se o  switch Não estiver com estado ON ,
    Serial.write(0);                     // Mandará 0 to ao processing
  } 
  delay(100);                            // Parada de 100 milisegundos 
} 
