const int ledPin = 9;    // LED connected to digital pin 9
const int buttonPin = 8;     // the number of the pushbutton pin
int buttonState = 0;
int previousState = 0;
int Selection = -1;
int sensorPin = A5;
int sensorValue = 0;  // variable to store the value coming from the sensor
float fadeValue = 0;
int fadeDirection = -1; 


void setup() {
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  // fade in from min to max in increments of 5 points:
  buttonState = digitalRead(buttonPin);
    if (buttonState == LOW and previousState != LOW){
      Selection = Selection * -1;
    }
  if (Selection == 1){
    sensorValue = analogRead(sensorPin)/4;
    analogWrite(ledPin, sensorValue);
  }
  else {
    //multiplying by a constastant rather that adding a constant makes more even fade. The led is bright too often otherwize.
    if (fadeDirection == 1){
      fadeValue *= 1.05;
    }else{
      fadeValue *= (1/1.05);
    }
    analogWrite(ledPin, fadeValue);
    if (fadeValue >= 250){
      fadeValue = 249;
      int temp = fadeDirection * -1;
      fadeDirection = temp;
    }
    if (fadeValue <= 1){
      fadeValue = 2;
      int temp = fadeDirection * -1;
      fadeDirection = temp;
    }
  }
  previousState = buttonState;
  delay(10);
}


