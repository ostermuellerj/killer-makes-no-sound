import processing.video.*;
/**
 * ShapeMask
 * draw a Mask example with createShape
 * 2019-08 Processing 3.4
 * see https://discourse.processing.org/t/placing-a-texture-on-a-pshape/13561
 **/
PImage photo;
PShape tar;
PGraphics maskImage;
Capture webcam;

void setup() {
  size(512, 512);
  // photo = loadImage("https://forum.processing.org/processing-org.jpg");
  
  webcam = new Capture(this, Capture.list()[0]);
  webcam.start();
  getCameraFrame();
  // waitForCameraFrame();

  makeShape();

  doMask();
  // noLoop();
}

void draw() {
  getCameraFrame();
  doMask();
  // println(photo.width, photo.height);
  // image(webcam, width/2, height/2);

  //shape
  //shape(tar, width/2, height/2);

  //mask from shape
  // image(maskImage,0,0);

  //masked image
  image(webcam, 0, 0);
  // saveFrame("ShapeMask.png");
}

void getCameraFrame(){
  if (webcam.available() == true) {
      webcam.read();
  }  
}

void waitForCameraFrame(){
  while(true){
    if (webcam.available() == true) {
      webcam.read();
      return;
    }  
  }
}

void doMask(){
  // create mask
  maskImage = createGraphics(1280,720);
  // maskImage = createGraphics(photo.width,photo.height);
  maskImage.beginDraw();
  maskImage.shape(tar, width/2, height/2);
  maskImage.endDraw();


  println(maskImage.width, maskImage.height);
  println(webcam.width, webcam.height);

  //apply mask
  try {
  webcam.mask(maskImage);  
  } catch (Exception e) {
  }
  

}

void makeShape(){
  tar = createShape();
  tar.setStroke(false);
  tar.beginShape();
  //loops 359 times to enable rotation in 1° increments
  PVector rad = new PVector(200,0);
  for(int i = 1; i<360; i++)
  {
    //Creates a vertex at circ.x and circ.y
    rad.setMag(random(190,210));
    tar.vertex(rad.x, rad.y);
    //Rotates circ by 1° converted to radians
    rad.rotate(PI/180);
  }
  //Ends the shape
  tar.endShape(CLOSE);
}