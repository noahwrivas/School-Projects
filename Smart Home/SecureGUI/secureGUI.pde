/*
             Secure++ GUI 
 Author:     David Bone
 Modified:   April 27, 2019 at 10:30 am
 
 
 */
import processing.serial.*;
import processing.io.*;
import processing.sound.*;
import java.awt.Robot;
import java.awt.AWTException;

boolean onPi = true; //change this depending on system

Serial port;


//PINS
//moved to json setup
int relay1Pin, relay2Pin;
int buzzerPin;
int smokePin;
int reedPin;



PFont mono;

PShape gear;

//Logic
boolean armed = false;
boolean smokeAlarm = false;
boolean doorAlarm = false;
boolean lastPressed=false;
boolean mouseReleased=false;
boolean darkTheme = true;
boolean doorOpen = false;
boolean setState = false;
boolean relay1 = false, relay2 = false;
boolean inCount1 = false, inCount2 = false;
boolean lastReed = false; 

int countdown2 = 0;
boolean disarmClicked = false; 

long openTime = 0;
long prevSec = 0;

int menuState=1, menuHover=1;
int spacing = 36;
int attempts = 3;

color bg_color=0;
color buttonColor = 150;
color hoverColor = 100;
color textColor = 255;
color tlColor=buttonColor, trColor=buttonColor, blColor=buttonColor, brColor=buttonColor;
color backColor=buttonColor;

String fontStr;
String myPass = "";
String passEntry = "";
String zipcode; 
int inByte;
String inString;

float updateFreq = 1; //minutes between openWeatherAPI call
long lastAPIcall = 0;
long armTime = 0;
long armTimer = 30; //seconds for timer to leave house
long prevMillis = 0;
int debounce = 200;
int countdown;
float temperature = 0;
int tempInt = 0;

long pollTimer = 10000; //10 sec temperature update frequency
long lastPoll = -10000; // start at -10000 so we get a poll right away




Robot mouseMover;

JSONObject json;

void settings()
{
  json = loadJSONObject("config.json");

  //load settings from disk
  onPi = json.getBoolean("onPi");
  relay1Pin = json.getInt("relay1Pin");
  relay2Pin = json.getInt("relay2Pin");
  smokePin = json.getInt("smokePin");
  reedPin = json.getInt("reedPin");
  myPass = json.getString("myPass");
  fontStr = json.getString("fontStr");
  zipcode = json.getString("zipcode");
  debounce = json.getInt("debounce");

  if (onPi) //setup on PI
  {
    fullScreen();
    //noCursor();

    port = new Serial(this, Serial.list()[0], 9600);//start a serial port on baud:9600


    // UNCOMMENT ON PI
    GPIO.pinMode(reedPin, GPIO.INPUT);
    GPIO.pinMode(smokePin, GPIO.INPUT);
    GPIO.attachInterrupt(smokePin, this, "smokeFound", GPIO.FALLING);
    GPIO.pinMode(relay1Pin, GPIO.OUTPUT);
    GPIO.pinMode(relay2Pin, GPIO.OUTPUT);

    try
    {
      mouseMover = new Robot(); //for moving mouse
    } 
    catch (AWTException e) //if errror occurs, kill program
    {
      exit();
    }
  } else //setup for debugging
  {
    size(800, 480);
  }
}



void setup()
{
  //setup for all systems




  gear = loadShape("gear.svg");
  mono=createFont(fontStr, 32); 
  noCursor();

  if (darkTheme)
  {
    buttonColor = color(0, 50, 120);
    hoverColor = color(0, 29, 69);
    textColor = color(221, 221, 221);
    bg_color = 0;
  } else
  {
    buttonColor = 235;
    hoverColor = 200;
    textColor = color(0, 0, 0);
    bg_color = 255;
  }
  
  //get some weather data here to inc performance later
  //note this will slow down start up...
  parseFile(zipcode);
  
}
//interupt routine, just route menu to smoke detected menu
void smokeFound(int pin)
{
  smokeAlarm = true;
  menuState = 911;
}


void draw()
{
  mouseReleased = (lastPressed && !mousePressed); //must be in beginning of draw();
  //if using pi and mouse released (i.e. finger lifted)
  if (onPi) 
    if (mouseReleased) 
      mouseMover.mouseMove(0, 0);

  

  background(bg_color);
  textFont(mono);


  if (smokeAlarm==true)
  {
  }

  if (onPi)
  {
    if (millis()-lastPoll>pollTimer)
    {
      lastPoll = millis();

      port.write(1); // poll serial device

      while (port.available() > 0)
      {
        inString = port.readString();
        println(inString);
        temperature = float(trim(inString)); 
              //convert to farenheit
        temperature = ((temperature*9)/5)+32;
        tempInt = (int)temperature;

      }

      //Here we should timestamp and save data
    }
  }


  switch(menuState)//draw current menu
  {
  case 0:

    break;
  case 1:
    mainMenu();
    break;
  case 2:
    securityMenu();
    break;
  case 21:
    keyPad();
    break;
  case 22:
    securityBreach();
    break;
  case 23:
    securityPreferences();
    break;
  case 24:
    updatePasscode();
    break;
  case 25:
    disarmMenu();
    break;
  case 26:
    setDoorTiming();
    break;
  case 3: 
    thermMenu();
    break;
  case 4:
    weatherMenu();
    break;
  case 41:
    weatherPreferences();
    break;
  case 42:
    updateZip();
    break;
  case 43:
    setWeatherInterval();
    break;
  case 5:
    applianceMenu();
    break;
  case 6:
    settingsMenu();
    break;
  case 61:
    fontMenu();
    break;
  case 62:
    setPollTimer();
    break;


  case 911: //smoke Alarm
    smokeAlarm();
    break;
  }
  lastPressed = mousePressed; //must be at end of draw()
}

void mousePressed()
{
}
