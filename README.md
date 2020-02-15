# Processing gcode sender
 
processing_gcode_sender is an attempt at creating a gcode sender for processing and grbl to enable sending drawings to drawing machines on the fly.

Configure the serial port in gcodeSender.pde e.g. Serial myPort = new Serial(this, "COM9", 115200); (change "COM9" to match the serial port you are using to communicate with grbl)
