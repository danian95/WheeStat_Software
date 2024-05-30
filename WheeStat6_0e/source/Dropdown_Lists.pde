
 ///////////// mode dropdown list /////////////////////////////
void    dropDownSetup(){
   cp5Mode = new ControlP5(this); 

   cp5Mode.addScrollableList("mode")
//  mode = cp5Mode.addDropdownList("list-2", 260, 30, 80, 184)  // last digit was 124
    .setPosition(260,30)
    .setSize(80,184)
    .setBackgroundColor(color(200))
    .setItemHeight(20)
    .setBarHeight(20)
    .addItems(list)

  ;
  
}

//////////////////////// new dropdown stuff ///////////////////////
void mode(int n){  //, String text) {
//  String text = string(list[n]);
  println("value of n = "+n);
//  print(", text");
//  println (text);
iMod = n;
      Modesel = true;
//  println(n, cp5Mode.get(ScrollableList.class, "mode").getItem(n));
}
/////////////////////////////////////////////////group programs/////////////////////////////////

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) 
  {

    if (theEvent.getName().equals("list-3")) {
      float ovr = theEvent.getGroup().getValue(); 
      overlay = int(ovr);
    }
  }
}