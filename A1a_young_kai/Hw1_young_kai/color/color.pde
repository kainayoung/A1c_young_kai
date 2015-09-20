/*====================

  Kai Young
  SCIMA 300 - Homework #1.3 
  Color Tutorial

====================*/

void setup(){
  size(600, 600);
  background(170, 170, 170);  //sets the background to white
  smooth();
  stroke(250);  // sets the stroke to almost white
  fill(255, 255, 0);  // sets the fill to yellow
  ellipse(50,50,25,25);  // draws the shape
  fill(255, 0, 255);  // sets the fill to purple
  ellipse(75,75,25,25);  // draws the shape
  fill(0, 255, 255);  // sets the fill to cyan
  ellipse(100,100,25,25);  // draws the shape
  fill(255, 255, 255);  // sets the fill to white
  ellipse(125,125,25,25);  // draws the shape
  fill(255, 255, 0);  // sets the fill to red
  ellipse(150,150,25,25);  // draws the shape
  fill(255, 0, 0);  // sets the fill to dark red
  ellipse(175,175,25,25);  // draws the shape
  fill(127, 0, 0);  // sets the fill to pale
  ellipse(200,200,25,25);  // draws the shape
  fill(255, 200, 200);  // sets the fill to purple
  ellipse(225,225,25,25);  // draws the shape
  
  noStroke();
  fill(0, 0, 255, 220);
  rect(240, 240, 100, 25);
  fill(0, 0, 255, 191);  //191 in fourth parameter means 75% opacity
  rect(240, 255, 100, 25);
  fill(0, 0, 255, 127);  //127 in fourth parameter means 55% opacity
  rect(240, 270, 100, 25);
  fill(0, 0, 255, 63);  //63 in fourth parameter means 25% opacity
  rect(240, 285, 100, 25);
}