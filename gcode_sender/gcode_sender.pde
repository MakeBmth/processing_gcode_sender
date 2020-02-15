void setup(){
  frameRate(1);
  // Initalize grbl
  senderInit("F10");
}

void draw(){
  // Send some test gcode forever - Need to check that the drawing machine/grbl can keep up and doesn't glitch after a few hundred commands
  sender("G0 X10 Y100");
  sender("G0 X100 Y10");
  sender("G0 X100 Y100");
  sender("G0 X0 Y0");
  sender("notvalidgcode"); //Send some junk to make sure we handle errors
}
