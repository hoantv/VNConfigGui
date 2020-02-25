#include <EEPROM.h>
// Wiring/Arduino code:
// Read data from the serial and turn ON or OFF a light depending on the value

//char val; // Data received from the serial port
int ledPin = 3; // Set the pin to digital I/O 4
int addr = 0; //index effrom

uint16_t xThressHold[6] = {0, 0, 0, 0, 0, 0};
uint16_t yThressHold[4] = {0, 0, 0, 0};
char ascArray[20] = "";
String txtMsg = "";

void setup() {
  pinMode(ledPin, OUTPUT); // Set pin as OUTPUT  
  xThressHold[0] = EEPROMReadInt(addr);
  xThressHold[1] = EEPROMReadInt(addr+2);
  xThressHold[2] = EEPROMReadInt(addr+4);
  xThressHold[3] = EEPROMReadInt(addr+6);
  xThressHold[4] = EEPROMReadInt(addr+8);
  xThressHold[5] = EEPROMReadInt(addr+10);
  yThressHold[0] = EEPROMReadInt(addr+12);
  yThressHold[1] = EEPROMReadInt(addr+14);
  yThressHold[2] = EEPROMReadInt(addr+16);
  yThressHold[3] = EEPROMReadInt(addr+18);
  
  Serial.begin(9600); // Start serial communication at 9600 bps
}


void loop() {
  String txtMsg = "";
  while (Serial.available() > 0) {
     txtMsg += (char)Serial.read();
  }
  if (txtMsg[0] == 'W') { // If H was received
    digitalWrite(ledPin, HIGH); // turn the LED on
    Serial.write("Shifter:");
    Serial.write(dtostrf(xThressHold[0], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(xThressHold[1], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(xThressHold[2], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(xThressHold[3], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(xThressHold[4], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(xThressHold[5], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(yThressHold[0], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(yThressHold[1], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(yThressHold[2], 4, 0, ascArray));
    Serial.write(":");
    Serial.write(dtostrf(yThressHold[3], 4, 0, ascArray));
  } else if (txtMsg[0]== 'X' && txtMsg[1] == '0') {
    xThressHold[0] = txtMsg.substring(2).toInt();   
     EEPROMWriteInt(addr, xThressHold[0]);
  }  else if (txtMsg[0]== 'X' && txtMsg[1] == '1') {
     xThressHold[1] = txtMsg.substring(2).toInt(); 
     EEPROMWriteInt(addr+2, xThressHold[1]); 
  }
   else if (txtMsg[0]== 'X' && txtMsg[1] == '2') {
     xThressHold[2] = txtMsg.substring(2).toInt();  
      EEPROMWriteInt(addr+4, xThressHold[2]); 
  }
   else if (txtMsg[0]== 'X' && txtMsg[1] == '3') {
     xThressHold[3] = txtMsg.substring(2).toInt();  
    EEPROMWriteInt(addr+6, xThressHold[3]); 
  }
   else if (txtMsg[0]== 'X' && txtMsg[1] == '4') {
     xThressHold[4] = txtMsg.substring(2).toInt(); 
     EEPROMWriteInt(addr+8, xThressHold[4]);  
  }
   else if (txtMsg[0]== 'X' && txtMsg[1] == '5') {
     xThressHold[5] = txtMsg.substring(2).toInt();  
      EEPROMWriteInt(addr+10, xThressHold[5]); 
  }  
  else if (txtMsg[0]== 'Y' && txtMsg[1] == '0') {
     yThressHold[0] = txtMsg.substring(2).toInt();  
      EEPROMWriteInt(addr+12, yThressHold[0]); 
  }
  else if (txtMsg[0]== 'Y' && txtMsg[1] == '1') {
     yThressHold[1] = txtMsg.substring(2).toInt();  
     EEPROMWriteInt(addr+14, yThressHold[1]); 
  }
  else if (txtMsg[0]== 'Y' && txtMsg[1] == '2') {
     yThressHold[2] = txtMsg.substring(2).toInt(); 
     EEPROMWriteInt(addr+16, yThressHold[2]);  
  }
  else if (txtMsg[0]== 'Y' && txtMsg[1] == '3') {
     yThressHold[3] = txtMsg.substring(2).toInt();  
     EEPROMWriteInt(addr+18, yThressHold[3]); 
  }

//  for (int j = 0; j< 10; j++) {
//     Serial.print("j = ");
//     Serial.print(j);
//     Serial.print(": ");
//    Serial.println(EEPROM.read(j));
//  }
   digitalWrite(ledPin, LOW); // turn the LED on

  //  delay(1000); // Wait 100 milliseconds for next reading
  //   Serial.write(1);
  ////  Serial.write(700);
}

void EEPROMWriteInt(int address, int value)
{
  byte two = (value & 0xFF);
  byte one = ((value >> 8) & 0xFF);
  
  EEPROM.update(address, two);
  EEPROM.update(address + 1, one);
}
 
int EEPROMReadInt(int address)
{
  long two = EEPROM.read(address);
  long one = EEPROM.read(address + 1);
 
  return ((two << 0) & 0xFFFFFF) + ((one << 8) & 0xFFFFFFFF);
}
