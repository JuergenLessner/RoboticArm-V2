/* 
RoboarmControlV2 - Program V1.1
2015_08_30 copyright 2015 by Juergen Lessner
for Arduino MEGA

PINOUT
======
  
PCA9685 -> Arduino MEGA
-----------------------
VCC -> +5V
GND -> GND
SDA -> SDA_D20
SCL -> SCL_D21

Control Keyboard-> Arduino MEGA
---------------------------
1 -> D30
2 -> D32
3 -> D34
4 -> D31
5 -> D33
6 -> D35
7 -> D37
8 -> D39
9 -> D41
10 -> +5V
11 -> RX1_D19 (INT 4) 
11 -> 10k Ohms Resistor -> GND 
12 -> D36
12 -> 10k Ohms Resistor -> GND 
13 -> D38
13 -> 10k Ohms Resistor -> GND 
14 -> RST
15 -> GND

LCD1602 -> Arduino MEGA
------------------------
VCC -> +5V
GND -> GND
SDA -> SDA_D20
SCL -> SCL_D21

SD Card
Reader  -> Arduino MEGA
------------------
GND -> GND
VCC -> 5V
MISO -> D50
MOSI -> D51
SCK -> D52
CS -> D53

Other switches Arduino MEGA
--------------
D19 = speed switch 
D36 = programming mode
D38 = program replay mode
RST = reset Arduino

PCA9685 -> Servos 
-------------------
0 = Servo0 / baseturn axis
1 = Servos1 - (2 Servos) / shoulder axis
2 = Servo2 / ellbow axis
3 = Servo3 / wrist bow axis
4 = Servo4 / wrist spin axis
5 = Servo5 / fingers open - close
*/

// Libraries
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>
#include "Keypad.h"
#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <SD.h>

// DEBUG FLAG
int debugFlag = 0; // 1 = serialconsole debug mode


// Start declarations

// MIN MAX servopositions
#define SERVOMIN  100 // this is the 'minimum' pulse length count (out of 4096) - tested  MG 995 = 95 absolute HW min
#define SERVOMAX  455 // this is the 'maximum' pulse length count (out of 4096) - tested MG 995 = 460 absolute HW max

// MIN MAX positions 
// Claw open
#define S5MIN 180 // 200
// Claw closed
#define S5MAX 320 // 320

// Other servos MIN MAX
#define S4MIN 105
#define S4MAX 455
#define S3MIN 110
#define S3MAX 455
#define S2MIN 115
#define S2MAX 470
#define S1MIN 115
#define S1MAX 470
#define S0MIN 115
#define S0MAX 470

// Servo startposition
#define SERVODEF 277 // servos default

#define SERVO0DEF 470 // servo0 470
#define SERVO1DEF 283 // servo1 283
#define SERVO2DEF 292 // servo2 292
#define SERVO3DEF 270 // servo3 270
#define SERVO4DEF 105 // servo4 105
#define SERVO5DEF 300 // servo5 250


// ServoPosition varibles
int curr0Pos = SERVO0DEF;
int curr1Pos = SERVO1DEF;
int curr2Pos = SERVO2DEF;
int curr3Pos = SERVO3DEF;
int curr4Pos = SERVO4DEF;
int curr5Pos = SERVO5DEF;

// Servo variables / switches
boolean speedSwitch = 0; //0=defaulthighspeed, 1=lowspeed
boolean currSpeed = 0; // from repFile
int ServoPos = 0; // from repFile
int speedPin = 19;
int progPin = 38;
int replPin = 36;
int moveDone = 0;
int posDiff = 0;
boolean moveDirection = 0;

// Keyboard setup
const byte ROWS = 3; 
const byte COLS = 6; 

char keys[ROWS][COLS] =
 {{'A','B','C','D','E','F'},
 {'G','H','I','J','K','L'},
 {'M','N','O','P','Q','R'}};
 
byte rowPins[ROWS] = {30,32,34}; 
byte colPins[COLS] = {31,33,35,37,39,41}; 

int keyAstate = 0;
int keyBstate = 0;
int keyCstate = 0;
int keyDstate = 0;
int keyEstate = 0;
int keyFstate = 0;
int keyGstate = 0;
int keyHstate = 0;
int keyIstate = 0;
int keyJstate = 0;
int keyKstate = 0;
int keyLstate = 0;
int keyMstate = 0;
int keyNstate = 0;
/*
int keyOstate = 0;
int keyPstate = 0;
int keyQstate = 0;
int keyRstate = 0;
*/

// Physically switches
boolean proMode = 0; // physically switch
boolean repMode = 0; // physically switch

// Objects
Keypad keypad = Keypad( makeKeymap(keys), rowPins, colPins, ROWS, COLS );
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();
LiquidCrystal_I2C lcd(0x27,16,2);
File repFile;

// File
char rinData[3]; // read in Data from repFile
int delFile = 0;
boolean savePos = 0;
char writeString[21];
    int lineCount = 1;

// END declaration

void setup() {
  
  // DEBUG
  if (debugFlag == 1){
    Serial.begin(9600);
    Serial.println("Ready");
  }
  
  // Initialize LCD
  lcd.init(); 
  lcd.clear(); 
  lcd.backlight(); 
  lcd.print("RoboArm V2");
  lcd.setCursor(0,1);
  lcd.print("(c) 2015 JULE");
  delay(100);
  
  // Initialize servomodule
  pwm.begin();
  pwm.setPWMFreq(50);  // workingfreq MG995 50Hz
 
  // Initialize keyboard
  keypad.addEventListener(keypadEvent); //Event listener for keyboard
  keypad.setHoldTime(70);               // faster reaction by buttonpressing DEF is 1000mS
  keypad.setDebounceTime(50);           // buttondebounce  Default is 50mS
  
  // Initialize buttons
  pinMode(progPin,INPUT); //programming button
  pinMode(replPin,INPUT); // replay button
  pinMode(speedPin,INPUT);  //speedSwitch button
  attachInterrupt(4, setSpeed, FALLING); //LOW, HIGH, RISING, FALLING, CHANGE

  // init servos and set Servos to default position
  lcd.setCursor(0,0);
  lcd.print("init Servos...  ");
  
  pwm.setPWM(1, 0, SERVODEF);
  delay(500);
  pwm.setPWM(2, 0, SERVO2DEF);
  delay(500);
  pwm.setPWM(3, 0, SERVODEF);
  delay(500);
  pwm.setPWM(4, 0, SERVO4DEF);
  delay(500);
  pwm.setPWM(5, 0, SERVO5DEF);
  delay(500);
  pwm.setPWM(0, 0, SERVO0DEF); //turn base last because of centrifugal force
  delay(50);
  lcd.clear(); 

   
  // init SD
  if (!SD.begin(53)) {
    // DEBUG
    if (debugFlag == 1){  
      Serial.println("SD init fail");
    }
    lcd.print("SD init fail! ");
    delay(500); // wait for SD 
    return;
  }
    delay(100); // wait for SD 
    
   // read mode Switch   
  if(digitalRead(progPin) == 1) {
    proMode = 1;
    repMode = 0;
  }
  if ( digitalRead(replPin) == 1) {
    proMode = 0;
    repMode = 1;
  }  
}

void loop() {
  
  char key = keypad.getKey();
    // DEBUG
    if (debugFlag == 1){
      Serial.println(key);
    }

  if (delFile == 0){
    lcd.setCursor(0,1);
    if (repMode == 1 ){
      if(currSpeed == 0){
        lcd.print("H");
        } else{
          lcd.print("L");
          }
    }else{
          if(speedSwitch == 0){
            lcd.print("H");
            } else {
        lcd.print("L");
        }
    }
  }
  
  
  if (repMode == 1) {
    //REPLAYMODE
    // BEGIN REPLAY FUNKTION
    if (SD.exists("MEM.TXT")) {
      lcd.setCursor(2,1);
      lcd.print("Replay Mode   ");
      delay(200);
      lcd.setCursor(0,0);
       // DEBUG
      if (debugFlag == 1){
        Serial.println("Replay MEM.TXT Begin");
      }
        
      repFile = SD.open("MEM.TXT");
      repFile.seek(0); 
      delay(800);
        
      if(repFile) {
          while (repFile.available()) {
            rinData[0] = NULL;
            rinData[1] = NULL;
            rinData[2] = NULL;
            rinData[3] = NULL;
            rinData[0] = repFile.read();
            currSpeed = atoi(rinData);                 
            for (int m = 0; m < 6; m++){
              for (int n = 0; n < 3; n++){
                rinData[n]= repFile.read();
                delay(15);
              }
              ServoPos = atoi(rinData);

              if (delFile == 0){
                lcd.setCursor(0,1);
                if (currSpeed == 0){
                    lcd.print("H");
                }
                    else{
                    lcd.print("L");
                }
              }
              // moveservo here ...
              moveDone = gotoPos(m, ServoPos, currSpeed);
            }
            rinData[3] = repFile.read();
            rinData[3] = repFile.read();
          }
          repFile.close();
        }else{
            // DEBUG
            if (debugFlag == 1){
             Serial.println("File Error");
            }
           lcd.setCursor(0,0);
           lcd.print("File error");
           delay(500);
           return;
        }
        delay(50);
    } else {
      
      if (SD.exists("REP.TXT")) {
      lcd.setCursor(2,1);
      //lcd.print("Default Replay");
      lcd.print("Def Rep");
        delay(500);
        // DEBUG
        if (debugFlag == 1){
          Serial.println("Replay REP.TXT Begin");
        }
        repFile = SD.open("REP.TXT");
        delay(1000);
        if(repFile){
          while (repFile.available()) {
          rinData[0] = NULL;
          rinData[1] = NULL;
          rinData[2] = NULL;
          rinData[3] = NULL;
          rinData[0] = repFile.read();
          currSpeed = atoi(rinData);
          // DEBUG
          if (debugFlag == 1){
            Serial.print("currSpeed ");
            Serial.println(rinData[0]);
            Serial.println(currSpeed);
          }
          for (int m = 0; m < 6; m++){
            for (int n = 0; n < 3; n++){
              rinData[n]= repFile.read();
              delay(15);
            }
            ServoPos = atoi(rinData);
            
            // DEBUG
            if (debugFlag == 1){
              Serial.println("Record Replay");
            }

              if (delFile == 0){
                lcd.setCursor(0,1);
                if (currSpeed == 0){
                    lcd.print("H");
                }
                    else{
                    lcd.print("L");
                }
              }
              // moveservo here ...
              moveDone = gotoPos(m, ServoPos, currSpeed);
              lcd.setCursor(11,1);
              lcd.print("Z:");
              lcd.print(lineCount);
              lcd.print("  ");
              
          }
          lineCount++;
          rinData[3] = repFile.read();
          rinData[3] = repFile.read();
        }
        repFile.close();
        }else{
           lcd.setCursor(0,0);
           lcd.print("File error");
           delay(500);
           return;
        }
        delay(50);
      } else {
        //Kein File da
           lcd.setCursor(0,0);
           lcd.print("no recordfile...");
           lcd.setCursor(0,1);
           lcd.print("record it first!");
           delay(500);
           return;
      } 
   }   
   lineCount = 1;
   // ENDE REPLAY FUNKTION   
  } else {

    // KEYBOARD FUNKTION
         
    //calculating eventhandler infos
    // change move directions if necessary
          // dir def 1
    if(keyAstate == 2){
      curr0Pos = moveServo(0,1,curr0Pos);
    }
    if(keyBstate == 2){
      curr1Pos = moveServo(1,0,curr1Pos);//direction
    }
    if(keyCstate == 2){
      curr2Pos = moveServo(2,0,curr2Pos);//DIRECTION
    }
    if(keyDstate == 2){
      curr3Pos = moveServo(3,1,curr3Pos);
    }
    if(keyEstate == 2){
      curr4Pos = moveServo(4,1,curr4Pos);
    }
    if(keyFstate == 2){
      curr5Pos = moveServo(5,0,curr5Pos);//direction
    }
    // dir def 0
    if (keyGstate == 2){
      curr1Pos = moveServo(1,1,curr1Pos);//direction
    }
    if (keyHstate == 2){
      curr0Pos = moveServo(0,0,curr0Pos);
    }
    if (keyIstate == 2){
      curr2Pos = moveServo(2,1,curr2Pos);//DIRECTION
    }
    if (keyJstate == 2){
      curr3Pos = moveServo(3,0,curr3Pos); 
    }
    if (keyKstate == 2){
      curr5Pos = moveServo(5,1,curr5Pos);//direction
    }
    if (keyLstate == 2){
      curr4Pos = moveServo(4,0,curr4Pos);
    }
    if (keyMstate == 2){
      if (proMode == 1){          
         if (delFile == 0){
           delFile = 1;
         }
       }
     }
    if (keyNstate == 2){      
      //MEM nur aktiv  if (proMode == 1)
      savePos = 1;
      if (proMode == 1){
        if (delFile != 0){
          // DEL Mode
          delFile = 2;
        } else {
          //MEM Mode
         
        }
      }        
    }
    /*
    if (keyOstate == 2){
      // Not used
    }
    if (keyPstate == 2){
      // Not used
      
    }
    if (keyQstate == 2){
      // Not used
      
    }
    if (keyRstate == 2){
      // Not used   
    }
     */
      
    if (proMode == 1){
      // PROGRAMMMODE HIER FUNKTIONIERT DAS KEYBOARD + DEL + MEM Button
      if (delFile == 0){
        lcd.setCursor(2,1);
        lcd.print("Prog. Mode    ");
       } 
      if (delFile == 1){         
        lcd.setCursor(0,0);
        lcd.print("delete? pressMEM");
        lcd.setCursor(0,1);
        lcd.print("cancel? pressRST");
      }
       
        if (delFile == 2){
           // MEM.TXT löschen
          SD.remove("MEM.TXT");
          lcd.clear();
          lcd.print("file deleted    ");
          delay(1000);
          lcd.clear();
          delFile = 0;
          savePos = 0;
        }
        if (savePos == 1){
            repFile = SD.open("MEM.TXT", FILE_WRITE);
            delay(200);
            sprintf(writeString, "%d%d%d%d%d%d%d",currSpeed, curr0Pos, curr1Pos, curr2Pos, curr3Pos, curr4Pos, curr5Pos);
            repFile.println(writeString);
            delay(100);
            repFile.close();
            delay(100);
            lcd.clear();
            lcd.print("saving...");  
            delay(1000);   
            lcd.clear();
            lcd.print("Position saved");
            delay(500);
            lcd.clear();
            savePos = 0;  
        }      
    } else {
      //NORMALMODE only std keyboard works here!
        lcd.setCursor(2,1);
        lcd.print("Normal Mode   ");
      // END NORMALMODE
      
    } 
  }    
}

// moves servos to savedfile positions
int gotoPos(int servoNr, int newPos, int moveSpeed){
  
  int stepDelay = 100;
  int moveStep = 0;
  int oldPos = 0;
  int calcPos = 0;

  switch (servoNr) {
    case 0:
    moveStep = 10; //20
    if (newPos > S0MAX)
    {     
      newPos = S0MAX;
    }
    if (newPos < S0MIN)
    {     
      newPos = S0MIN;
    }
    oldPos = curr0Pos;
    curr0Pos = newPos;

    break;
    case 1:
    moveStep = 4; //10
    if (newPos > S0MAX)
    {     
      newPos = S0MAX;
    }
    if (newPos < S0MIN)
    {     
      newPos = S0MIN;
    }
    oldPos = curr1Pos;
    curr1Pos = newPos;
    
    break;
    case 2:
    moveStep = 8; //15
    if (newPos > S0MAX)
    {     
      newPos = S0MAX;
    }
    if (newPos < S0MIN)
    {     
      newPos = S0MIN;
    }
    oldPos = curr2Pos;
    curr2Pos = newPos;    
     
    break;    
    case 3:
    moveStep = 5; //25
    if (newPos > S0MAX)
    {     
      newPos = S0MAX;
    }
    if (newPos < S0MIN)
    {     
      newPos = S0MIN;
    }
    oldPos = curr3Pos;
    curr3Pos = newPos;    
      
    break;   
    case 4:
    moveStep = 25; //30
    if (newPos > S0MAX)
    {     
      newPos = S0MAX;
    }
    if (newPos < S0MIN)
    {     
      newPos = S0MIN;
    }
    oldPos = curr4Pos;
    curr4Pos = newPos;

    break;  
    case 5:
    moveStep = 20; //35
    if (newPos > S0MAX)
    {     
      newPos = S0MAX;
    }
    if (newPos < S0MIN)
    {     
      newPos = S0MIN;
    }
    oldPos = curr5Pos;
    curr5Pos = newPos;

    break;
  }
    
// varINFO
// newPos 
// oldPos
// servoNr
// moveStep
// moveDirection, 1 = + , 0 = -
// moveSpeed, 1 = low

  if (oldPos <= newPos)
  {
    moveDirection = 1; // Forward
  }else{
    moveDirection = 0; // Backward
  }

  if (moveSpeed == 1)
  {
    stepDelay = 10;
    moveStep = moveStep / 2;
    
    } else {
      stepDelay = 5;
      
      }
      
  calcPos = oldPos;
  if (oldPos != newPos){
  if (moveDirection == 1){
    calcPos = calcPos + moveStep;
    if (calcPos > newPos) {
      calcPos = newPos;
    }
    // DEBUG
    if (debugFlag == 1){
      Serial.println(" ");
      Serial.println(" ");
      Serial.print("OldP: ");
      Serial.println(oldPos);
      Serial.print(" NewP: ");
      Serial.println(newPos);
      Serial.print(" CurrP: ");
    }
    
      while (calcPos < newPos){
       //Info on LCD
       lcd.setCursor(0,0);
       lcd.print("Servo:");
       lcd.print(servoNr);
       lcd.print(" Pos:");
       lcd.print(calcPos);
       lcd.print(" ");
       
        pwm.setPWM(servoNr, 0, calcPos); //set position
        calcPos = calcPos + moveStep;
        if (calcPos > newPos) {
          calcPos = newPos;
        }
        delay(stepDelay);
      }
  }  else {
    
    calcPos = calcPos - moveStep;
    if (calcPos < newPos) {
      calcPos = newPos;
    }
    
    // DEBUG
    if (debugFlag == 1){
      Serial.println(" ");
      Serial.println(" ");
      Serial.print("OldP: ");
      Serial.println(oldPos);
      Serial.print(" NewP: ");
      Serial.println(newPos);
      Serial.print(" CurrP: ");
    }
    
     while (calcPos > newPos){
       //Info on LCD
       lcd.setCursor(0,0);
       lcd.print("Servo:");
       lcd.print(servoNr);
       lcd.print(" Pos:");
       lcd.print(calcPos);
       lcd.print(" ");
       
        pwm.setPWM(servoNr, 0, calcPos); //set position
        calcPos = calcPos - moveStep;
        if (calcPos < newPos) {
          calcPos = newPos;
        }
        delay(stepDelay);
      }   
     }
   }
   //Info on LCD
   lcd.setCursor(0,0);
   lcd.print("Servo:");
   lcd.print(servoNr);
   lcd.print(" Pos:");
   lcd.print(calcPos);
   lcd.print(" ");
   pwm.setPWM(servoNr, 0, newPos); // last step
   
   // DEBUG
   if (debugFlag == 1){
      Serial.print(" EndMove ");
      Serial.print(newPos);
      Serial.print("NewCommand: S:");
      Serial.print(servoNr);
      Serial.print(" nP:");
      Serial.print(newPos);
  }
  return 1;  
}

//moves the servos in normalmode N and programming mode P
int moveServo(int servoNr, int servoDirection, int currPos){
 //servospeed
  int currSpeed;
  int servoMax = SERVOMAX;
  int servoMin = SERVOMIN;
  int stepDelay;
  
  if (speedSwitch == 1){
    stepDelay = 10;
    switch (servoNr) {
    case 0:
      currSpeed = 1;
      servoMax = S0MAX;
      servoMin = S0MIN;
    break;
    case 1:
      currSpeed = 2;
      servoMax = S1MAX;
      servoMin = S1MIN;
    break;
    case 2:
      currSpeed = 3;
      servoMax = S2MAX;
      servoMin = S2MIN;
    break;
    case 3:
      currSpeed = 3;
      servoMax = S3MAX;
      servoMin = S3MIN;
    break;
    case 4:
      currSpeed = 10;
      servoMax = S4MAX;
      servoMin = S4MIN;
    break;
    case 5:
      currSpeed = 3;
      servoMax = S5MAX;
      servoMin = S5MIN;
    break;
    }
  }
  else{
    stepDelay = 0;
    switch (servoNr) {
    case 0:
      currSpeed = 10;
      servoMax = S0MAX;
      servoMin = S0MIN;
    break;
    case 1:
      currSpeed = 4;
      servoMax = S1MAX;
      servoMin = S1MIN;
    break;
    case 2:
      currSpeed = 8;
      servoMax = S2MAX;
      servoMin = S2MIN;
    break;
    case 3:
      currSpeed = 12;
      servoMax = S3MAX;
      servoMin = S3MIN;
    break;
    case 4:
      currSpeed = 25;
      servoMax = S4MAX;
      servoMin = S4MIN;
    break;
    case 5:
      currSpeed = 10;
      servoMax = S5MAX;
      servoMin = S5MIN;
    break;
    }
  }
  if (servoDirection == 1){
    currPos = currPos + currSpeed;
    if (currPos > servoMax){currPos = servoMax;}
  }
  if (servoDirection == 0){
    currPos = currPos - currSpeed;
    if (currPos < servoMin){currPos = servoMin;}
  }
  
   pwm.setPWM(servoNr, 0, currPos); //set position
   lcd.setCursor(0,0);
   lcd.print("Servo:");
   lcd.print(servoNr);
   lcd.print(" Pos:");
   lcd.print(currPos);
   lcd.print(" ");
   delay(stepDelay);
   return currPos;  
}  

// Eventhandler from keyboard
void keypadEvent(KeypadEvent key){
  switch (keypad.getState()){
    case PRESSED:
         // do nothing here!
    break;
    
 case RELEASED:
        switch (key){
          case 'A': 
            keyAstate = 3; 
          break;
          case 'B': 
            keyBstate = 3; 
          break;
          case 'C': 
            keyCstate = 3; 
          break;
          case 'D': 
            keyDstate = 3; 
          break;
          case 'E': 
            keyEstate = 3; 
          break;
          case 'F': 
            keyFstate = 3; 
          break;
          case 'G':
            keyGstate = 3;
          break;
          case 'H': 
            keyHstate = 3; 
          break;
          case 'I': 
            keyIstate = 3; 
          break;
          case 'J': 
            keyJstate = 3; 
          break;
          case 'K': 
            keyKstate = 3; 
          break;
          case 'L': 
            keyLstate = 3; 
          break;
          case 'M': 
            keyMstate = 3; 
          break;
          case 'N': 
            keyNstate = 3; 
          break;
          
       break;
      }
    break;
    
    case HOLD:
        switch (key){
          case 'A': 
            keyAstate = 2;
          break;
          case 'B': 
            keyBstate = 2;
          break;
          case 'C': 
            keyCstate = 2;
          break;
          case 'D': 
            keyDstate = 2; 
          break;
          case 'E': 
            keyEstate = 2; 
          break;
          case 'F': 
            keyFstate = 2; 
          break;
          case 'G': 
            keyGstate = 2;
          break;
          case 'H': 
            keyHstate = 2;
          break;
          case 'I': 
            keyIstate = 2;
          break;
          case 'J': 
            keyJstate = 2;
          break;
          case 'K': 
            keyKstate = 2;
          break;
          case 'L': 
            keyLstate = 2; 
          break;
          case 'M': 
            keyMstate = 2; 
          break;
          case 'N': 
            keyNstate = 2; 
          break;
          /*
          case 'O': Serial.println("O hold");
            keyOstate = 2; 
          break;
          case 'P': Serial.println("P hold");
            keyPstate = 2; 
          break;
          case 'Q': Serial.println("Q hold");
            keyQstate = 2; 
          break;
          case 'R': Serial.println("R hold");
            keyRstate = 2; 
          break;  
          */        
      }
    break;
  }
} 

//setSpeed from interrupt 4 / Pin D19
void setSpeed(){
  if (speedSwitch == 0)
  {
    if(repMode == 0){
        speedSwitch = 1;
      }
  }
  else{
    if(repMode == 0){
        speedSwitch = 0;
      }
  }
}


