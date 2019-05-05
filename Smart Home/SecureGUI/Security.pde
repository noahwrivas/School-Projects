void securityMenu()//2
{
  noStroke();
  
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
  fillDate();
  
  //boundaries of main menu items
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  float botLeftX=width-width*.95, botLeftY=height-height*0.4;
  float botRightX=width-width*.5, botRightY=height-height*0.4;
  
  
 
  if(makeBooleanButtonLink("ARM",25,buttonColor,hoverColor,(int)topLeftX, (int)topLeftY, (int)(2*boxX+spacing),(int)boxY, 10))
  {
    armTime = millis();
    armed = true;
    inCount1 = true;
  }


  makeButtonLink("back", 1, buttonColor, hoverColor, 50, 400, 200, 60, 10);
  makeButtonLink("Preferences", 23, buttonColor, hoverColor, (int)botRightX, (int)botRightY, (int)boxX, (int)boxY, 10);  
  
  
}

boolean secondTimer = false;

void getDisarm() //abstracted request for user entry to disarm
                 //success: armed is false, and return to main menu
                 //fail:    alarm state
{
  noStroke();
  
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
  fillDate();
  
  //boundaries of main menu items
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  
  if(!disarmClicked)//user does not click yet
        {
          if(makeBooleanButton("DISARM", buttonColor, hoverColor, (int)topLeftX, (int)topLeftY, (int)(2*boxX+spacing),(int)boxY, 10))
          {
            disarmClicked = true;
          }
        }
        else //diarm has been clicked, request pass
        {
          float x1=width-.4*width;
          float y1=height-height*.8;
          float s=90;
          
          //fillable region
          fill(255);
          stroke(0);
          rect(125,150,200,48);
          fill(0);
          text(passEntry,135,175);
          
          
          //header text
          fill(textColor);
          textSize(32);
          text("Enter Passcode",10,50);
          
          textSize(24);
          text(attempts+" attempts remaining",50,390);
          
          textSize(32);
          
          s_index=passEntry.length();
          s_index--;
          
          if(makeBooleanButton("7", buttonColor, hoverColor,(int)x1, (int)y1, (int)s,(int)s,0))
          {
            passEntry += "7";
          }
          if(makeBooleanButton("8", buttonColor, hoverColor,(int)(x1+s), (int)y1, (int)s,(int)s,0))
          {
            passEntry += "8";
          }
          if(makeBooleanButton("9", buttonColor, hoverColor,(int)(x1+2*s), (int)y1, (int)s,(int)s,0))
          {
            passEntry += "9";
          }
          if(makeBooleanButton("4", buttonColor, hoverColor,(int)x1, (int)(y1+s), (int)s,(int)s,0))
          {
            passEntry += "4";
          }
          if(makeBooleanButton("5", buttonColor, hoverColor,(int)(x1+s), (int)(y1+s), (int)s,(int)s,0))
          {
            passEntry += "5";
          }
          if(makeBooleanButton("6", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+s), (int)s,(int)s,0))
          {
            passEntry += "6";
          }
          if(makeBooleanButton("1", buttonColor, hoverColor,(int)x1, (int)(y1+2*s), (int)s,(int)s,0))
          {
            passEntry += "1";
          }
          if(makeBooleanButton("2", buttonColor, hoverColor,(int)(x1+s), (int)(y1+2*s), (int)s,(int)s,0))
          {
            passEntry += "2";
          }
          if(makeBooleanButton("3", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+2*s), (int)s,(int)s,0))
          {
            passEntry += "3";
          }
          if(makeBooleanButton("0", buttonColor, hoverColor,(int)(x1+s), (int)(y1+3*s), (int)s,(int)s,0))
          {
            passEntry += "0";
          }
          textSize(18);
          if(makeBooleanButton("del", buttonColor, hoverColor,(int)(x1), (int)(y1+3*s), (int)s,(int)s,0))
          {
            //delete last character
            passEntry = passEntry.substring(0, max(0, s_index));
          }
          if(makeBooleanButton("enter", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+3*s), (int)s,(int)s,0))
          {
            attempts--;
                  if(passEntry.equals(myPass))
                  {
                    attempts=3;
                    armed = false;
                    passEntry="";
                    inCount2 = false;
                    disarmClicked = false;
                    menuState=1;
                    
                  }
                  else
                  {
                    
                    if(attempts==0)
                    {
                      menuState=22;//sound alarm 
                    }
                    passEntry="";
                  }
          }
        } 
}



void disarmMenu()//25
{
   noStroke();
  
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
  fillDate();
  
  //boundaries of main menu items
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  
  
  
  if(inCount1) //if counting when user leaves
  {
    //show countdown
    countdown = (int) (armTimer- (millis()-armTime)/1000);
    if(countdown>0)
    {
      fill(textColor);
      textSize(32);
      text("Countdown1: "+countdown+" s", 50, 350);  
      if(millis()-prevSec > 1000) //1 second beeper
        {
          prevSec = millis();
          //pulse buzzer
          delay(20);
          exec("python","/home/pi/1kHz-100ms.py");
        }
    }
    else
    {
      inCount1 = false; //first countdown is over
    }
  }
  else if(inCount2) //if counting when user returns
  {
    countdown2 = (int)(armTimer - (millis()-openTime)/1000);
    if(countdown2 > 0)
    {
      fill(textColor);
      textSize(32);
      text("Countdown2: "+countdown2+" s", 50, 350);  
      if(millis()-prevSec > 1000) //1 second beeper
      {
        prevSec = millis();
        //pulse buzzer
        delay(20);
        exec("python","/home/pi/1kHz-100ms.py");
      }
      getDisarm(); //request pass code, starts w/ 3 entries
    }
    else//second countdown over, set off alarm
    {
      menuState = 22; //Alarm state
      inCount2 = false;
    }
    
  }
  else //user has left, but not returned  both inCount1 and inCount2 == false
  {
    //chance user is still in house and wants to disarm
    getDisarm(); //request pass code
    
    //check if door state becomes open
    if(GPIO.digitalRead(reedPin) == GPIO.HIGH)
      lastReed = true; 

    if(GPIO.digitalRead(reedPin) == GPIO.LOW && lastReed == true) //door opens this moment
    {
       lastReed = false;
       openTime = millis();
       inCount2 = true;
    }
  }
  
  
}

void securityPreferences() //23
{
  float backX=50, backY=360, back_size=250;
  float x1=50, y1=100, s=100;
  
  int backColor = 0;
  
  //banner
  noStroke();
  fill(hoverColor);
  rect(0,0,800,60);
  

  fill(textColor);
  textSize(32);
  text("Security Preferences",10,50);
  
  makeButtonLink("set arm/disarm delay", 26, buttonColor, hoverColor, (int)(x1), (int)(y1+2*s), (int)(3*s), (int)s,10);
  makeButtonLink("back", 2, buttonColor, hoverColor, (int)backX, (int)backY, (int)(back_size),(int)back_size, 10);
  
  if(makeBooleanButtonLink("change passcode", 24, buttonColor, hoverColor, (int)x1, (int)(y1-2*s), (int)(3*s),(int)s, 10))
  {
    verifyPass = true; 
    passSet = false;
  }
  
  
  
}

String newPassEntry = "";
boolean verifyPass = false;
boolean passSet = false;
long setTime = 0;
long setTime2 = 0;


void updatePasscode()//24
{
  
  float x1=width-.4*width;
  float y1=height-height*.8;
  float s=90;
  noStroke();
  //header
  fill(hoverColor);
  rect(0,0,800,60);
  
  makeButtonLink("back", 2, buttonColor, hoverColor, 50, 400, 200, 60, 10);

  
  if(millis()-setTime < 2000)
  {
    fill(textColor);
    text("passcode has been verifed", 150, 150); 
  }
  if(millis()-setTime2 < 2000)
  {
    fill(textColor);
    text("passcode has been set",150,150); 
  }
  else
  if(passSet && millis()-setTime2 >= 2000)
  {
    menuState = 2; 
  }
  
  //fillable region
  fill(255);
  rect(125,150,200,48);
  fill(0);
  text(newPassEntry,135,175);
  
  stroke(0);
  
  
  if(verifyPass)
  {
    //header text
    fill(textColor);
    textSize(32);
    text("Enter old passcode",10,50);
    
      
      textSize(32);
    
    s_index=newPassEntry.length();
    s_index--;
  
    if(makeBooleanButton("7", buttonColor, hoverColor,(int)x1, (int)y1, (int)s,(int)s,0))
    {
      newPassEntry += "7";
    }
    if(makeBooleanButton("8", buttonColor, hoverColor,(int)(x1+s), (int)y1, (int)s,(int)s,0))
    {
      newPassEntry += "8";
    }
    if(makeBooleanButton("9", buttonColor, hoverColor,(int)(x1+2*s), (int)y1, (int)s,(int)s,0))
    {
      newPassEntry += "9";
    }
    if(makeBooleanButton("4", buttonColor, hoverColor,(int)x1, (int)(y1+s), (int)s,(int)s,0))
    {
      newPassEntry += "4";
    }
    if(makeBooleanButton("5", buttonColor, hoverColor,(int)(x1+s), (int)(y1+s), (int)s,(int)s,0))
    {
      newPassEntry += "5";
    }
    if(makeBooleanButton("6", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+s), (int)s,(int)s,0))
    {
      newPassEntry += "6";
    }
    if(makeBooleanButton("1", buttonColor, hoverColor,(int)x1, (int)(y1+2*s), (int)s,(int)s,0))
    {
      newPassEntry += "1";
    }
    if(makeBooleanButton("2", buttonColor, hoverColor,(int)(x1+s), (int)(y1+2*s), (int)s,(int)s,0))
    {
      newPassEntry += "2";
    }
    if(makeBooleanButton("3", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+2*s), (int)s,(int)s,0))
    {
      newPassEntry += "3";
    }
    if(makeBooleanButton("0", buttonColor, hoverColor,(int)(x1+s), (int)(y1+3*s), (int)s,(int)s,0))
    {
      newPassEntry += "0";
    }
    textSize(18);
    if(makeBooleanButton("del", buttonColor, hoverColor,(int)x1, (int)(y1+3*s), (int)s,(int)s,0))
    {
      //delete last character
      newPassEntry = newPassEntry.substring(0, max(0, s_index));
    }
    if(makeBooleanButton("enter", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+3*s), (int)s,(int)s,0))
    {
      if(newPassEntry.equals(myPass))
      {
        newPassEntry = "";
         
        setTime = millis();
        
        fill(textColor);
        text("Passcode has been verified",100,150); 
         
        verifyPass = false;
      }
      else
      {
        newPassEntry = "";
      }
    }
     

  }
  else//verified, allow pass change
  {
    
    
  //header text
  fill(textColor);
  textSize(32);
  text("Enter new passcode",10,50);
    textSize(32);
  
  s_index=newPassEntry.length();
  s_index--;
  
  if(makeBooleanButton("7", buttonColor, hoverColor,(int)x1, (int)y1, (int)s,(int)s,0))
    {
      newPassEntry += "7";
    }
    if(makeBooleanButton("8", buttonColor, hoverColor,(int)(x1+s), (int)y1, (int)s,(int)s,0))
    {
      newPassEntry += "8";
    }
    if(makeBooleanButton("9", buttonColor, hoverColor,(int)(x1+2*s), (int)y1, (int)s,(int)s,0))
    {
      newPassEntry += "9";
    }
    if(makeBooleanButton("4", buttonColor, hoverColor,(int)x1, (int)(y1+s), (int)s,(int)s,0))
    {
      newPassEntry += "4";
    }
    if(makeBooleanButton("5", buttonColor, hoverColor,(int)(x1+s), (int)(y1+s), (int)s,(int)s,0))
    {
      newPassEntry += "5";
    }
    if(makeBooleanButton("6", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+s), (int)s,(int)s,0))
    {
      newPassEntry += "6";
    }
    if(makeBooleanButton("1", buttonColor, hoverColor,(int)x1, (int)(y1+2*s), (int)s,(int)s,0))
    {
      newPassEntry += "1";
    }
    if(makeBooleanButton("2", buttonColor, hoverColor,(int)(x1+s), (int)(y1+2*s), (int)s,(int)s,0))
    {
      newPassEntry += "2";
    }
    if(makeBooleanButton("3", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+2*s), (int)s,(int)s,0))
    {
      newPassEntry += "3";
    }
    if(makeBooleanButton("0", buttonColor, hoverColor,(int)(x1+s), (int)(y1+3*s), (int)s,(int)s,0))
    {
      newPassEntry += "0";
    }
    textSize(18);
    if(makeBooleanButton("del", buttonColor, hoverColor,(int)x1, (int)(y1+3*s), (int)s,(int)s,0))
    {
      //delete last character
      newPassEntry = newPassEntry.substring(0, max(0, s_index));
    }
    if(makeBooleanButton("enter", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+3*s), (int)s,(int)s,0))
    {
      myPass = newPassEntry;
      //update JSON File here
      json.setString("myPass",myPass);
      
      setTime2 = millis();
      
      saveJSONObject(json,"config.json");
      
      newPassEntry = "";
      
      fill(textColor);
      text("Passcode has been set",50,150); 
      
      
      passSet = true;
      //menuState = 2; //go bto main security menu
          
     }
  }
}



int s_index=0;

void keyPad() //21
{
  float x1=width-.4*width;
  float y1=height-height*.8;
  float s=90;
  noStroke();
  //header
  fill(hoverColor);
  rect(0,0,800,60);
  
  //fillable region
  fill(255);
  rect(125,150,200,48);
  fill(0);
  text(passEntry,135,175);
  
  stroke(0);
  
  //header text
  fill(textColor);
  textSize(32);
  text("Enter Passcode",10,50);
  
  textSize(18);
  text(attempts+" attempts remaining",50,350);
  
  textSize(32);
  
  s_index=passEntry.length();
  s_index--;
  
  if(makeBooleanButton("7", buttonColor, hoverColor,(int)x1, (int)y1, (int)s,(int)s,0))
  {
    passEntry += "7";
  }
  if(makeBooleanButton("8", buttonColor, hoverColor,(int)(x1+s), (int)y1, (int)s,(int)s,0))
  {
    passEntry += "8";
  }
  if(makeBooleanButton("9", buttonColor, hoverColor,(int)(x1+2*s), (int)y1, (int)s,(int)s,0))
  {
    passEntry += "9";
  }
  if(makeBooleanButton("4", buttonColor, hoverColor,(int)x1, (int)(y1+s), (int)s,(int)s,0))
  {
    passEntry += "4";
  }
  if(makeBooleanButton("5", buttonColor, hoverColor,(int)(x1+s), (int)(y1+s), (int)s,(int)s,0))
  {
    passEntry += "5";
  }
  if(makeBooleanButton("6", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+s), (int)s,(int)s,0))
  {
    passEntry += "6";
  }
  if(makeBooleanButton("1", buttonColor, hoverColor,(int)x1, (int)(y1+2*s), (int)s,(int)s,0))
  {
    passEntry += "1";
  }
  if(makeBooleanButton("2", buttonColor, hoverColor,(int)(x1+s), (int)(y1+2*s), (int)s,(int)s,0))
  {
    passEntry += "2";
  }
  if(makeBooleanButton("3", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+2*s), (int)s,(int)s,0))
  {
    passEntry += "3";
  }
  if(makeBooleanButton("0", buttonColor, hoverColor,(int)(x1+s), (int)(y1+3*s), (int)s,(int)s,0))
  {
    passEntry += "0";
  }
  textSize(18);
  if(makeBooleanButton("del", buttonColor, hoverColor,(int)x1, (int)(y1+3*s), (int)s,(int)s,0))
  {
    //delete last character
    passEntry = passEntry.substring(0, max(0, s_index));
  }
  if(makeBooleanButton("enter", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+3*s), (int)s,(int)s,0))
  {
    attempts--;
          if(passEntry.equals(myPass))
          {
            attempts=3;
            armed = false;
            passEntry="";
            menuState=1;
          }
          else
          {
            
            if(attempts==0)
            {
              menuState=22;//sound alarm 
            }
            passEntry="";
          }
  }
   
  
   
    
   
      
 
  
}

color breachBG = color(255,0,0);
int beepCount = 0;
long pTime=0;
  
void securityBreach() //sound alarm
{
  
  long t=750;
  long t2 = 400;

  
  //beeper
  if(millis()-pTime > 2*t2)
  {
    pTime = millis();
     if(beepCount<3)
     {
       delay(20);
       exec("python","/home/pi/2kHzTone.py");
       delay(250);
       beepCount++;
     }
     else
       beepCount = 0;
   }


  
  //screen flash
  if(millis()-prevMillis>t)
  {
    if(millis()-prevMillis<2*t)
    {        
        breachBG = color(255,0,0);
        background(breachBG);
        fill(255);
    }
    else
      prevMillis = millis();
  }
  else
  {
    breachBG=color(255,255,255);
    fill(0);
    background(breachBG);
  }
  textSize(80);
  textAlign(CENTER);
  text("ALERT\nSECURITY BREACH",400,100);
 
  textSize(32);
  textAlign(LEFT);
  text("Please reset system",50,400);
}
