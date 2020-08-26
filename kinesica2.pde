// Sending Data from multiple sensors to Processing

// Read serial data until a linefeed character is found

// Data are values comma separated. Split the data and convert it

// into numbers in an array for further use.



import processing.serial.*;

import mqtt.*;



MQTTClient client;



Serial myPort;

int linefeed = 10;   // Linefeed in ASCII

int numSensors = 4;  // we will be expecting for reading data from four sensors

int sensors[];       // array to read the 4 values

int psensors[];

int segLinea = 2; 
float posX=10;
float posY=10;

int sensorNum;

der dlineas;
izq ilineas;
up ulineas;
down dolineas;


void setup() {

  size(500, 500);
  background(11);

  dlineas = new der();
  ilineas = new izq();
  ulineas = new up();
  dolineas = new down();


  psensors = new int[numSensors];

  psensors[0] = 0;
  psensors[1] = 0;
  psensors[2] = 0;
  psensors[3] = 0;


  // List all the available serial ports in the output pane.

  // You will need to choose the port that the Wiring board is

  // connected to from this list. The first port in the list is

  // port #0 and the third port in the list is port #2.

  println(Serial.list());



  myPort = new Serial(this, Serial.list()[0], 9600);

  // read bytes into a buffer until you get a linefeed (ASCII 10):

  myPort.bufferUntil(linefeed);





  client = new MQTTClient(this);

  client.connect("mqtt://5c227202:42c8b8b370bc244e@broker.shiftr.io", "PCC");
}



void draw() {

  if (sensors != null) {

    //background(111);
    translate (posX, posY);
    strokeWeight(10);


    if (sensors[3]!= psensors[3]) {
      client.publish("/der", ""+sensors[3]);
      dlineas.derecha();
      psensors[3] = sensors[3];
    } else if (sensors[0]!=psensors[0]) {
      client.publish("/izq", ""+sensors[0]);
      ilineas.izquierda();
      psensors[0] = sensors[0];
    } else if (sensors[1]!=psensors[1]) {
      client.publish("/down", ""+sensors[1]);
      dolineas.abajo();
      psensors[1] = sensors[1];
    } else if (sensors[2]!= psensors[2]) {
      client.publish("/up", ""+sensors[2]);
      ulineas.arriba();
      psensors[2] = sensors[2];
    }
  }
  // Do something with the sensor values
}




//void keyPressed() {
//}



void clientConnected() {

  println("client connected");





  client.subscribe("/up");
  client.subscribe("/down");
  client.subscribe("/izq");
  client.subscribe("/der");
}

void messageReceived(String topic, byte[] payload) {

  //println("new message: " + topic + " - " + new String(payload));

  //String temp = new String(payload);

  if (topic.equals("/der") == true) {

    dlineas.derecha();
  } else if (topic.equals("/izq") == true) {

    ilineas.izquierda();
  } else if (topic.equals("/down") == true) {

    dolineas.abajo();
  } else if (topic.equals("/up") == true) {

    ulineas.arriba();
  }
}



void connectionLost() {

  println("connection lost");
}



void serialEvent(Serial myPort) {



  // read the serial buffer:

  String myString = myPort.readStringUntil(linefeed);



  // if you got any bytes other than the linefeed:

  if (myString != null) {



    myString = trim(myString);



    // split the string at the commas

    // and convert the sections into integers:

    sensors = int(split(myString, ','));



    // print out the values you got:



    for (sensorNum = 0; sensorNum < sensors.length; sensorNum++) {

      print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
    }





    // add a linefeed after all the sensor values are printed:

    println();
  }
}
