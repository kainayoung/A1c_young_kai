PImage mapImage;


void setup(){
 size(1152, 626);
 mapImage = loadImage("oakland_map.png");
}

void draw(){
 
  background(255);
 image(mapImage,0,0);
  
}