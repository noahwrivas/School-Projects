  
void setup() {
  size(1600, 100);
  parseFile();
}

void parseFile() {
  textSize(8);
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("https://api.openweathermap.org/data/2.5/weather?zip=13502,us&appid=2d7d61e0a5820728d2004a21b00598a1");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      //String[] lines = split(line,":");
        
      //Parse data for temperature
      String[] t = match(line, "\"temp\":(.*?),");
      println("Found '" + t[1] + "' inside the tag.");
      float temp = float(t[1]);
      temp-=273.15;
      println("temp in celcius"+temp);
      
      String[] maxT = match(line, "\"temp_min\":(.*?),");
      println("Found '" + maxT[1] + "' inside the tag.");
      
      String[] minT = match(line, "\"temp_max\":(.*?)}");
      println("Found '" + minT[1] + "' inside the tag.");
      
      
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  
} 
