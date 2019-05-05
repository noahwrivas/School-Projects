void weatherMenu()
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
  
  fill(textColor);
  textSize(32);
  getDate(); //why???
  
  
  
  if((millis()-lastAPIcall)/1000>updateFreq)
  {
    lastAPIcall = millis();
    parseFile(zipcode);
  }
  
  
  fill(buttonColor);
  rect(50,100,700,320,5);
  fill(textColor);
  text("zip code: "+zipcode,80,160); 
  text("Temp: ",80,200);
  text(int(temp)+"°F",200,200);
  text("Lo:   ",80,240);
  text(int(maxTemp)+"°F",200,240);
  text("Hi:   ",80,280);
  text(int(minTemp)+"°F",200,280);
  text("Conditions: "+condition,80,320);
  
  
  makeButtonLink("back",1,buttonColor, hoverColor,(int)botLeftX, (int)(botLeftY+boxY/2), (int)(boxX/2), (int)(boxY/2), 5);
  makeButtonLink("Preferences",41,buttonColor, hoverColor,(int)botRightX, (int)(botRightY+boxY/2), (int)boxX, (int)(boxY/2), 5);

}


void weatherPreferences()
{
  //here include zipcode edit feature
  //also include weather update frequency
  float backX=50, backY=420, back_size=250;
  float boxX=width*0.39, boxY=height*0.39;
  float topLeftX=width-width*.95, topLeftY=height-height*0.85;
  float topRightX=width-width*.5, topRightY=height-height*0.85;
  
  
  
  noStroke();
  //banner
  fill(hoverColor);
  rect(0,0,800,60);
  

  fill(textColor);
  textSize(32);
  text("Weather Preferences",10,50);
  
  
  makeButtonLink("change update interval",43, buttonColor, hoverColor, (int)topRightX, (int)topRightY, (int)boxX, (int)boxY, 10);
  
  if(makeBooleanButtonLink("Change zip code", 42, buttonColor, hoverColor, (int)topLeftX, (int)topLeftY, (int)boxX, (int)boxY, 10))
  {
    zipSet = false;
  }
  makeButtonLink("back", 4, buttonColor, hoverColor, (int)backX, (int)backY, (int)back_size, (int)back_size, 10);
  
  
}

String newZipEntry = "";
long zipSetTime = 0;
boolean zipSet = false;

void updateZip()
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
  stroke(0);
  rect(125,150,200,48);
  fill(0);
  text(newZipEntry,135,175);
  
  stroke(0);
  
  //header text
  fill(textColor);
  textSize(32);
  text("Enter new zip code",10,50);
  
  if(millis()-zipSetTime <2000)
  {
    fill(textColor);
    textSize(32);
    text("zipcode has been set",50,50);  
  }
  else if(zipSet)
  {
    menuState = 4; 
  }
  
  textSize(32);
  
  s_index=newZipEntry.length();
  s_index--;
  
  if(makeBooleanButton("7", buttonColor, hoverColor,(int)x1, (int)y1, (int)s,(int)s,0))
  {
    newZipEntry += "7";
  }
  if(makeBooleanButton("8", buttonColor, hoverColor,(int)(x1+s), (int)y1, (int)s,(int)s,0))
  {
    newZipEntry += "8";
  }
  if(makeBooleanButton("9", buttonColor, hoverColor,(int)(x1+2*s), (int)y1, (int)s,(int)s,0))
  {
    newZipEntry += "9";
  }
  if(makeBooleanButton("4", buttonColor, hoverColor,(int)x1, (int)(y1+s), (int)s,(int)s,0))
  {
    newZipEntry += "4";
  }
  if(makeBooleanButton("5", buttonColor, hoverColor,(int)(x1+s), (int)(y1+s), (int)s,(int)s,0))
  {
    newZipEntry += "5";
  }
  if(makeBooleanButton("6", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+s), (int)s,(int)s,0))
  {
    newZipEntry += "6";
  }
  if(makeBooleanButton("1", buttonColor, hoverColor,(int)x1, (int)(y1+2*s), (int)s,(int)s,0))
  {
    newZipEntry += "1";
  }
  if(makeBooleanButton("2", buttonColor, hoverColor,(int)(x1+s), (int)(y1+2*s), (int)s,(int)s,0))
  {
    newZipEntry += "2";
  }
  if(makeBooleanButton("3", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+2*s), (int)s,(int)s,0))
  {
    newZipEntry += "3";
  }
  if(makeBooleanButton("0", buttonColor, hoverColor,(int)(x1+s), (int)(y1+3*s), (int)s,(int)s,0))
  {
    newZipEntry += "0";
  }
  textSize(18);
  if(makeBooleanButton("del", buttonColor, hoverColor,(int)x1, (int)(y1+3*s), (int)s,(int)s,0))
  {
    //delete last character
    newZipEntry = newZipEntry.substring(0, max(0, s_index));
  }
  if(makeBooleanButton("enter", buttonColor, hoverColor,(int)(x1+2*s), (int)(y1+3*s), (int)s,(int)s,0))
  {
      if(newZipEntry.length() == 5)
      {
        zipcode = newZipEntry;
        //update JSON File here
        json.setString("zipcode",zipcode);
        saveJSONObject(json,"config.json");
        
        newZipEntry = "";
        zipSet = true;
        zipSetTime = millis();
      }
      else
      { 
        fill(textColor);
        text("Please Enter a 5-digit zip code",50,50); 
        zipSet = false;
      }
   }
}
