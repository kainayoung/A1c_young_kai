PImage mapImage;


void setup(){
 size(640,400);
 mapImage = loadImage("oakland_map.png");
}

void draw(){
 
  background(255);
 image(mapImage,0,0);
  
}