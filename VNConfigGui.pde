// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
import peasy.*;
import processing.serial.*;

GDropList dropSerialPorts; 

// Serial port state.
Serial       serialPort;
String       buffer = "";
int          baudRate = 115200;

int[] xThressHold = {0, 0, 0, 0, 0, 0, 0};


GLabel x0Label; 
GLabel x1Label; 
GLabel x2Label;
GLabel x3Label; 
GLabel x4Label; 
GLabel x5Label; 
GLabel y0Label; 
GLabel y1Label; 
GLabel y2Label; 
GLabel y3Label; 
GCustomSlider x0; 
GCustomSlider x1; 
GCustomSlider x2; 
GCustomSlider x3; 
GCustomSlider x4; 
GCustomSlider x5; 
GCustomSlider y0; 
GCustomSlider y1; 
GCustomSlider y2; 
GCustomSlider y3; 
PImage bg;

public void setup(){
  size(653, 364, JAVA2D);
  bg = loadImage("beach.jpg");
  createGUI();
  customGUI();
  // Serial port setup.
  // Grab list of serial ports and choose one that was persisted earlier or default to the first port. 
  int selectedPort = 0;
  String[] availablePorts = Serial.list();
   if (availablePorts == null) {
    println("ERROR: No serial ports available!");
    exit();
  }
  dropSerialPorts = new GDropList(this, 12, 10, 90, 80, 3, 10);
  dropSerialPorts.setItems(availablePorts, selectedPort);
  dropSerialPorts.addEventHandler(this, "dropSerialPortList_click1");  
  
}
//String dataFromAdruino;
//int i =0;
public void draw(){
    //background(100);
    background(bg);
    readDataFromArduino();
    
    //if (serialPort != null) {
    //   if ( serialPort.available() > 0) {  // If data is available,
    //   dataFromAdruino = serialPort.readString();         // read it and store it in val      
    //  }
    //}
     
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

  
  x0Label = new GLabel(this, 20, 50, 50, 20);
  x0Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x0Label.setText("X0");
  x0Label.setOpaque(false);
  
  x1Label = new GLabel(this, 80, 50, 50, 20);
  x1Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x1Label.setText("X1");
  x1Label.setOpaque(false);
  
  x2Label = new GLabel(this, 140, 50, 50, 20);
  x2Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x2Label.setText("X2");
  x2Label.setOpaque(false);
  
  x3Label = new GLabel(this, 200, 50, 50, 20);
  x3Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x3Label.setText("X3");
  x3Label.setOpaque(false);
  
  x4Label = new GLabel(this, 260, 50, 50, 20);
  x4Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x4Label.setText("X4");
  x4Label.setOpaque(false);
  
  x5Label = new GLabel(this, 320, 50, 50, 20);
  x5Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x5Label.setText("X5");
  x5Label.setOpaque(false);
  
  y0Label = new GLabel(this, 380, 50, 50, 20);
  y0Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y0Label.setText("Y0");
  y0Label.setOpaque(false);
  
  y1Label = new GLabel(this, 440, 50, 50, 20);
  y1Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y1Label.setText("Y1");
  y1Label.setOpaque(false);
  
  y2Label = new GLabel(this, 500, 50, 50, 20);
  y2Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y2Label.setText("Y2");
  y2Label.setOpaque(false);
  
  y3Label = new GLabel(this, 560, 50, 50, 20);
  y3Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y3Label.setText("Y3");
  y3Label.setOpaque(false);

  
  x0 = new GCustomSlider(this, 70, 80, 120, 50, "grey_blue");
  x0.setShowValue(true);
  x0.setRotation(PI/2, GControlMode.CORNER);
  x0.setLimits(500, 0, 1024);
  x0.setNumberFormat(G4P.INTEGER, 0);
  x0.setOpaque(false);
  x0.addEventHandler(this, "x0_change1");
  
  x1 = new GCustomSlider(this, 130, 80, 120, 50, "grey_blue");
  x1.setShowValue(true);
  x1.setRotation(PI/2, GControlMode.CORNER);
  x1.setLimits(500, 0, 1024);
  x1.setNumberFormat(G4P.INTEGER, 0);
  x1.setOpaque(false);
  x1.addEventHandler(this, "x1_change1");

  x2 = new GCustomSlider(this, 190, 80, 120, 50, "grey_blue");
  x2.setShowValue(true);
  x2.setRotation(PI/2, GControlMode.CORNER);
  x2.setLimits(500, 0, 1024);
  x2.setNumberFormat(G4P.INTEGER, 0);
  x2.setOpaque(false);
  x2.addEventHandler(this, "X2_change1");
  

  x3 = new GCustomSlider(this, 250, 80, 120, 50, "grey_blue");
  x3.setShowValue(true);
  x3.setRotation(PI/2, GControlMode.CORNER);
  x3.setLimits(500, 0, 1024);
  x3.setNumberFormat(G4P.INTEGER, 0);
  x3.setOpaque(false);
  x3.addEventHandler(this, "x3_change1");
  
  x4 = new GCustomSlider(this, 310, 80, 120, 50, "grey_blue");
  x4.setShowValue(true);
  x4.setRotation(PI/2, GControlMode.CORNER);
  x4.setLimits(500, 0, 1024);
  x4.setNumberFormat(G4P.INTEGER, 0);
  x4.setOpaque(false);
  x4.addEventHandler(this, "x4_change1");
  
  x5 = new GCustomSlider(this, 370, 80, 120, 50, "grey_blue");
  x5.setShowValue(true);
  x5.setRotation(PI/2, GControlMode.CORNER);
  x5.setLimits(500, 0, 1024);
  x5.setNumberFormat(G4P.INTEGER, 0);
  x5.setOpaque(false);
  x5.addEventHandler(this, "x5_change1");
  
  y0 = new GCustomSlider(this, 430, 80, 120, 50, "grey_blue");
  y0.setShowValue(true);
  y0.setRotation(PI/2, GControlMode.CORNER);
  y0.setLimits(500, 0, 1024);
  y0.setNumberFormat(G4P.INTEGER, 0);
  y0.setOpaque(false);
  y0.addEventHandler(this, "y0_change1");
  
  y1 = new GCustomSlider(this, 490, 80, 120, 50, "grey_blue");
  y1.setShowValue(true);
  y1.setRotation(PI/2, GControlMode.CORNER);
  y1.setLimits(500, 0, 1024);
  y1.setNumberFormat(G4P.INTEGER, 0);
  y1.setOpaque(false);
  y1.addEventHandler(this, "y1_change1");
  
  y2 = new GCustomSlider(this, 550, 80, 120, 50, "grey_blue");
  y2.setShowValue(true);
  y2.setRotation(PI/2, GControlMode.CORNER);
  y2.setLimits(500, 0, 1024);
  y2.setNumberFormat(G4P.INTEGER, 0);
  y2.setOpaque(false);
  y2.addEventHandler(this, "y2_change1");
  
  y3 = new GCustomSlider(this, 610, 80, 120, 50, "grey_blue");
  y3.setShowValue(true);
  y3.setRotation(PI/2, GControlMode.CORNER);
  y3.setLimits(500, 0, 1024);
  y3.setNumberFormat(G4P.INTEGER, 0);
  y3.setOpaque(false);
  y3.addEventHandler(this, "y3_change1");

}

public void dropSerialPortList_click1(GDropList source, GEvent event) { //_CODE_:dropSerialPorts:920870:
  setSerialPort(dropSerialPorts.getSelectedText());
  //readDataFromArduino();
} 


public void x0_change1(GCustomSlider source, GEvent event) { //_CODE_:x0:616385:
  println("x0 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("X0" + String.valueOf(source.getValueI()));
  
} //_CODE_:x0:616385:

public void x1_change1(GCustomSlider source, GEvent event) { //_CODE_:x1:548566:
  println("x1 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("X1" + String.valueOf(source.getValueI()));
} //_CODE_:x1:548566:

public void X2_change1(GCustomSlider source, GEvent event) { //_CODE_:x2:452324:
  println("x2 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("X2" + String.valueOf(source.getValueI()));
} //_CODE_:x2:452324:

public void x3_change1(GCustomSlider source, GEvent event) { //_CODE_:x3:995550:
  println("x3 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("X3" + String.valueOf(source.getValueI()));
} //_CODE_:x3:995550:

public void x4_change1(GCustomSlider source, GEvent event) { //_CODE_:x4:589939:
  println("x4 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("X4" + String.valueOf(source.getValueI()));
} //_CODE_:x4:589939:

public void x5_change1(GCustomSlider source, GEvent event) { //_CODE_:x5:280289:
  println("x5 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("X5" + String.valueOf(source.getValueI()));
} //_CODE_:x5:280289:

public void y1_change1(GCustomSlider source, GEvent event) { //_CODE_:y1:800144:
  println("Y1 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("Y0" + String.valueOf(source.getValueI()));
} //_CODE_:y1:800144:

public void y2_change1(GCustomSlider source, GEvent event) { //_CODE_:y2:738108:
  println("Y2 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("Y1" + String.valueOf(source.getValueI()));
} //_CODE_:y2:738108:

public void y3_change1(GCustomSlider source, GEvent event) { //_CODE_:y3:499505:
  println("Y3 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("Y2" + String.valueOf(source.getValueI()));
} //_CODE_:y3:499505:

public void y4_change1(GCustomSlider source, GEvent event) { //_CODE_:y4:720872:
  println("Y4 - GCustomSlider >> GEvent." + event + " @ " + millis());
   serialPort.write("Y3" + String.valueOf(source.getValueI()));
} //_CODE_:y4:720872:

void setSerialPort(String portName) {
  // Close the port if it's currently open.
  if (serialPort != null) {
    serialPort.write('L'); 
    serialPort.stop();
  }
  try {
    // Open port.
    serialPort = new Serial(this, portName, baudRate);
    //serialPort.bufferUntil('\n');
    serialPort.write('W');    // send W to ask who is it?  
  }
  catch (RuntimeException ex) {
    // Swallow error if port can't be opened, keep port closed.
    serialPort = null; 
  }
}

void readDataFromArduino() {
      if (serialPort != null) {
       if ( serialPort.available() > 0) {  // If data is available,
        String dataFromAdruino[] = serialPort.readString().replace("  ","").replace(" ","").split(":");         // read it and store it
        switch ( dataFromAdruino[0]) {
          case "Shifter":
             x0.setValue(Integer.parseInt(dataFromAdruino[1]));
             x1.setValue(Integer.parseInt(dataFromAdruino[2]));
             x2.setValue(Integer.parseInt(dataFromAdruino[3]));
             x3.setValue(Integer.parseInt(dataFromAdruino[4]));            
             x4.setValue(Integer.parseInt(dataFromAdruino[5]));
             x5.setValue(Integer.parseInt(dataFromAdruino[6]));
             y0.setValue(Integer.parseInt(dataFromAdruino[7]));
             y1.setValue(Integer.parseInt(dataFromAdruino[8]));
             y2.setValue(Integer.parseInt(dataFromAdruino[9]));
             y3.setValue(Integer.parseInt(dataFromAdruino[10]));
          break;
          default:
          break;
        }        
      }
    }
}

// boolean isInteger(String str) {
//    if (str == null) {
//        return false;
//    }
//    int length = str.length();
//    if (length == 0) {
//        return false;
//    }
//    int i = 0;
//    if (str.charAt(0) == '-') {
//        if (length == 1) {
//            return false;
//        }
//        i = 1;
//    }
//    for (; i < length; i++) {
//        char c = str.charAt(i);
//        if (c < '0' || c > '9') {
//            return false;
//        }
//    }
//    return true;
//}
