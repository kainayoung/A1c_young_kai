float endA = 0.0;
int diameter;
float a;
float p = PI/140;
color c = 255;
int counter = 0;

void setup() {
  size(800, 800); 
  frameRate(50);
}

void draw() {
  background(0);
  stroke(c, 50);
  strokeWeight(1);

  
  for (float a = p; a <= endA;  a+= p) {
    line(cos(a)*700+400, sin(a)*700+400, 400, 400);
  }
  
  endA=endA+p;
  counter ++;
}