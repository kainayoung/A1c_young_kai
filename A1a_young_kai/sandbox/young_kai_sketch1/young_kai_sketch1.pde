//sets the colors
color blue = color(38, 50, 108);
color black = color(0);
color green = color(86, 193, 63);
color white = color(255);
color orange = color(224, 77, 22);

void setup(){
  //sets the size of the window
  size(800, 800);
}

void draw(){
  

  noStroke();
  if(mousePressed == true){
    blue = color(0, 0, 255);
  }
  //for loops which draws the first row squares
  for(int x = 20; x <= 680; x = x +130){
    int yPos = 20;
    int sqSize = 110;
    fill(blue);
    rect(x, yPos, sqSize, sqSize);
    for(int y = 150; y <= 680; y = y + 130){
      fill(blue);
      rect(x, y, sqSize, sqSize);
    }
  }
  //for loops which draws the first row circles
  for(int y = 75; y <= 760; y = y + 130){
    int yPos = 75;
    int circSize = 10; 
    fill(white);
    ellipse(y, yPos, circSize, circSize);
  }

}