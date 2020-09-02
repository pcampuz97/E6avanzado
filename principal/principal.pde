import processing.video.*;

import processing.serial.*;

import mqtt.*;

Particle particles[];

//PImage frog;
Capture video;

MQTTClient client;

 

Serial myPort;

int linefeed = 10;   // Linefeed in ASCII

int numSensors = 1;  // we will be expecting for reading data from four sensors

int sensors[];       // array to read the 4 values

int pixOp = 100; //opacidad de los pixeles

boolean seg1 = false;
boolean seg2 = false;
boolean seg3 = false;
boolean seg4 = false;
boolean seg5 = false;
boolean seg6 = false;
boolean seg7 = false;
boolean seg8 = false;
boolean seg9 = false;
boolean seg0 = false;
 

void setup() {

  size(640,360); // tamaño
  
  video = new Capture(this); //Captura del video
  
  particles = new Particle[2400]; //arraylist de las particulas
  
  for (int i = 0; i < particles.length; i++) { //Creación de las particulas
    particles[i] = new Particle();
  } 
  
  background(50); //Color del fondo
  
  // List all the available serial ports in the output pane.

  // You will need to choose the port that the Wiring board is

  // connected to from this list. The first port in the list is

  // port #0 and the third port in the list is port #2.

  println(Serial.list());

 

  myPort = new Serial(this, Serial.list()[32], 9600);

  // read bytes into a buffer until you get a linefeed (ASCII 10):

  myPort.bufferUntil(linefeed);

 

 

  client = new MQTTClient(this);

  client.connect(

    "mqtt://Siluetas:12345678@broker.shiftr.io", 

    "Pablo"

    );

}

 void captureEvent(Capture video) {
  video.read();
}

void draw() {
background(50);
  video.start(); //empieza el video 
  for (int i = 0; i < particles.length; i++) { //Se mueven las particulas
    particles[i].display(pixOp);
    particles[i].move();
  }
  if (sensors != null) {

    // Do something with the sensor values

  }

    

}

 

void keyPressed() {

  if (key == '1' || key == 'a') {

    client.publish("/pab", "1");

  } else if (key == '2' || key == 's') {

    client.publish("/pab", "2");

  }
  
  if (key == '3' || key == 'd') {

    client.publish("/pab", "3");

  } else if (key == '4' || key == 'f') {

    client.publish("/pab", "4");

  }
  
  else if (key == '5' || key == 'g') {

    client.publish("/pab", "5");

  }
  else if (key == '6' || key == 'h') {

    client.publish("/pab", "6");
  }
  else if (key == '7' || key == 'h') {

    client.publish("/pab", "7");
  }
  else if (key == '8' || key == 'j') {

    client.publish("/pab", "8");
  }
  else if (key == '9' || key == 'k') {

    client.publish("/pab", "9");
  }
  else if (key == '0' || key == 'l') {

    client.publish("/pab", "0");
  }
}

 

void clientConnected() {

  println("client connected");

 

  client.subscribe("/pab");

}

 

void messageReceived(String topic, byte[] payload) {

  //println("new message: " + topic + " - " + new String(payload));

  String temp = new String(payload);

  if (topic.equals("/pab") == true) {

    if (temp.equals("1")) {

      pixOp = 10;

    } else if (temp.equals("2")) {

      pixOp = 20;

    }
    else if (temp.equals("3")) {

      pixOp = 30;

    }
    else if (temp.equals("4")) {

      pixOp = 40;

    }
    else if (temp.equals("5")) {

      pixOp = 50;

    }
    else if (temp.equals("6")) {

      pixOp = 60;

    }
    else if (temp.equals("7")) {

      pixOp = 70;

    }
    else if (temp.equals("8")) {

      pixOp = 80;

    }
    else if (temp.equals("9")) {

      pixOp = 90;

    }
    else if (temp.equals("0")) {

      pixOp = 100;

    }

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

 

    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {

      print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");

    }
    int valSensor = sensors[0];
    if (valSensor == 109 && seg1 == false)
    {
      seg1 = true;
      seg2 = false;
      seg3 = false;
      seg4 = false;
      seg5 = false;
      seg6 = false;
      seg7 = false;
      seg8 = false;
      seg9 = false;
      seg0 = false;
      client.publish("/sam", "1");
      
    }
    else if (valSensor == 108 && seg2 == false)
    {
      client.publish("/sam", "2");
      seg1 = false;
      seg2 = true;
      seg3 = false;
      seg4 = false;
      seg5 = false;
      seg6 = false;
      seg7 = false;
      seg8 = false;
      seg9 = false;
      seg0 = false;
    }
    else if (valSensor == 107 && seg3 == false)
    {
      client.publish("/sam", "3");
      seg1 = false;
      seg2 = false;
      seg3 = true;
      seg4 = false;
      seg5 = false;
      seg6 = false;
      seg7 = false;
      seg8 = false;
      seg9 = false;
      seg0 = false;
    }
    else if (valSensor == 106 && seg4 == false)
    {
      client.publish("/sam", "4");
      seg1 = false;
      seg2 = false;
      seg3 = false;
      seg4 = true;
      seg5 = false;
      seg6 = false;
      seg7 = false;
      seg8 = false;
      seg9 = false;
      seg0 = false;
    }
    else if (valSensor == 105 && seg5 == false)
    {
      client.publish("/sam", "5");
      seg1 = false;
      seg2 = false;
      seg3 = false;
      seg4 = false;
      seg5 = true;
      seg6 = false;
      seg7 = false;
      seg8 = false;
      seg9 = false;
      seg0 = false;
    }
    else if (valSensor == 104 && seg6 == false)
    {
      client.publish("/sam", "6");
      seg1 = false;
      seg2 = false;
      seg3 = false;
      seg4 = false;
      seg5 = false;
      seg6 = true;
      seg7 = false;
      seg8 = false;
      seg9 = false;
      seg0 = false;
    }
    else if (valSensor == 103 && seg7 == false)
    {
      client.publish("/sam", "7");
      seg1 = false;
      seg2 = false;
      seg3 = false;
      seg4 = false;
      seg5 = false;
      seg6 = false;
      seg7 = true;
      seg8 = false;
      seg9 = false;
      seg0 = false;
    }
    else if (valSensor == 102 && seg8 == false)
    {
      client.publish("/sam", "8");
      seg1 = false;
      seg2 = false;
      seg3 = false;
      seg4 = false;
      seg5 = false;
      seg6 = false;
      seg7 = false;
      seg8 = true;
      seg9 = false;
      seg0 = false;
    }
    else if (valSensor == 101 && seg9 == false)
    {
      client.publish("/sam", "9");
      seg1 = false;
      seg2 = false;
      seg3 = false;
      seg4 = false;
      seg5 = false;
      seg6 = false;
      seg7 = false;
      seg8 = false;
      seg9 = true;
      seg0 = false;
    }
    else if (valSensor == 100 && seg0 == false)
    {
      client.publish("/sam", "0");
      seg1 = false;
      seg2 = false;
      seg3 = false;
      seg4 = false;
      seg5 = false;
      seg6 = false;
      seg7 = false;
      seg8 = false;
      seg9 = false;
      seg0 = true;
    }
 
    // add a linefeed after all the sensor values are printed:

    println();

  }
}

void serialEvent()
{
  /*
  while (myPort.available() == 1)
  {
    int boton = int(myPort.readChar());
    print(boton);
    if (boton == 1)
    {
      client.publish("/led", "ON");
    }
    if (boton == 0)
    {
      client.publish("/led", "OFF");
    }
  }
  */
}
