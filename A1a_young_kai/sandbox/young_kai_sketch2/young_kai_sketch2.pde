int xDir = 1;
int yDir = 1;
int xPos = 1;
int yPos = 1;

void setup() {
  size(500, 800);
  frameRate(500);
}

void draw() {
  background(0);
  stroke(255);
  if (xPos <= 500 && yPos <= 800) { 
    line(xPos, yPos, 250, 400);
    xPos += xDir;
    println(xPos);
    if (xPos == 501 && yPos <=800) {
      xPos = 500; 
      yPos += yDir;
      line(xPos, yPos, 250, 400);
        if(xPos == 500 && yPos == 801){ 
          xPos -= xDir;
          yPos = 800;
          line(xPos, yPos, 250, 400);        
        }
    }
  }
}