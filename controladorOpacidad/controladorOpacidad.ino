int Value1, Value2, Value3, Value4;

int val;
int TRIG_PIN = 13;
int ECHO_PIN = 12;


void setup() {


  Serial.begin(9600);
  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

}



void loop() {
  long duration, distanceCm, distanceIn;

  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  duration = pulseIn(ECHO_PIN, HIGH);

  // convert the time into a distance
  distanceCm = duration / 29.1 / 2 ;
  distanceIn = duration / 74 / 2;

  Value1 = map(distanceCm, 90, 130, 100, 111); // read  in analog input 0


  Serial.println(Value1, DEC);  // print  1



  if (Serial.available())  // if data is available to read

  {

    val = Serial.read(); // read it and store it in 'val'

  }

  delay(1000);   // wait 200ms for next reading

}
