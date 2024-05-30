/*
Buttons tab, WheeStat6_0 GUI sketch
  save and delete buttons are initiallized in legendSetup() routine
      -- found in legend tab
  saveRun() -- saves selected files to disk in response to save button,
            -- opens file directory
  delete() -- deletes selected files
  hide()  -- toggles selected files between hiden and displayed
*/

public void saveRun() {

  int[] select = new int[0];       // create list of files to save
  int[] fileLength = new int[0];    // lengths of data files
  titles = ",";

  for (int b = 0; b<10; b++) {
    if (selectBox[b] == true) {
      select = append(select, b);
      print("file appended: "+b);
      int c = xRecover[b].length;
      fileLength = append(fileLength, c);
      print(", length = "+c);
      String title = sFileName[b];
      println(", name = "+title);
      titles += title;
      titles += ",,";
    }
  }

  int maxLength = max(fileLength);

  println("maximum file length = "+maxLength);
  println(titles);


  String[] file3 = new String[3];

  file3[0] = "header";
  file3[1] = titles;  
  file3[2] ="x data,y data";
  for (int e = 1; e<select.length; e++) {
    file3[2] += ",x data, y data";
  }
  println(file3[2]);
  file1=file3;       // program freaks if you try to re-initialize file 1

  //////////////// append data to file1
  for (int k = 0; k<maxLength; k++) {    // k = datum number

      data = "";                 // reset data file
      for (int n = 0; n<10; n++) {           // n = file number
         int m = xRecover[n].length;
      if (selectBox[n] == true) {
        if (m > k+1) {

          data += str(xRecover[n][k]);
          data += ",";
          data += str(yRecover[n][k]);
          data += ",";
        } 
        else {
          data += ",,";
        }
      }  // end of selected == true loop
    }  // end of n loop
    println(data);
    file1 = append(file1, data);
  }  
  println("end of k loop");
//  println(file1);

   selectOutput("Select a file to save:", "fileSelected");  // from WheeStat code
   
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {

    file2 = selection.getAbsolutePath();
    println("User selected " + file2);
    try {
      println("second time arround");
  //    println(file1);
      //  saveStream(file2,file1);
      saveStrings(file2, file1);
    }
    catch(Exception e) {
      println("problem in saveStream");
    }
  }
}


public void delete() {
  limsCalcd = false;
  warn = false; 
println("file,  SelectBox,  sFileName, showChart");  
       for(int t = 0; t<10; t++){
println(t+",  "+ selectBox[t]+",  "+ sFileName[t]+",  "+ showChart[t]);
     }
          //////////// ///
  for (int b = 9; b>=0; b--) {

    if (selectBox[b] == true) {
      noDels += 1;
      println("file deleted: "+b);
      runCount -= 1;
      println("Run count decremented, run count = " +runCount);
     xDataL.remove(b);         // remove data from array lists
     yDataL.remove(b);

      
      for (int c = b; c<runCount; c++) {
        println("changing values for file "+c);
        xMax[c] = xMax[c+1];
        yMax[c] = yMax[c+1];
        xMin[c] = xMin[c+1];
        yMin[c] = yMin[c+1];
        selectBox[c] = selectBox[c+1];
        sFileName[c] = sFileName[c+1];
        showChart[c] = showChart[c+1];
        hideChart[c] = hideChart[c+1];  // added 8-11-15
        
          xRecover[c] = xRecover[c+1];
          yRecover[c] = yRecover[c+1];
          lineChart[c].setData(xRecover[c], yRecover[c]);
      }
      println("made it thru limit calcs");
      showChart[runCount] = false;    // noticed that runCount decremented above
      selectBox[runCount] = false;  // changed from runCount+1
      hideChart[runCount] = false;
      sFileName[runCount] = "";

      xMax[runCount+1] = 0;
      yMax[runCount+1] = 0;
      xMin[runCount+1] = 0;
      yMin[runCount+1] = 0; 
      

 //////////// end remove file b /////////////
      println(" through delete loop");
    }
  
    else {
    print("file retained: "+b);
    }
    println(" through loop");
      }
           for (int d = 0; d<10; d++) {
      println("Show Chart "+d+" = "+showChart[d]); 
     }
println("file,  SelectBox,  sFileName, showChart");
for(int t = 0; t<10; t++){
println(t+","+ selectBox[t]+","+ sFileName[t]+","+ showChart[t]);

     }
}

void hide(){
  limsCalcd = false;
 for (int b = 0; b<10; b++){
   if(selectBox[b] == true){
     if (run == true){
       fileCount = runCount;
     }else{
       fileCount = runCount-1;  //-1;
     }
//   showChart[fileCount - b] = !showChart[fileCount-b];  // was fileCount-b
  // hideChart[fileCount - b] = !hideChart[fileCount - b];
     
   showChart[b] = !showChart[b];
   hideChart[b] = !hideChart[b];
//   print("Chart hide "+b);
  // println(hideChart[b]);
   }
 } 
 println("runCount = "+runCount + ", fileCount = "+ fileCount);
 println("file  sFileName  selectBox  showChart  hideChart");
 for (int c = 0; c< runCount; c++){
   println(c+",  "+ sFileName[c]+ ", "+  selectBox[c]+",  "+  showChart[c]+",  "+  hideChart[c]); 
 }
 println("file  xMin  xMax  yMin   yMin");
 for (int j = 0; j<=runCount; j++){
   println(j+"  "+xMin[j]+ "  "+ xMax[j] + "  "+yMin[j]+"  "+yMax[j]);
   
 }
}