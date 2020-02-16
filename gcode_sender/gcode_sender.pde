void setup(){
  frameRate(1);
  size(400,400);
  // Initalize grbl
  senderInit("F10");
  //sender("G0 X0 Y0");
}

void testSquareRaw(){
  // Draw a square using the raw sender (construct the gcode by hand)
  println("Raw square test");
  sender("G0 X10 Y10");
  sender("G1 X110 Y10 F1000");
  sender("G1 X110 Y110 F1000");
  sender("G1 X110 Y10 F1000");
  sender("G1 X10 Y10 F1000");
}

void testSquareWrappers(){
  // Draw a square using the wrappers that construct the gcode for us
  println("Wrapper square test");
  moveTo(10, 10, 1000);
  drawTo(110, 10, 1000);
  drawTo(110, 110, 1000);
  drawTo(110, 10, 1000);
  drawTo(10, 10, 1000);
}

void testCircle(){
  //  Generate some data to test sending a lot of small segments
  // In this case an array of points on a circle
      
  println("Draw circle test");
  PVector[] pointArray = new PVector[361];
  int radiusMultiplier = 50;
  PVector centerPoint = new PVector(200,200);
  for(int i=0; i<=360; i++){
    pointArray[i] = new PVector();
    pointArray[i].x = (cos(radians(i))*radiusMultiplier) + centerPoint.x;
    pointArray[i].y = (sin(radians(i))*radiusMultiplier) + centerPoint.y;

    stroke(155);
    point(pointArray[i].x, pointArray[i].y);
  }
  
  // Iterate over the array of points on a circle and send them to grbl
  
  for(int i=0; i<=360; i++){
    //sender("G1 X" + str(pointArray[i].x) + " Y" + str(pointArray[i].y) + " F5000");  // Constuct the gcode ourseves (as a string)
    drawTo(pointArray[i].x, pointArray[i].y, 1000);  // Use the wrapper to construct the gcode (just send the coords and a feed
  }
}

void testError(){
  println("Test error handling");
  sender("notvalidgcode"); //Send some junk to make sure we handle errors  
}

void draw(){
  // Tests for the gcodeSender functions
  
  testError();  // Test that we handle errors
  
  testSquareRaw();  // Draw a square using the raw string sender
  
  testSquareWrappers();  // Draw a square using the moveTo() & drawTo() wrappers
  
  testCircle();  // Draw a circle
}
