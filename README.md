# Processing gcode sender
 
processing_gcode_sender is an attempt at creating a gcode sender function (and ultimatley make it a library) for processing to enable sending drawings to drawing machines on the fly. This is focused on grbl but should work with any similar gcode firmware that responds in the same way.

## What it isn't

This isn't a GUI gcode sender - its meant to be used from your code.
## Configuration

Configure the serial port in gcodeSender.pde e.g. `Serial myPort = new Serial(this, "COM9", 115200);` (change "COM9" to match the serial port you are using to communicate with grbl)

## Usage

Add gcodeSender.pde to your sketch then in setup() call senderInit(); and give it an initalization command to set the feedrate "F1000" e.g. `senderInit("F1000");` The command may be unnecessary (TBD) but the senderInit() waits for the grbl startup message. When this message is seen, a flag is set that allows sender() to send so without this step, sender() will not do anything useful.

Then from draw() you can call sender() and pass in your gcode command e.g. `sender("G0 X100 Y100");`

The sender() call will block until it receives a response from grbl so if you are doing generative/reactive images, this would slow that to a crawl. You probably want to pick a frame and iterate over all the points in that frame, convert them to gcode and draw that frame in a differnt thread. 
