/* LineChart tab, WheeStat6_0 GUI sketch
 chartsSetup() -- initiallizes charts
 --called in setup loop
 displayCharts() -- sets up and displays charts
 -- called in draw loop
 setLimits() -- sets limits on x and y displays
 */



void displayCharts() {

 setCharts();   //display background axes labels, etc
 for (int y = 1; y<10; y++) {
    if (showChart[y] == true) {
      firstChart = false;       // not used?  intiallized on main tab
    }
    }

  //////////// read data and graph it /////////////////
  if (run==true) {
    limsCalcd = false;
    fileCount = runCount;  // moved
    read_serial();
//    lineChart[0].setData(xData, yData);
    lineChart[runCount].setData(xData, yData);
    
    if(runCount==0){   // run is true, first voltammagram
    calcLimits(true,true);   // new funtion 5/12/17
    }
    else{             // run is true, not first volts.
   //       fileCount = runCount-1;  //  moved
          calcLimits(true,false);
    }
             try {
           

 //     if(runCount ==0){
      setLimits(lineChart[0]);
   //   }
      lineChart[0].draw(250, 70, 430, 420);
    }
    catch(Exception e) {
      println("problem with drawing lineChart[0]");
    }
    if(run==true && runCount!=0){
    
     for(int w = runCount; w>0; w--){
 //      int x = w; //runCount-w;                  // x decreases from runCount to 1
//       int y = w+1;                         // y increases from 1 to runCount
       if(showChart[w] == true){
     setLimits(lineChart[w]);
    // lineChart[x].setData(xRecover[w], yRecover[w]);  
     lineChart[w].draw(270,80,400,400);
     }
     }
     // moved
           if(runCount !=0){
      setLimits(lineChart[runCount]);
      lineChart[runCount].draw(270,80,400,400);
      }
  }   // end of else loop from line 30
/*         try {
           

      if(runCount !=0){
      setLimits(lineChart[runCount]);
      lineChart[runCount].draw(270,80,400,400);
      }
 //     if(runCount ==0){
      setLimits(lineChart[0]);
   //   }
      lineChart[0].draw(250, 70, 430, 420);
    }
    catch(Exception e) {
      println("problem with drawing lineChart[0]");
    }*/
  }  
  ////////////////// end of "if run is true" loop ////////////////
else{               // start of "if run is false" loop
//  if (run == false && runCount >0) { 
    if (runCount != 0 && limsCalcd == false) { 
 /*   lineChart[0].setData(xRecover[runCount-1], yRecover[runCount-1]);
        chartXMax = 0; 
        chartXMin = 0; 
        chartYMax = 0; 
        chartYMin = 0;*/
      calcLimits(false,false);
      limsCalcd = true;
     }


  setLimits(lineChart[0]);
    try {
      lineChart[0].draw(250, 70, 430, 420);
    }
    catch(Exception e) {
      println("problem with drawing lineChart[0]");
    }

  for (int k = 1; k<=runCount; k++) {
 //   int p = fileCount - k;
    if (showChart[k] == true) {   // problem with array index out of bounds
                   // remember that chart[0] is sized different than other charts
      //   lineChart[p].setData(xRecover[k], yRecover[k]);  
                   // puts most recent chart in file 0, 1st chart in highest file number

       setLimits(lineChart[k]);
       lineChart[k].draw(270, 80, 400, 400);  // draw linechart[0] is below

      // line chart 0 params: 250, 70, 430,420
    }
  }   // end of k loop
} // end of "else" loop (run is false line 67)
//  for (int m = 0; m<runCount; m++) {
    for (int m = runCount-1; m>=0; m--) {
          if (selectBox[m] == true) {
        fill(selected);
        stroke(selected);
        rect(legBoxX+40, 20*m + legBoxY-5, 100, 20);    // selection box, 
        fill(255);
      }
    if (showChart[m] == true) {
      legend(m, (m)*20); 
   //   legend(fileCount-m, (m)*20);         // display legend next to file name, defined in  legend tab
                                            //  need "fileCount-h to get colors correct (they change)
//  select box color was here
    } // end of "if showChart m is true" loop
    if (showChart[m] == true || hideChart[m] == true) {    // chart can be shown, hidden, or not exist
      textAlign(LEFT);
      stroke(255);                    // added 8-12-15
      fill(255);
      text(sFileName[m], legBoxX+50, 20*m+legBoxY + 10);  // was 780, 130
    }
  }  // end of m loop, line 126
if(run == false){
}
  }     // from line 22


void setLimits(XYChart thing) {
  if(zoomed == false){
  thing.setMaxX(chartXMax);
  thing.setMaxY(chartYMax);
  thing.setMinX(chartXMin);
  thing.setMinY(chartYMin);
  }
  else{
  thing.setMaxX(zoomXMax);
  thing.setMaxY(zoomYMax);
  thing.setMinX(zoomXMin);
  thing.setMinY(zoomYMin);
  }
}

void calcLimits(boolean running, boolean first){
    if(running == true){
      if(first == true){  // if running first voltammagram
    chartXMax = xMax[0];
    chartYMax = yMax[0];
    chartXMin = xMin[0];
    chartYMin = yMin[0];
      }
     else{  // do this if running but not first
    chartXMax = max(chartXMax, xMax[runCount]);
    chartYMax = max(chartYMax, yMax[runCount]);
    chartXMin = min(chartXMin, xMin[runCount]);
    chartYMin = min(chartYMin, yMin[runCount]);   // changed from zero
    }
    }
    else{   // do this if not running.
    
   for (int b=0; b<10; b++) {

int h = b+1;
    if (showChart[b] == true) {     // determine axes max and mins

      if (first == true) {          // for first shown graph, set Max and Min values
//     calcLimits(false,true);
        chartXMax = xMax[h]; 
        chartXMin = xMin[h]; 
        chartYMax = yMax[h]; 
        chartYMin = yMin[h]; 
        firstChart = false;
      } else {                        // 

    chartXMax = max(chartXMax, xMax[h]);
    chartYMax = max(chartYMax, yMax[h]);
    chartXMin = min(chartXMin, xMin[h]);
    chartYMin = min(chartYMin, yMin[h]);

      }

    }  // end of loop for determining axes parameters
  }   // end of b loop  

    }
  }  // end of void calcLimits

void setCharts(){
  fill(#EADFC9);               // background color
  int chartPosX = 200;        // position of background rectangle
  int chartPosY = 70;
  int chartSzX = 475;         // size of background rectangle
  int chartSzY = 450;
  translate(chartPosX, chartPosY);
  //  rect(200, 70, 475, 450);    // chart background 
  rect(0, 0, chartSzX, chartSzY);    // chart background 
  fill(0, 0, 0);
  int posX = 20; //220;  // x position for center of y axis
  int posY = chartSzY/2; //260;  // y position for center of y axis
  translate(posX, posY);
  rotate(3.14159*3/2);
  textAlign(CENTER);
  text("Current  (microamps)", 0, 0);
  rotate(3.14159/2);        // return orientation and location
  translate(-posX, -posY);
  translate(-chartPosX, -chartPosY);  

  //if (runMode=="ChronoAmp"||runMode=="ChronoAmp2") { 
  if (iMod==5||iMod==6) { 
    xChartLabel = "Time (milliseconds)";
  } else {
    xChartLabel = "Voltage (mV)";
  }

  posX = 475;
  posY = 515;
  translate(posX, posY);
  textAlign(CENTER);
  text(xChartLabel, 0, 0);
  translate(-posX, -posY);  
}
  ///////////////// end of setCharts setup //////////////////
  
  void chartsSetup() {             // called in setup() routine
  for (int y = 0; y<10; y++) {
    lineChart[y] = new XYChart(this);
    if (y == 0) {
      lineChart[y].showXAxis(true);
      lineChart[y].showYAxis(true);
    }
    lineChart[y].setPointColour(color(red[y], green[y], blue[y]));
    lineChart[y].setPointSize(5);
    lineChart[y].setLineWidth(2);
  }
}                        // end of chart setup