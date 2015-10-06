/*
=================================================
Kai Young
SCIMA 300
9/28/15

This is the exercise from Chapter 3 from Ben
Fry's Visualizing Data.
=================================================
*/
PImage mapImage;
Table locationTable;
Table nameTable;
int rowCount;
Table dataTable;
//float dataMin = MAX_FLOAT;
//float dataMax = MIN_FLOAT;

//resets the minimum and maximum values
//this is to accomodate user input
float dataMin = -10;
float dataMax = 10;

//the integrator to add physics
Integrator[] interpolators;

//These varaiables affect section 2 below
float closestDist;
String closestText;
float closestTextX;
float closestTextY;

void setup(){
    size(640, 400);
    mapImage = loadImage("map.png");
    
    /* 
    First load the font under tools > create font
    this puts in the data folder. Then set up the
    font using the code below
    */
    PFont font = loadFont("Univers-Bold-12.vlw");
    textFont(font);
    
    smooth();
    noStroke();
    //Make a data table from a file that contains
    //the coordinate of each state
    locationTable = new Table("locations.tsv");
    
    //Name table
    nameTable = new Table("names.tsv");
    
    //The row count will be used a lot, sto store it globally.
    rowCount = locationTable.getRowCount();
    
    //Read the data table
    dataTable = new Table("random.tsv");
    
    //Setup: load initial values into the Integrator
    interpolators = new Integrator[rowCount];
    for(int row = 0; row < rowCount; row++){
        float initialValue = dataTable.getFloat(row, 1);
        interpolators[row] = new Integrator(initialValue, 0.9, 0.1);
    }
    
    //frameRate(30);
}
    
    //Find the minimum and maximum values
    //for(int row = 0; row < rowCount; row++){
      //  float value = dataTable.getFloat(row, 1);
        //    if(value > dataMax){
          //      dataMax = value; 
           // }
            //if(value < dataMin){
             //   dataMin = value;
            //}
    //}
//}

//the draw function for everything before interactivity - section 2 below
/*
void draw(){
    background(255);
    image(mapImage, 0, 0);
    
    //Drawing attributes for the ellipses
    smooth();
    fill(0, 0, 255, 190);
    noStroke();
    
    //Loop through the rows of the locatins files and draw the points
    for(int row = 0; row < rowCount; row++){
        String abbrev = dataTable.getRowName(row);
        float x = locationTable.getFloat(row, 1); //column 1
        float y = locationTable.getFloat(row, 2); //column 2
        drawData(x, y, abbrev);
    }
}
*/

/*
=================================================
This one maps the data according to size
it takes the dataMin value and the dataMax value
remaps these to a range between 2 and 40
=================================================

//Map the size of the ellipse to the data value
void drawData(float x, float y, String abbrev){
    //Get data value for state
    float value = dataTable.getFloat(abbrev, 1);
    //Re-map the value to a number between 2 and 40
    float mapped = map(value, dataMin, dataMax, 2, 40);
    ellipse(x, y, mapped, mapped);
}
*/

/*
=================================================
This one maps the data according to color
it uses the lerpColor function which interpolates
between two colors instead of size
=================================================

void drawData(float x, float y, String abbrev){
    float value = dataTable.getFloat(abbrev, 1);
    float percent = norm(value, dataMin, dataMax);
    //color between = lerpColor(#FF4422, #4422CC, percent);  //red to blue
    color between = lerpColor(#296F34, #61E2F0, percent, HSB);  //red to blue
    fill(between);
    ellipse(x, y, 15, 15);
}
*/

/*
=================================================
This one uses different colors for positive and
negative values in the data set. It then changes 
the size of the ellipse to reflect the range.
=================================================

void drawData(float x, float y, String abbrev){
    float value = dataTable.getFloat(abbrev, 1);
    float diameter = 0;
    
    if(value >= 0){
        diameter = map(value, 0, dataMax, 3, 30);
        fill(#333366); //blue
    } else {
        diameter = map(value, 0, dataMin, 3, 30);
        fill(#EC5166); // red
    }
    
    ellipse(x, y, diameter, diameter);
}
*/

/*
=================================================
This example adjusts transparency to reflect 
the magnitude. The a value maps for positive 
floats if they are greater than zero or 
negative floats if they are less than zero.
=================================================

void drawData(float x, float y, String abbrev){
    float value = dataTable.getFloat(abbrev, 1);
    if(value >= 0){
        float a = map(value, 0, dataMax, 0, 255);
        fill(#333366, a); //blue
    } else {
        float a = map(value, 0, dataMin, 0, 255);
        fill(#EC5166, a);  // red
    }
    
    ellipse(x, y, 15, 15);
}
*/

/*
=================================================
Now starting to add interactivty

=================================================

void drawData(float x, float y, String abbrev){
    float value = dataTable.getFloat(abbrev, 1);
    float radius = 0;
    
    //maps the values to a range of 1.5 - 15
    //sets the colors of the values
    if (value >= 0){
        radius = map(value, 0, dataMax, 1.5, 15);
        fill(#4422CC); 
    } else {
        radius = map(value, 0, dataMin, 1.5, 15);
        fill(#FF4422);
    }
    
    //sets ellipseMode to RADIUS because using
    //the dist() function which calculates the
    //radius between the location and the mouse.
    //Helps with placement
    ellipseMode(RADIUS);
    ellipse(x, y, radius, radius);
    
    if(dist(x, y, mouseX, mouseY) < radius + 2){
        fill(0);
        textAlign(CENTER);
        
        //first example
        //Show the data value and the state abbreviation in parenthesis.
        //text(value + " (" + abbrev + ")", x, y-radius-4);   
        
        //second example
        //this one used the nameTable with the ful names
        String name = nameTable.getString(abbrev, 1);
        text(name + " " + value, x, y-radius-4);
    }
}
*/

/*
=========================================================

SECTION 2
Interactivity has been introduced and now some of the
rollover problems are addressed. For instance some states
are so close to each other that multiple names show up.

=========================================================
*/

void draw(){
    background(255);
    image(mapImage, 0, 0);
    
    
    //Draw: update the Integrator with the current values,
    //which are either those from the setup() function
    //or thise loaded by the target() function issued in 
    //upperTable();
    for(int row = 0; row < rowCount; row++){
        interpolators[row].update();
        
    }
    closestDist = MAX_FLOAT;
    
    for(int row = 0; row < rowCount; row++){
        String abbrev = dataTable.getRowName(row); 
        float x = locationTable.getFloat(abbrev, 1);
        float y = locationTable.getFloat(abbrev, 2);
        drawData(x, y, abbrev);
    }
    
    //Use global variables set in drawData()
    //to draw text related to closest circle
    if(closestDist != MAX_FLOAT){
        fill(0);
        textAlign(CENTER);
        text(closestText, closestTextX, closestTextY);
    }
}

void drawData(float x, float y, String abbrev){
    //figure out what row this is
    int row = dataTable.getRowIndex(abbrev);
    
    //Get the current value
    float value = interpolators[row].value;
    float radius = 0;
    
    if(value >=0){
        radius = map(value, 0, dataMax, 1.5, 15);
        fill(#4422CC);
    } else {
        radius = map(value, 0, dataMin, 1.5, 15);
        fill(#FF4422);
    }
    
    ellipseMode(RADIUS);
    ellipse(x, y, radius, radius);
    
    float d = dist(x, y, mouseX, mouseY);
    //Because the following check is done each time a new 
    //circle is drawn, we end up with the values of the
    //circle closest to the mouse
    
    if((d < radius +2) && (d < closestDist)){
        closestDist = d;
        String name = nameTable.getString(abbrev, 1);
        //Use target (not current) value for showing the data point.
        String val = nfp(interpolators[row].target, 0, 2);
        
        //closestText = name + " " + value;
        
        //this specifies the number of digits to the left
        //of the decimal point
        closestText = name + " " + val;
        closestTextX = x;
        closestTextY = y-radius-4;
    }
}

void keyPressed(){
    if(key == ' '){
        updateTable(); 
    }
}


void updateTable(){
    for(int row = 0; row < rowCount; row++){
        float newValue = random(-10, 10);
        interpolators[row].target(newValue);
    }
}