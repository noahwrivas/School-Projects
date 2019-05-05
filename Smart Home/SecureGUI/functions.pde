float temp,maxTemp,minTemp;
String condition = "";


void parseFile(String zip) {
  textSize(8);
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("https://api.openweathermap.org/data/2.5/weather?zip="+zip+",us&appid=2d7d61e0a5820728d2004a21b00598a1");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      //String[] lines = split(line,":");
        
      //Parse data for temperature
      String[] t = match(line, "\"temp\":(.*?),");
      println("Found '" + t[1] + "' inside the tag.");
      temp = float(t[1]);
      temp-=273.15;
      temp = (temp*9/5)+32;
      println("temp in celcius"+temp);
      
      String[] maxT = match(line, "\"temp_min\":(.*?),");
      println("Found '" + maxT[1] + "' inside the tag.");
      maxTemp = float(maxT[1]);
      maxTemp-=273.15;
      maxTemp = (maxTemp*9/5)+32;
      
      String[] minT = match(line, "\"temp_max\":(.*?)}");
      println("Found '" + minT[1] + "' inside the tag.");
      minTemp = float(minT[1]);
      minTemp-=273.15;
      minTemp = (minTemp*9/5)+32;
      
      
      String[] cond = match(line,"\"description\":\"(.*?)\"");
      println("Found '" + cond[1] + "' inside the tag.");
      condition = cond[1];
      
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  
}

void setPollTimer()
{  
  noStroke();
  
  fill(hoverColor);
  rect(0,0,800,60);
  
  fill(textColor);
  textSize(32);
  text("Set temperature update interval ",10,50);
  
  makeButtonLink("back", 6, buttonColor, hoverColor, 50, 400, 200, 60, 10);

  
   fill(buttonColor);
   triangle(400,100,500,150,300,150);
   stroke(0);
   strokeWeight(2);
   fill(255);
   rect(305,155,190,90);
   fill(0);
   textSize(32);
   text((pollTimer/1000)+" s", 355,215);
   fill(buttonColor);
   triangle(400,300,500,250,300,250);
   
   if(mouseX>300 && mouseX<500 &&
      mouseY>100 && mouseY<150)
     {
       if(mousePressed && millis()-prevMillis > debounce)
       {
         prevMillis = millis();
         if(pollTimer < 60000)
         {
            fill(255);
            noStroke();
            rect(310,160,180,80);
            fill(0);
            pollTimer+=1000;
         }
       }
     }
     
    if(mouseX>300 && mouseX<500 &&
      mouseY>250 && mouseY<300)
     {
       if(mousePressed && millis()-prevMillis > debounce)
       {
         prevMillis = millis();
         if(pollTimer > 1000)
           {
            fill(255);
            noStroke();
            rect(310,160,180,80);
            fill(0);
            pollTimer-=1000;
           }
       }
     }
     
}

void setWeatherInterval()
{
   noStroke();
  
  fill(hoverColor);
  rect(0,0,800,60);
  
  fill(textColor);
  textSize(32);
  text("Set weather update interval ",10,50);
  
  makeButtonLink("back", 41, buttonColor, hoverColor, 50, 400, 200, 60, 10);

  
   fill(buttonColor);
   triangle(400,100,500,150,300,150);
   stroke(0);
   strokeWeight(2);
   fill(255);
   rect(305,155,190,90);
   fill(0);
   textSize(32);
   fill(textColor);
   text((int)updateFreq+" minutes", 355,215);
   fill(buttonColor);
   triangle(400,300,500,250,300,250);
   
   if(mouseX>300 && mouseX<500 &&
      mouseY>100 && mouseY<150)
     {
       if(mousePressed && millis()-prevMillis > debounce)
       {
         prevMillis = millis();
         if(updateFreq < 60)
         {
            fill(255);
            noStroke();
            rect(310,160,180,80);
            fill(0);
            updateFreq+=1;
         }
       }
     }
     
    if(mouseX>300 && mouseX<500 &&
      mouseY>250 && mouseY<300)
     {
       if(mousePressed && millis()-prevMillis > debounce)
       {
         prevMillis = millis();
         if(updateFreq > 1)
           {
            fill(255);
            noStroke();
            rect(310,160,180,80);
            fill(0);
            updateFreq-=1;
           }
       }
     }
}

void setDoorTiming()
{
  noStroke();
  
  fill(hoverColor);
  rect(0,0,800,60);
  
  fill(textColor);
  textSize(32);
  text("Set arm/disarm delay ",10,50);
  
  makeButtonLink("back", 23, buttonColor, hoverColor, 50, 400, 200, 60, 10);

  
   fill(buttonColor);
   triangle(400,100,500,150,300,150);
   stroke(0);
   strokeWeight(2);
   fill(255);
   rect(305,155,190,90);
   fill(0);
   textSize(32);
   text(armTimer+" s", 355,215);
   fill(buttonColor);
   triangle(400,300,500,250,300,250);
   
   if(mouseX>300 && mouseX<500 &&
      mouseY>100 && mouseY<150)
     {
       if(mousePressed && millis()-prevMillis > debounce)
       {
         prevMillis = millis();
         if(armTimer < 120)
         {
            fill(255);
            noStroke();
            rect(310,160,180,80);
            fill(0);
            armTimer+=1;
         }
       }
     }
     
    if(mouseX>300 && mouseX<500 &&
      mouseY>250 && mouseY<300)
     {
       if(mousePressed && millis()-prevMillis > debounce)
       {
         prevMillis = millis();
         if(armTimer > 10)
           {
            fill(255);
            noStroke();
            rect(310,160,180,80);
            fill(0);
            armTimer-=1;
           }
       }
     }
}


void fillDate()
{
  boolean am;
  String date = getDate();
  int h = hour();
  if(h>12)
  {
    am = false;
    h-=12;
  }
  else
    am = true;
  String hour = Integer.toString(h);
  int m = minute();
  String min = Integer.toString(m);
  int s = second();
  String sec = Integer.toString(s);
  
  textSize(32);
  fill(textColor);
  text(date,10,50);
  
  
  
  textSize(16);
  if(am)
  {
    text("am",740,50);
  }
  else
  {
    text("pm",740,50);
  }
  textSize(32);
  
  if(h<10)
    text(hour,624,50);
  else
    text(hour,600,50);

  text(":",642,48);

  if(m<10)
  {
    text("0",652,50);
    text(min,672,50);
  }else
    text(min,652,50);
  text(":",687,48);
  if(s<10)
  {
    text("0",696,50); 
    text(sec,716,50); 
  }else
    text(sec,696,50); 
}

String getDate()
{
  int m = month();
  int d = day();
  int sunday=0;
  int dow=0;
  String result = "";
  String date = "";
  
  
  
  
  switch(m)
  {
    case 1:
        date = "January "+d;
        sunday = 1+d;
        break;
    case 2:
        date = "February "+d;
        sunday = 32+d;
        break;
    case 3:
        date = "March "+d;
        sunday = 60+d;
        break;
    case 4:
        date ="April "+d;
        sunday = 91+d;
        break;
    case 5:
        date ="May "+d;
        sunday = 121+d;
        break;
    case 6:
        date ="June "+d;
        sunday = 152+d;
        break;
    case 7:
        date ="July "+d;
        sunday = 182+d;
        break;
    case 8:
        date ="August "+d;
        sunday = 213+d;
        break;
    case 9:
        date ="September "+d;
        sunday = 244+d;
        break;
    case 10:
        date ="October "+d;
        sunday = 274+d;
        break;    
    case 11:
        date ="November "+d;
        sunday = 305+d;
        break;
    case 12:
        date ="December " +d;
        sunday = 335+d;
        break;
  }
  
  dow = sunday%7;
  
  switch(dow)//determine day-of-week (dow)
  {
   case 0://sunday
     result = "Sunday, "+date;
     break;
   case 1://monday
     result = "Monday, "+date;
     break;
   case 2://tuesday
     result = "Tuesday, "+date;
     break;
   case 3://wednesday
     result = "Wednesday, "+date;
     break;
   case 4://thursday
     result = "Thursday, "+date;
     break;
   case 5://friday
     result = "Friday, "+date;
     break;
   case 6://saturday
     result = "Saturday, "+date;
     break;
  }
  
  return result;
}
