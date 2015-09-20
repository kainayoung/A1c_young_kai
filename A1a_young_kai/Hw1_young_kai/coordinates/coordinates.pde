/*====================

  Kai Young
  SCIMA 300 - Homework #1.2 
  Coordinates Tutorial

====================*/

void setup(){
  size(600, 600);
  background(250);
  color c1 = color(25, 120, 6, 7); 
  point(10, 10);
  point(20, 20);
  point(30, 30);
  line(100, 100, 200, 200);
  rect(130, 130, 75, 75);
  rectMode(CENTER);
  fill(c1);
  rect(150, 150, 75, 75);
  rectMode(CORNERS);
  rect(150, 150, 225, 225);
  ellipseMode(CENTER);
  ellipse(300,300, 50, 50);
  ellipseMode(CORNER);
  ellipse(300, 300, 75, 75);
  ellipseMode(CORNERS);
  ellipse(230, 230, 380, 380);
}