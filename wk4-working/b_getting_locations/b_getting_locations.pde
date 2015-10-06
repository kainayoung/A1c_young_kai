// introduce variables and objects
int currentRow = 0;
PImage mapImage;
Table nameTable;
PrintWriter writer;

//void setup() loops once
void setup(){
 size(1152, 626);
//assign image to variable
 mapImage = loadImage("oakland_map.png");
 // assign tables 
 nameTable = new Table("names.tsv");
 // create a "writer" that writes to a file
 writer = createWriter("data/locations.tsv");
 //make cursor crosshairs
 cursor(CROSS); 
 //println for instructions
 println("click");
}
void draw(){
  //call image variable and position it
 image(mapImage, 0, 0); 
}
void mousePressed(){
  //this is what happens every time the mouse is clicked::::
  //if the current row does not equal (!=) -1::::
 if(currentRow != -1){
   //assign the current row as a string to the String variable called "id"
   String id = nameTable.getRowName(currentRow);
   //print row to locations.tsv
   writer.println(id+ "\t"+ mouseX+ "\t"+ mouseY); 
   //print more instructions to the console
   println(id, mouseX, mouseY);
 } 
   //go to the next row
   currentRow++;
   
   //if we get to the end of the file
 if(currentRow == nameTable.getRowCount()){
   //close the file and finish
   writer.flush();
   writer.close();
   exit();
 } else{ //ask for the next coordinate using println()
   String name = nameTable.getString(currentRow,1);
   println("choose next location");
   println(name);
 } 
}