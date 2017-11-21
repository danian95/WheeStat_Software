// Com_Port tab
// code on this tab sets up communications with the launchpad

void setupComPort() {


  /////////  connect button ////////////
  cp5Com = new ControlP5(this); 
  cp5Com.addButton("connect")
    .setPosition(10, 10)
      .setSize(45, 20)
        //   .setImages(imgs)
        //    .updateSize()
        ;
}



/////////// connect button program //////////

public void connect() {
  println("connect button pressed");
  try {
       serialPort.clear();
       serialPort.stop();
  }
    catch(Exception e) {}
  char cData = 'a';
  comList = null;
  comList = Serial.list();  
  int n = comList.length;
  println("com list length = "+n);
  if (n == 0) { 
    comStatTxt = "No com ports detected";

}
  else {
    int k = 9999;
//    comStatTxt = "Multiple com ports detected";
    for (int m = 0; m <= n-1; m++) {
      try {
      serialPort = new Serial(this, comList[m], 9600);
      serialPort.write('*');         // should this be *?  was &
      // listen for return character '&'
      delay(100);
      if (serialPort.available () <= 0) {
        println (comList[m]+" not responsive");
      }
      if (serialPort.available() > 0)
      {
        cData =  serialPort.readChar();
        if (cData == '&') {
          println (comList[m]+" responsive");
          k = m;
        }else {
          println("Com port says: "+cData);
        }
        serialPort.clear();
        serialPort.stop();
      }
    }                       //  end of try loop
          catch(Exception e) {

      print(comList[m]);
      println(" not responsive");
    }    /// end of catch thing ///////////////

    }  // end of itterative look at ports
    if (k == 9999) {
      comStatTxt = "No responsive port";
    } else {
      serialPort = new Serial(this, comList[k], 9600); 
      comStatTxt = "Connected on "+comList[k];
      Comselected = true;
    }
  }
}