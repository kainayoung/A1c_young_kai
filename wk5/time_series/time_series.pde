FloatTable data;
float dataMin, dataMax;

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;

int rowCount;
int currentColumn;
int columnCount;

int yearMin, yearMax;
int[] years;

int yearInterval = 10;
int volumeInterval = 10;
int volumeIntervalMinor = 5;

PFont plotFont;

//for drawDataBars
float barWidth = 4;

void setup(){
    size(720, 405);
  
    data = new FloatTable("milk-tea-coffee.tsv");
    rowCount = data.getRowCount();
    columnCount = data.getColumnCount();

    years = int(data.getRowNames());
    yearMin = years[0];
    yearMax = years[years.length - 1];
    
    dataMin = 0;
    dataMax = ceil(data.getTableMax() / volumeInterval) * volumeInterval;
    
    //Corners of the plotted time series
    plotX1 = 120;
    plotX2 = width - 80;
    labelX = 50;
    plotY1 = 60;
    plotY2 = height - 70;
    labelY = height - 25;
    
    plotFont = loadFont("BrandonGrotesque-Regular-20.vlw");
    textFont(plotFont);
    

    
    smooth();
}

void draw(){
    background(255);
    
    //Show the plot areas as a white box
    fill(255);
    rectMode(CORNERS);
    noStroke();
    rect(plotX1, plotY1, plotX2, plotY2);
    
    drawTitle();
    drawAxisLabels();
    
    drawVolumeLabels();
    
    //strokeWeight(5);
    //Draw the data for the first column
    //stroke(#5679C1);
    //drawDataPoints(currentColumn);
    //noFill();
    //strokeWeight(2);
    //drawDataLine(currentColumn);
    //drawDataHighlight(currentColumn);
    //drawDataCurve(currentColumn);
    noStroke();
    fill(#5679C1);
    //drawDataArea(currentColumn);
    drawDataBars(currentColumn);
    drawYearLabels();
}

void drawTitle(){
    //Draw the title of the current plot
    fill(0);
    textSize(20);
    textAlign(LEFT);
    String title = data.getColumnName(currentColumn);
    text(title, plotX1, plotY1 - 10);
}

void drawAxisLabels(){
    fill(0);
    textSize(13);
    textLeading(15);
    
    textAlign(CENTER, CENTER);
    //Use \n (aka enter or linefeed) to break the text into separate lines
    text("Gallons\nconsumed\nper capita", labelX, (plotY1 + plotY2) / 2);
    textAlign(CENTER);
    text("Year", (plotX1 + plotX2) / 2, labelY);
}

void drawYearLabels(){
    fill(0);
    textSize(10);
    textAlign(CENTER, TOP);
    
    //Use thin, gray lines to draw the grid
    stroke(255);
    strokeWeight(1);
    
    for (int row = 0; row < rowCount; row++) {
        if (years[row] % yearInterval == 0) {
            float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
            text(years[row], x, plotY2 + 10);
            //line(x, plotY1, x, plotY2);
        }
    }
}

void drawVolumeLabels(){
    fill(0);
    textSize(10);
    stroke(128);
    strokeWeight(1);

    for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
        if (v % volumeIntervalMinor ==0) { //If a tick mark
          float y = map(v, dataMin, dataMax, plotY2, plotY1);
          if (v % volumeInterval == 0) { //If a major tick mark
            if (v == dataMin) {
            textAlign(RIGHT); //Align by the bottom
        } else if (v == dataMax) {
            textAlign(RIGHT, TOP); //Align by the top
        } else {
            textAlign(RIGHT, CENTER); //Center vertically
        }
        text(floor(v), plotX1 - 10, y);
        line(plotX1 - 4, y, plotX1, y); // Draw major tick
          } else {
            //Commented out; too distracting visually
            //line(plotX1 - 2, y, plotX1, y); // Draw minor tick
          }
        }
    }
}

//Draw the data as a series of points
void drawDataPoints(int col){
    for(int row = 0; row < rowCount; row++){
        if(data.isValid(row, col)){
            float value = data.getFloat(row, col);
            float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
            float y = map(value, dataMin, dataMax, plotY2, plotY1);
            point(x, y);
        }
    }
}

void drawDataLine(int col) {
    beginShape();
    int rowCount = data.getRowCount();
    for (int row = 0; row < rowCount; row++) {
        if (data.isValid(row, col)) {
            float value = data.getFloat(row, col);
            float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
            float y = map(value, dataMin, dataMax, plotY2, plotY1);
            vertex(x, y);
        }
    }
    endShape();
}

//highlights the individual data points when mouse is near
void drawDataHighlight(int col) {
    for (int row = 0; row < rowCount; row++) {
        if (data.isValid(row, col)) {  
          float value = data.getFloat(row, col);
          float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
          float y =  map(value, dataMin, dataMax, plotY2, plotY1);
          if (dist(mouseX, mouseY, x, y) < 3) {
              strokeWeight(10);
              point(x, y);
              fill(0);
              textSize(10);
              textAlign(CENTER);
              text(nf(value, 0, 2) + " (" + years[row] + ")", x, y - 8);
          }
        }
    }
}

void drawDataCurve(int col) {
    beginShape();
    for (int row = 0; row < rowCount; row++) {
        if(data.isValid(row, col)){
            float value = data.getFloat(row, col);
            float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
            float y = map(value, dataMin, dataMax, plotY2, plotY1);
            
            curveVertex(x, y);
            //double the curve points for the start and stop
            if ((row == 0) || (row == rowCount - 1)) {
                curveVertex(x, y);
            }
        }
    }
    endShape();
}

//draws the values as a filled area
void drawDataArea(int col) {
    beginShape();
    for (int row = 0; row < rowCount; row++) {
        if (data.isValid(row, col)) {
            float value = data.getFloat(row, col);
            float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
            float y = map(value, dataMin, dataMax, plotY2, plotY1);
            vertex(x, y);
        }
    }
    //Draw the lower right and lower-left corners
    vertex(plotX2, plotY2);
    vertex(plotX1, plotY2);
    endShape(CLOSE);
}

//replaces drawDataArea with a bar chart
//this is done for example with data is missing and 
//doesn't represent a complete series
void drawDataBars(int col) {
    noStroke();
    rectMode(CORNERS);
    
    for (int row = 0; row < rowCount; row++) {
        if (data.isValid(row, col)) {
            float value = data.getFloat(row, col);
            float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
            float y = map(value, dataMin, dataMax, plotY2, plotY1);
            rect(x - barWidth / 2, y, x + barWidth / 2, plotY2);
        }
    }
}

//This cycles through the columns in the data file 
//and displays milk, coffee or juice
void keyPressed(){
    if(key == '['){
        currentColumn--;
        if (currentColumn < 0){
            currentColumn = columnCount -1;
        }
    } else if (key == ']'){
        currentColumn++;
        if (currentColumn == columnCount){
            currentColumn = 0;
        }
    }
}