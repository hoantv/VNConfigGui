// Need G4P library
import g4p_controls.*;
// You can remove the PeasyCam import if you are not using
// the GViewPeasyCam control or the PeasyCam library.
//import peasy.*;
import processing.serial.*;

GDropList dropSerialPorts; 

// Serial port state.
Serial       serialPort;
String       buffer = "";
int          baudRate = 115200;

//int[] xThressHold = {0, 0, 0, 0, 0, 0, 0};

GButton calibrate;
GSlider2D  slider2d1;
GLabel xLabel; 
GLabel x0Label; 
GLabel x1Label; 
GLabel x2Label;
GLabel yLabel; 
GLabel y0Label; 
GLabel y1Label; 
GLabel y2Label; 
GLabel y3Label; 
GCustomSlider x0; 
GCustomSlider x1; 
GCustomSlider x2; 
//GCustomSlider x3; 
//GCustomSlider x4; 
//GCustomSlider x5; 
GCustomSlider y0; 
GCustomSlider y1; 
GCustomSlider y2; 
GCustomSlider y3; 
GLabel N1Label; 
GLabel N2Label; 
GLabel N3Label;
GLabel N4Label;
GLabel N5Label;
GLabel N6Label;
GLabel NRLabel;
PImage bg;
int x = 512, y= 512;
int xi = 45, yi = 430, w = 150, h = 150;


public void setup() {
  size(801, 599, JAVA2D);
  bg = loadImage("shifter.jpg");
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
  dropSerialPorts = new GDropList(this, 12, 10, 90, 120, 3, 10);
  dropSerialPorts.setItems(availablePorts, selectedPort);
  dropSerialPorts.addEventHandler(this, "dropSerialPortList_click1");
}
//String dataFromAdruino;
//int i =0;
public void draw() {
  //clear();
  background(255);
  fill(0); 
  //background(bg);

  readDataFromArduino(); 
  strokeWeight(1);
  stroke(0, 0, 0);
  line(xi, yi, xi, yi + h);
  line(xi+w, yi, xi+w, yi + h);  
  line(xi, yi, xi+w, yi);  
  line(xi, yi+h, xi+w, yi + h);  
  strokeWeight(1.5);  
  stroke(0, 0, 200);
  line(xi+(float)x0.getValueI()*w/1024, yi, xi+(float)x0.getValueI()*w/1024, yi + h);   
  stroke(50, 100, 200);
  line(xi+(float)x1.getValueI()*w/1024, yi, xi+(float)x1.getValueI()*w/1024, yi + h); 
  stroke(0, 100, 150); 
  line(xi+(float)x2.getValueI()*w/1024, yi, xi+(float)x2.getValueI()*w/1024, yi + h);   
  //line(45+(float)x0.getValueI()*150/1024, 430, 45+(float)x0.getValueI()*150/1024, 580);
  //line(45+(float)x1.getValueI()*150/1024, 430, 45+(float)x1.getValueI()*150/1024, 580);
  //line(45+(float)x2.getValueI()*150/1024, 430, 45+(float)x2.getValueI()*150/1024, 580);
  //line(45+ (float)x*150/1024, 430, 45+(float)x*150/1024, 580);
  stroke(255, 255, 255);
  line(xi+(float)x*w/1024, yi, xi+(float)x*w/1024, yi + h); 
  stroke(255, 150, 0);
  //line(45, 430+(float)y0.getValueI()*150/1024, 195, 430+(float)y0.getValueI()*150/1024);
  line(xi, yi+(float)y0.getValueI()*h/1024, xi+w, yi+(float)y0.getValueI()*h/1024);
  stroke(150, 100, 50);
  //line(45, 430+(float)y1.getValueI()*150/1024, 195, 430+(float)y1.getValueI()*150/1024);
  line(xi, yi+(float)y1.getValueI()*h/1024, xi+w, yi+(float)y1.getValueI()*h/1024);
  stroke(50, 100, 0);
  line(xi, yi+(float)y2.getValueI()*h/1024, xi+w, yi+(float)y2.getValueI()*h/1024);
  //line(45, 430+(float)y2.getValueI()*150/1024, 195, 430+(float)y2.getValueI()*150/1024);
  stroke(0, 200, 0);
  line(xi, yi+(float)y3.getValueI()*h/1024, xi+w, yi+(float)y3.getValueI()*h/1024);
  //line(45, 430+(float)y3.getValueI()*150/1024, 195, 430+(float)y3.getValueI()*150/1024);
  stroke(255, 255, 255);
  //line(45, 430+(float)y*150/1024, 195, 430+(float)y*150/1024);
  line(xi, yi+(float)y*h/1024, xi+w, yi+(float)y*h/1024);

  strokeWeight(4);
  stroke(255, 0, 0);
  circle(xi+(float)x*w/1024, yi+(float)y*h/1024, 4);
  fill(255,0,0);
  text("1", xi + x0.getValueI()*w/1024/2 - 2, yi + y0.getValueI()*h/1024/2 + 5 );
  fill(0,255,0);
  text("3", xi + x0.getValueI()*w/1024 + (x1.getValueI()-x0.getValueI())*w/1024/2 - 2, yi + y0.getValueI()*h/1024/2+5);
  fill(0,0,255);
  text("5", xi + x1.getValueI()*w/1024 + (x2.getValueI()-x1.getValueI())*w/1024/2 - 2, yi + y0.getValueI()*h/1024/2+5);
  fill(255,150,0);
  text("2", xi + x0.getValueI()*w/1024/2 - 2, yi + y1.getValueI()*h/1024 + (1024-y1.getValueI())*h/1024/2 + 5 );
  fill(0,100,50);
  text("4", xi + x0.getValueI()*w/1024 + (x1.getValueI()-x0.getValueI())*w/1024/2 - 2, yi + y1.getValueI()*h/1024 + (1024-y1.getValueI())*h/1024/2 + 5 );
  fill(0,50,150);
  text("6", xi + x1.getValueI()*w/1024 + (x2.getValueI()-x1.getValueI())*w/1024/2 - 2, yi + y1.getValueI()*h/1024 + (1024-y1.getValueI())*h/1024/2 + 5 );
  fill(0,0,0);
  text("R", xi + x2.getValueI()*w/1024 + (1024-x2.getValueI())*w/1024/2 - 2, yi + y1.getValueI()*h/1024 + (1024-y1.getValueI())*h/1024/2 + 5 );


  //if (serialPort != null) {
  //   if ( serialPort.available() > 0) {  // If data is available,
  //   dataFromAdruino = serialPort.readString();         // read it and store it in val      
  //  }
  //}
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
  calibrate = new GButton(this, 115, 9, 80, 30);
  calibrate.setText("Start Calibration");
  calibrate.addEventHandler(this, "calibrate_click1");

  x0 = new GCustomSlider(this, 40, 50, 200, 50, "grey_blue");
  x0.setShowValue(true);
  x0.setLimits(512, 0, 1024); 
  x0.setNumberFormat(G4P.INTEGER, 0);
  x0.setOpaque(false);
  x0.addEventHandler(this, "x0_change1");

  x0Label = new GLabel(this, 0, 65, 50, 20);
  x0Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x0Label.setText("X0");
  x0Label.setOpaque(false);


  x1 = new GCustomSlider(this, 40, 100, 200, 50, "grey_blue");
  x1.setShowValue(true);
  x1.setLimits(512, 0, 1024); 
  x1.setNumberFormat(G4P.INTEGER, 0);
  x1.setOpaque(false);
  x1.addEventHandler(this, "x1_change1");

  x1Label = new GLabel(this, 0, 115, 50, 20);
  x1Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x1Label.setText("X1");
  x1Label.setOpaque(false);

  x2 = new GCustomSlider(this, 40, 150, 200, 50, "grey_blue");
  x2.setShowValue(true);  
  x2.setLimits(512, 0, 1024); 
  x2.setNumberFormat(G4P.INTEGER, 0);
  x2.setOpaque(false);
  x2.addEventHandler(this, "x2_change1");

  x2Label = new GLabel(this, 0, 165, 50, 20);
  x2Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  x2Label.setText("X2");
  x2Label.setOpaque(false);

  y0 = new GCustomSlider(this, 40, 200, 200, 50, "grey_blue");
  y0.setShowValue(true);  
  y0.setLimits(512, 0, 1024); 
  y0.setNumberFormat(G4P.INTEGER, 0);
  y0.setOpaque(false);
  y0.addEventHandler(this, "y0_change1");

  y0Label = new GLabel(this, 0, 215, 50, 20);
  y0Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y0Label.setText("Y0");
  y0Label.setOpaque(false);

  y1 = new GCustomSlider(this, 40, 250, 200, 50, "grey_blue");
  y1.setShowValue(true);  
  y1.setLimits(512, 0, 1024); 
  y1.setNumberFormat(G4P.INTEGER, 0);
  y1.setOpaque(false);
  y1.addEventHandler(this, "y1_change1");

  y1Label = new GLabel(this, 0, 265, 50, 20);
  y1Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y1Label.setText("Y1");
  y1Label.setOpaque(false);

  y2 = new GCustomSlider(this, 40, 300, 200, 50, "grey_blue");
  y2.setShowValue(true);  
  y2.setLimits(512, 0, 1024); 
  y2.setNumberFormat(G4P.INTEGER, 0);
  y2.setOpaque(false);
  y2.addEventHandler(this, "y2_change1");

  y2Label = new GLabel(this, 0, 315, 50, 20);
  y2Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y2Label.setText("Y2");
  y2Label.setOpaque(false);

  y3 = new GCustomSlider(this, 40, 350, 200, 50, "grey_blue");
  y3.setShowValue(true);  
  y3.setLimits(512, 0, 1024); 
  y3.setNumberFormat(G4P.INTEGER, 0);
  y3.setOpaque(false);
  y3.addEventHandler(this, "y3_change1");

  y3Label = new GLabel(this, 0, 365, 50, 20);
  y3Label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  y3Label.setText("Y3");
  y3Label.setOpaque(false);

  xLabel = new GLabel(this, xi + w/2-25, yi-20, 50, 20);
  xLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  xLabel.setText("X=512");
  xLabel.setOpaque(false);

  yLabel = new GLabel(this, xi + w, yi + h/2 - 10, 50, 20);
  yLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  yLabel.setText("Y=512");
  yLabel.setOpaque(false);

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

public void x2_change1(GCustomSlider source, GEvent event) { //_CODE_:x2:452324:
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

public void y0_change(GCustomSlider source, GEvent event) { //_CODE_:y1:800144:
  println("Y0 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("Y0" + String.valueOf(source.getValueI()));
} //_CODE_:y1:800144:

public void y1_change(GCustomSlider source, GEvent event) { //_CODE_:y2:738108:
  println("Y1 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("Y1" + String.valueOf(source.getValueI()));
} //_CODE_:y2:738108:

public void y2_change(GCustomSlider source, GEvent event) { //_CODE_:y3:499505:
  println("Y2 - GCustomSlider >> GEvent." + event + " @ " + millis());
  serialPort.write("Y2" + String.valueOf(source.getValueI()));
} //_CODE_:y3:499505:

public void y3_change(GCustomSlider source, GEvent event) { //_CODE_:y4:720872:
  println("Y3 - GCustomSlider >> GEvent." + event + " @ " + millis());
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
      String data = serialPort.readString();
      println(data);
      String dataFromAdruino[] = data.replace("  ", "").replace(" ", "").split(":");
      //String dataFromAdruino[] = serialPort.readString().replace("  ","").replace(" ","").split(":");         // read it and store it
      switch ( dataFromAdruino[0]) {
      case "Shifter":
        x0.setValue(Integer.parseInt(dataFromAdruino[1]));
        x1.setValue(Integer.parseInt(dataFromAdruino[2]));
        x2.setValue(Integer.parseInt(dataFromAdruino[3]));
        y0.setValue(Integer.parseInt(dataFromAdruino[7]));
        y1.setValue(Integer.parseInt(dataFromAdruino[8]));
        y2.setValue(Integer.parseInt(dataFromAdruino[9]));
        y3.setValue(Integer.parseInt(dataFromAdruino[10]));     
        break;
      case "Calibration":  
        xLabel.setText("X=" + Integer.parseInt(dataFromAdruino[1]));
        yLabel.setText("Y=" + Integer.parseInt(dataFromAdruino[2]));
        x = Integer.parseInt(dataFromAdruino[1]);
        y = Integer.parseInt(dataFromAdruino[2]);  

        break;
      default:
        break;
      }
    }
  }
}

public void calibrate_click1(GButton button, GEvent event) { 
  if (calibrate.getText() == "Start Calibration") {
    calibrate.setText("Finish Calibration");
    serialPort.write("SC"); // Start Calibration
  } else {
    calibrate.setText("Start Calibration");
    serialPort.write("FC"); // Finish Calibration
  }  
  /* code */
}

public void slider2d1_change1(GSlider2D source, GEvent event) { //_CODE_:slider2d1:781742:
  println("slider2d1 - GSlider2D >> GEvent." + event + " @ " + millis());
} 
