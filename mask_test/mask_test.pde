import peasy.*;
import processing.video.*;

PImage photo;
PImage img;
PShape tar;
PGraphics maskImage;
Capture webcam;
PeasyCam cam;

Boolean imgExists = false;

void setup() {
  size(1200, 800, P3D);

  photo = loadImage("yes.png");
  cam = new PeasyCam(this, 100);  
  
  textureWrap(REPEAT);
  textureMode(NORMAL); 
  noStroke();

  webcam = new Capture(this, Capture.list()[0]);
  webcam.start();
  
  // Make holder PImage to feed capture into
  img = createImage(webcam.width, webcam.height, RGB);
  // println(webcam.width, webcam.height);

  makeShape();
}

void draw() {
  background(255);
  getCameraFrame();
  
  // If the camera has loaded, 
  if(webcam.width>1 && !imgExists) img = createImage(webcam.width, webcam.height, RGB);
  img = webcam.copy();
  try {    
    // Debug with static photo
    // tar.setTexture(photo);  
    tar.setTexture(img);  
  } catch (Exception e) {}
  
  // Display PShape
  // shape(tar, -width/2, -height/2);
  for(float i=-10;i<10;i++) {
    // shape(tar, 1100*i, 0);
    pushMatrix();
      // rotate((i/20)*TWO_PI);
      rotateX((i/20)*TWO_PI);
      shape(tar, 0, 0);
    popMatrix();
  }
}

// Get a frame from the webcam if available
void getCameraFrame(){
  if (webcam.available() == true) {
      webcam.read();
  }  
}

// Define the PShape
void makeShape(){
  tar = createShape();
  tar.beginShape();
    float size = 1000;
    float uv_size = 1;
    // tar.vertex(0,0,0,0);
    // tar.vertex(size,0,uv_size,0);
    tar.vertex(size/2,0,uv_size/2,0);
    tar.vertex(size,size,uv_size,uv_size);
    tar.vertex(0,size,0,uv_size);
  tar.endShape(CLOSE);
}