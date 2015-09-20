/*====================

  Kai Young
  SCIMA 300 - Homework #1.1 
  Getting Started Tutorial

====================*/

void setup(){
  background(0);
  size(400, 400);
}

void draw(){

  if(mousePressed){
    noFill();
    stroke(255, 125);
  } else {
    fill(0, 0, 255, 20);
  }
  ellipse(mouseX, mouseY, 80, 80);
}