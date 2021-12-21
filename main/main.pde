import peasy.*;
import processing.video.*;

PeasyCam cam;
Icosphere dw;

Capture webcam;

float inc;
Boolean doRotate = true;

float sw=15;

int startSize = 0;

int start;
//debug Space.display()
int o = 10;

void setup () {

	dw = new Icosphere(startSize);
	cam = new PeasyCam(this, 100);	

	size(900, 900, P3D);
	// fullScreen(P3D);
	colorMode(HSB);
	// frameRate(10);

	webcam = new Capture(this, Capture.list()[0]);
	webcam.start();

	// Check for cameras: (DEBUG)
	// String[] cameras = Capture.list();
	// if (cameras.length == 0) {
	// 	println("There are no cameras available for capture.");
	// 	exit();
	// } else {
	// 	println("Available cameras:");
	// 	for (int i = 0; i < cameras.length; i++) {
	// 		println(cameras[i]);
	// }
	// 	// The camera can be initialized directly using an 
	// 	// element from the array returned by list():
	// 	webcam = new Capture(this, cameras[0]);
	// 	webcam.start();     
	// }

	start=millis();
}

void draw () {
	background(0);
	if (webcam.available() == true) {
    	webcam.read();
  	}
	image(webcam, width/2, height/2);

	// run the Icosphere
	pushMatrix();
		// slight constant rotation
		if(doRotate) {
			inc += 0.002;
			rotate(inc);
		}
		dw.run();
	popMatrix();

	// HUD
	cam.beginHUD();
	cam.endHUD();
}

void keyPressed() {
	// increment Icosphere size up
	if (keyCode == UP) {
		startSize++;
		println(startSize);
		dw = new Icosphere(startSize);

		// sw-=5;
		// stroke(sw/30*255%255, 180, 255, 150);
		// strokeWeight(sw);
	}
	// increment Icosphere size down
	else if (keyCode == DOWN) {
		startSize = max(0, startSize-1);
		println(startSize);
		dw = new Icosphere(startSize);

		// sw+=5;
		// stroke(sw/30*255%255, 180, 255, 150);
		// strokeWeight(sw);
	} 
	// restart sim with same initial parameters
	else if (key == 'r') {
		dw = new Icosphere(startSize);
	}
	else if (key == 'k') {
		doRotate=true; 
	}
}