float endA = 0.0;
int diameter;
float a;
float p = PI/50;
color c = 255;
int counter = 0;

void setup() {
  size(800, 800); 
  frameRate(10000);
}

void draw() {
  background(0);
  stroke(0, 0, counter, 50);
  strokeWeight(1);

  
  for (float a = p; a <= endA;  a+= p) {
    line(sin(a)*a*5+150, cos(a)*a*2+100, 40*a/4*(a)+20, 400*a);
  }
  for (float a = p; a <= endA;  a+= p) {
    line(sin(a)*a*10+400, cos(a)*a*4+200, 40*a/3*(a)+20, 400*a);
  }
  for (float a = p; a <= endA;  a+= p) {
    line(sin(a)*a*15+650, cos(a)*a*6+300, 40*a/2*(a)+20, 400*a);
  }
  
  endA=endA+p;
  counter ++;
}