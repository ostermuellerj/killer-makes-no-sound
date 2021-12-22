import processing.video.*;
/**
 * ShapeMask
 * draw a Mask example with createShape
 * 2019-08 Processing 3.4
 * see https://discourse.processing.org/t/placing-a-texture-on-a-pshape/13561
 **/
PImage photo;
PImage img;
PShape tar;
PGraphics maskImage;
Capture webcam;

void setup() {
  size(800, 800, P3D);
  photo = loadImage("yes.png");
  
  webcam = new Capture(this, Capture.list()[0]);
  // webcam.start();
  getCameraFrame();

  img = createImage(webcam.width, webcam.height, RGB);
  img = webcam;
  makeShape();
  // tar.setTexture(webcam);
  tar.setTexture(photo);


  doMask();
}

void draw() {
  // getCameraFrame();
  // img = webcam;
  // tar.setTexture(img);
  shape(tar, 0, 0);
  // image(img,0,0);

  // Generate mask:
  // doMask();

  // Debug:
  // println(photo.width, photo.height);

  // Mask from shape:
  // image(maskImage,0,0);

  // Masked image:
  // image(webcam, 0, 0);
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
  } catch (Exception e) {}
  

}

void makeShape(){
  tar = createShape();
  tar.setStroke(false);
  tar.beginShape();
  // tar.texture(img);
  tar.texture(photo);
  //loops 359 times to enable rotation in 1° increments
  // PVector rad = new PVector(200,0);
  // for(int i = 1; i<360; i++)
  // {
  //   //Creates a vertex at circ.x and circ.y
  //   rad.setMag(random(190,210));
  //   tar.vertex(rad.x, rad.y);
  //   //Rotates circ by 1° converted to radians
  //   rad.rotate(PI/180);
  // }
  int size = 800;
  tar.vertex(0,0,0,0);
  tar.vertex(size,0,1,0);
  tar.vertex(size,size,1,1);
  tar.vertex(0,size,0,1);
  //Ends the shape
  tar.endShape(CLOSE);
}