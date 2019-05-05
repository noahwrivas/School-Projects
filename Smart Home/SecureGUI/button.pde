/*
  Button functions
  
  Button inputs:
    Text, Color, menu link, x_pos, y_pos, x_size, y_size, radius, color theme
    
    make button link:
    makeButtonLink(text, link, button_color, alt_color, 
                x_pos, y_pos, x_size, y_size, radius)
    
    make boolean button: returns true when button clicked
    makeBooleanButton(text, button_color, alt_color, 
                x_pos, y_pos, x_size, y_size, radius)
    

*/
void makeButtonLink(String text, int link, color button_color, color alt_color, 
                int x_pos, int y_pos, int x_size, int y_size, int radius)
{
  color text_color;
  
  if(darkTheme)
  {
    text_color = color(221,221,221);
  }
  else
  {
    text_color = color(0,0,0);
    
  }
  
  if(mouseX > x_pos && mouseX <  x_pos+x_size &&
     mouseY > y_pos && mouseY < y_pos+y_size)
  {
     if(mousePressed)
      {
        button_color = alt_color;
      }
     if(mouseReleased && millis()-prevMillis > debounce)
     {
       prevMillis = millis();
       menuState = link; 
     }
  }
  
  
  fill(button_color);
  rect(x_pos, y_pos, x_size, y_size, radius);
  fill(text_color);
  text( text, x_pos+spacing, y_pos+spacing);
  
}

boolean makeBooleanButton(String text, color button_color, color alt_color, 
                int x_pos, int y_pos, int x_size, int y_size, int radius)
{
  color text_color;
  boolean buttonClicked = false;
  
  if(darkTheme)
  {
    text_color = color(221,221,221);
  }
  else
  {
    text_color = color(0,0,0);
    
  }
  
  if(mouseX > x_pos && mouseX <  x_pos+x_size &&
     mouseY > y_pos && mouseY < y_pos+y_size)
  {
     if(mousePressed)
      {
        button_color = alt_color;
      }
     if(mouseReleased && millis()-prevMillis > debounce)
     {
       prevMillis = millis();
       buttonClicked = true;
     }
  }

  
  
  fill(button_color);
  rect(x_pos, y_pos, x_size, y_size, radius);
  fill(text_color);
  text( text, x_pos+spacing, y_pos+spacing);
  
  return(buttonClicked);
}

boolean makeBooleanButtonLink(String text, int link, color button_color, color alt_color, 
                int x_pos, int y_pos, int x_size, int y_size, int radius)
{
  color text_color;
  boolean buttonClicked = false;
  
  if(darkTheme)
  {
    text_color = color(221,221,221);
  }
  else
  {
    text_color = color(0,0,0);
    
  }
  
  if(mouseX > x_pos && mouseX <  x_pos+x_size &&
     mouseY > y_pos && mouseY < y_pos+y_size)
  {
     if(mousePressed)
      {
        button_color = alt_color;
      }
     if(mouseReleased && millis()-prevMillis > debounce)
     {
       prevMillis = millis();
       menuState = link;
       buttonClicked = true;
     }
  }

  
  
  fill(button_color);
  rect(x_pos, y_pos, x_size, y_size, radius);
  fill(text_color);
  text( text, x_pos+spacing, y_pos+spacing);
  
  return(buttonClicked);
}
