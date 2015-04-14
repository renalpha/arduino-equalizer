// constants won't change. They're used here to
// set pin numbers:
const int greenPin1 = 13;
const int greenPin2 = 12;
const int orangePin1 = 11;
const int orangePin2 = 10;
const int redPin1 = 9;
const int redPin2 = 8;

const int soundModule = 2;
const int micPin = 0;

int soundSensorRead = 0;

void setup() {
  
  pinMode(soundModule, OUTPUT);
  
  // initialize the LED pin as an output:
  pinMode(greenPin1, OUTPUT);
  pinMode(greenPin2, OUTPUT);

  pinMode(orangePin1, OUTPUT);
  pinMode(orangePin2, OUTPUT);

  pinMode(redPin1, OUTPUT);
  pinMode(redPin2, OUTPUT);
  Serial.begin(9600);
  
  
}

void loop() {
  
  soundSensorRead = analogRead(micPin);    // read the input pin
  
  if(soundSensorRead > 650){
  // display led green  
  digitalWrite(greenPin1, HIGH);
  }
  
  if(soundSensorRead < 550){
  // display led green  
  digitalWrite(greenPin2, HIGH);
  }else{
  digitalWrite(greenPin2, LOW);
  }
  
  if(soundSensorRead < 450){
  digitalWrite(orangePin1, HIGH); 
  }else{
  digitalWrite(orangePin1, LOW); 
  }  
  
  if(soundSensorRead < 350){
  digitalWrite(orangePin2, HIGH); 
  }else{
  digitalWrite(orangePin2, LOW); 
  }    
  
  if(soundSensorRead < 250){
  digitalWrite(redPin1, HIGH); 
  }else{
  digitalWrite(redPin1, LOW); 
  }      
  
  if(soundSensorRead < 150){
  digitalWrite(redPin2, HIGH); 
  }else{
  digitalWrite(redPin2, LOW); 
  }      
    
  
 

  Serial.println(soundSensorRead);             // debug value

}
