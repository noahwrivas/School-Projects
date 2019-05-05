void mainMenu()
{
  noStroke();

  //boundaries of main menu items
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  float topRightX=width-width*.5, topRightY=height-height*0.85;
  float botLeftX=width-width*.95, botLeftY=height-height*0.4;
  float botRightX=width-width*.5, botRightY=height-height*0.4;
  
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
   
  fillDate(); //draw date and time
  
  //makeButton(title, link, color,hovercolor, x,y,xsize,ysize,radius)
  makeButtonLink("Security", 2, buttonColor, hoverColor, (int)topLeftX,(int)topLeftY, (int)boxX,(int)boxY, 10);
  makeButtonLink("Thermostat", 3, buttonColor, hoverColor, (int)topRightX,(int)topRightY, (int)boxX,(int)boxY, 10);
  makeButtonLink("Local Weather", 4, buttonColor, hoverColor, (int)botLeftX,(int)botLeftY, (int)boxX,(int)boxY, 10);
  makeButtonLink("Appliances", 5, buttonColor, hoverColor, (int)botRightX,(int)botRightY, (int)boxX,(int)boxY, 10);
    
  scale(0.10);
  translate(7250,4000); //725,400
  shape(gear,0,0);
  
  //preferences vector button
  if(mouseX>725 && mouseX<775 &&
           mouseY>400 && mouseY < 450)
  {
    if(mouseReleased&&millis()-prevMillis>debounce)
    {
      prevMillis=millis();
      menuState = 6; //preferences menu
    }
  }
}





void thermMenu()
{
  noStroke();
  
  fill(hoverColor);
  rect(0,0,800,60);
  
  fill(textColor);
  textSize(32);
  text("Thermostat",10,50);
  
  makeButtonLink("back", 1, buttonColor, hoverColor, 50, 400, 200, 60, 10);

  fill(textColor);
  text("Temperature: "+ tempInt+" F", 150,150);
  
}





void applianceMenu()
{
  noStroke();

  //boundaries of main menu items
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  float topRightX=width-width*.5, topRightY=height-height*0.85;
  
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
  
  fill(textColor);
  textSize(32);
  text("Appliances",10,50);
  
  /*  if(makeBooleanButton(text, button_color, alt_color, 
                x_pos, y_pos, x_size, y_size, radius)) */
  
  if(makeBooleanButton("Light 1", buttonColor, hoverColor, 
                (int)topLeftX, (int)topLeftY, (int)boxX, (int)boxY, 10))
  {
    //toggle relay 1
      relay1 = ! relay1;
      if(relay1)
      {
       GPIO.digitalWrite(relay1Pin,GPIO.HIGH);
      }
      else
      {
        GPIO.digitalWrite(relay1Pin,GPIO.LOW);
      }
  }
  
  if(makeBooleanButton("Light 2", buttonColor, hoverColor, 
                (int)topRightX, (int)topRightY, (int)boxX, (int)boxY, 10))
  {
    //toggle relay 2
      relay2 = ! relay2;
      if(relay2)
      {
       GPIO.digitalWrite(relay2Pin,GPIO.HIGH);
      }
      else
      {
        GPIO.digitalWrite(relay2Pin,GPIO.LOW);
      }
  }
  
  makeButtonLink("back", 1, buttonColor, hoverColor, 50, 400, 200, 60, 10);

}


void settingsMenu()
{
  noStroke();

  //boundaries of main menu items
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  float topRightX=width-width*.5, topRightY=height-height*0.85;
  float botRightX=width-width*.5, botRightY=height-height*0.4;

  
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
  
  fill(textColor);
  textSize(32);
  text("Settings",10,50);
  
  makeButtonLink("Fonts", 61, buttonColor, hoverColor, (int)topLeftX,(int)topLeftY, (int)boxX,(int)boxY, 10);
  makeButtonLink("Set temp \ninterval ", 62, buttonColor, hoverColor, (int)botRightX,(int)botRightY, (int)boxX,(int)boxY, 10);
  makeButtonLink("back", 1, buttonColor, hoverColor, 50, 400, 200, 60, 10);

  if(makeBooleanButton("Color Theme", buttonColor, hoverColor, 
                (int)topRightX, (int)topRightY, (int)boxX, (int)boxY, 10))
  {
     //toggle color scheme;
      darkTheme = !darkTheme;
      if(darkTheme)
      {
        buttonColor = color(0,50,120);
        hoverColor = color(0,29,69);
        textColor = color(221,221,221);
        bg_color = 0;
      }
      else
      {
        buttonColor = 235;
        hoverColor = 200;
        textColor = color(0,0,0);
        bg_color = 255;
      }
  }
  
}


void fontMenu()
{
  noStroke();

  //boundaries of main menu items
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  float topRightX=width-width*.5, topRightY=height-height*0.85;
  float botLeftX=width-width*.95, botLeftY=height-height*0.4;
  float botRightX=width-width*.5, botRightY=height-height*0.4;
    
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
  
  fill(textColor);
  textSize(32);
  text("Fonts",10,50);
  
  if(makeBooleanButton("Timeless", buttonColor, hoverColor, 
                (int)topLeftX, (int)topLeftY, (int)boxX, (int)boxY, 10))
  {
    mono=createFont("Timeless.ttf",32); 
    textFont(mono);
    fontStr = "Timeless.ttf";
    json.setString("fontStr",fontStr);
    saveJSONObject(json,"config.json");
  }
  
  if(makeBooleanButton("Caesar", buttonColor, hoverColor, 
                (int)topRightX, (int)topRightY, (int)boxX, (int)boxY, 10))
  {
    mono=createFont("CAESAR.TTF",32); 
    textFont(mono);
    fontStr = "CAESAR.TTF";
    json.setString("fontStr",fontStr);
    saveJSONObject(json,"config.json");
  }
  
  if(makeBooleanButton("Sanchez", buttonColor, hoverColor, 
                (int)botRightX, (int)botRightY, (int)boxX, (int)boxY, 10))
  {
    mono=createFont("Sanchezregular.otf",32); 
    textFont(mono);
    fontStr = "Sanchezregular.otf";
    json.setString("fontStr",fontStr);
    saveJSONObject(json,"config.json");
  }
  
  makeButtonLink("back", 1, buttonColor, hoverColor, 50, 400, 200, 60, 10);

}








void smokeAlarm()
{
  long t=750;
  long t2 = 400;

  
  //beeper
  if(millis()-pTime > 2*t2)
  {
    pTime = millis();
    delay(20);
    exec("python","/home/pi/2kHzTone.py");
    delay(250);
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
  text("ALERT\nSMOKE DETECTED",400,100);
 
  textSize(32);
  textAlign(LEFT);
  text("CALL AUTHORITIES, and EXIT BUILDING",50,400);
  
}
