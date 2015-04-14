import http.requests.*;

import processing.serial.*;



Serial myPort;  // Create object from Serial class
String val = "0";     // Data received from the serial port
ArrayList data = new ArrayList();
String oldVal;
String newVal;
int i = 0;
PrintWriter output;

String dateVal;
       Timer timer;



void setup()
{
// I know that the first port in the serial list on my mac
// is Serial.list()[0].
// On Windows machines, this generally opens COM1.
// Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 
  output = createWriter("positions.csv"); 
      output.print("\"time\"");
      output.print(",");
      output.print("\"value\"");
      output.println();
      
  timer = new Timer(100);
       timer.start();      
}

void draw()
{

  if (timer.isFinished())  {
      if(val != null){
      println(val);
            if(val != null){
              output.print(hour());
              output.print(" uur ");
              output.print(minute());
              output.print(",");
              output.print(val);
              
              dateVal = "time-" + hour() + ":" + minute();
              // send to server
              
              PostRequest post = new PostRequest("http://YOURHOSTNAME.com/arduino");
              post.addData("0", dateVal);
              post.addData("1", val);
              post.send();
              println("Reponse Content: " + post.getContent());
              println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));              
            }
      }
      timer.start();
  }


}

void serialEvent (Serial myPort) {
    if ( myPort.available() > 0) 
    {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val

    } 
}

void keyPressed() {
  output.close();  // Finishes the file
  exit();  // Stops the program
}

class Timer  {
  int savedTime;  //  When Timer started
  int totalTime;    //  How long Timer should last
  
  Timer (int tempTotalTime)  {
    totalTime = tempTotalTime;
  }
  
  //  Starting the timer
  void start ()  {
    savedTime = millis();  //  When the Timer starts it stores the current time in milliseconds
  }
  
  boolean isFinished ()  {
    //  Check how much time has passed
    int passedTime = millis() - savedTime;
    if (passedTime > totalTime)  {
      return true;
    }  else  {
      return false;
    }
  }
  
}

