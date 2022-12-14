/**
 * Camera Robot
 *
 * This program initializes a webcam connected to a PC. 
 * If a "P" is pressed it will then take a picture with 
 * the webcam and store it locally in the sketch folder.
 * 
 * Based on Cookie Monster by David Cuartielles
 * (c) 2013-2016 Arduino LLC.
 */ 
 
import processing.video.*;

Capture cam;

void setup() {
  size(640, 480, P2D);

  /* MS HALE!!!!! The number in the function below is very important, as it selects what camera the program uses. 
  Chances are, when you plug the camera in to your computer, if you already have a webcam (including built in) installed, it will be the second one on your computer.
  If that is the case, change it to 1. 
  If not, the program should work first try.
  */
  initializeCamera(0);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  
  String timeStamp=createTimeStamp();
  
  text(timeStamp, 10, height-10);


  
  // for the keyboard detection to work, you need to have
  // clicked on the application window first (aka focus)
  if(keyPressed) {
    if (key == 'p' || key == 'P') {
      captureImage(timeStamp);
    }
  }

}




void initializeCamera(int camNum){
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println("["+i+"] "+cameras[i]);
    }
    
    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[camNum]);
    cam.start();     
  }   

}

String createTimeStamp(){
  String timeStamp = String.format("%02d", hour());
  timeStamp += ":" + String.format("%02d", minute());
  timeStamp += ":" + String.format("%02d", second());
  timeStamp += " " + year();
  timeStamp += "/" + String.format("%02d", month());
  timeStamp += "/" + String.format("%02d", day());
  
  return timeStamp;
}

void captureImage(String timeStamp){
      saveFrame("pic-######.png");
      println("capturing Frame at: " + timeStamp);
}
