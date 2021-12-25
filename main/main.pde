import peasy.*;
import processing.video.*;

PeasyCam cam;
Icosphere dw;
Capture webcam;

Boolean doRotate = true;
int startSize = 0;
int start;
float inc;

void setup () {
	dw = new Icosphere(startSize);
	cam = new PeasyCam(this, 100);	

	// size(900, 900, P3D);
	fullScreen(P3D);
	
	colorMode(HSB);
	textureWrap(REPEAT);
	textureMode(NORMAL); 
	// frameRate(10);

	webcam = new Capture(this, Capture.list()[0]);
	webcam.start();

	// Debug: check for cameras
	// String[] cameras = Capture.list();
	// if (cameras.length == 0) {
	// 	println("There are no cameras available for capture.");
	// 	exit();
	// } else {
	// 	println("Available cameras:");
	// 	for (int i = 0; i < cameras.length; i++) {
	// 		println(cameras[i]);
	// }

	// Set the start time
	start=millis();
}

void draw () {
	background(0);
	getCameraFrame();

	// Run the Icosphere
	pushMatrix();
		
		// Rotate the Icosphere
		if(doRotate) inc += 0.002;
		rotate(inc);

		dw.run();
	popMatrix();

	// HUD
	cam.beginHUD();
	cam.endHUD();
}

/*
	Keyboard controls.
*/
void keyPressed() {
	// Increment Icosphere size up
	if (keyCode == UP) {
		startSize++;
		println(startSize);
		dw = new Icosphere(startSize);
	}

	// Increment Icosphere size down
	else if (keyCode == DOWN) {
		startSize = max(0, startSize-1);
		println(startSize);
		dw = new Icosphere(startSize);
	} 

	// Restart sim with same initial parameters
	else if (key == 'r') {
		dw = new Icosphere(startSize);
	} 

	// Toggle rotation and "inc"
	else if (key == 'k') {
		doRotate=!doRotate; 
	}
}

/*
	Get a frame from the webcam if available.
*/
void getCameraFrame(){
  if (webcam.available() == true) {
      webcam.read();
  }  
}