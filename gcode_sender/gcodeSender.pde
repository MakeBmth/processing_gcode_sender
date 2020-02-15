/*Copyright 2020 Mark Benson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

This is a gcode sender for grbl.

Currently you set the port in this file. Need to improve this so it can be configured from where it is called but for now it
works as is.
*/

import processing.serial.*;

Serial myPort = new Serial(this, "COM9", 115200);
int counter =0;
boolean grblInit = false;


String getGrblResponse(){
  // Blocks until we see a new line (the GRBL end of response terminator)
  String response = null;
  print("Waiting for grbl"); //<>//
  while (myPort.available() == 0){
    print(".");
    delay(1000);
  }
  // Port is availalbe so read its contents.
  while (myPort.available() > 0){
    response = myPort.readString();
  }
  println("");  // This sends a newline after the dots to ensure the next console message is on its own line.
  return response;
}


String sendGrblCommand(String command){
  // Send a gcode command and get and return the response
  print("Sending: "); //<>//
  println(command);
  myPort.write(command);
  myPort.write(10);  // Send newline char '\n' (10 in ASCII)
  return getGrblResponse();  // Get and return the response
}


void senderInit(String initCommand) {
  // Initalization: waits for the grbl startup string then sends the initCommand passed in. //<>//
  String response = "";
  while(!grblInit){
    response = getGrblResponse();
    if (response != null){
      if (response.contains("Grbl")) {
        grblInit = true;
        println("Grbl initalized");
  
        print("Sending init command: ");
        println(initCommand);
        response = sendGrblCommand(initCommand);
        if (response.contains("ok")){
          println("Init command received ok");
        }
      }
      println("Exiting init. GRBL should be ready to receive commands.");
    }
  }
}


void sender(String gcode) {
  // Sends to gcode string grbl and handle the responses //<>//
  String response = "";
  if (grblInit) {
    response = sendGrblCommand(gcode);
    
    if (response.contains("ok")) {
      print("Command received: ");
      println(response);
    }
    else if(response.contains("error")){
      print("Error received: ");
      println(response);
      //grblInit == false;
    }
    else{
      print("Didn't recognise the response: ");
      println(response);
    }
  }
}