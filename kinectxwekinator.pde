//import ocsp5 library
import oscP5.*;
OscP5 oscP5;
int s = 10;        //points of this enclosed shape, star
int radian = 300;  //the radians of this enclosed shape, star
void setup() {
  size(900, 900, P2D);
   //this is the output of wekinator and the port is 12000.
  oscP5 = new OscP5(this, 12000);
   background(0);
}
void draw() {
  noStroke();
  background(0);
  //draw the star by using radian and s change upon the inputthat receives from wekinator
  pushMatrix();
  translate(width/2, height/2); //set the new origin at themiddle of window
  rotate(frameCount / 200.0);
  star(0,0, radian, 20, s);
  popMatrix();
}
//recieve the value from wekinator and translate to the drawing
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    //map the first value from wekinator which is 0 to 1 to the
     //point of the star.
    s = (int) map(theOscMessage.get(0).floatValue(), 0, 1, 3,
     20);
    //map the second value from wekinator which is 0 to 1 to how
     big of the star.
    radian = (int) map(theOscMessage.get(1).floatValue(), 0, 1,
     10, 400);
} }
//star drawing function
void star(float x, float y, float radius1, float radius2, int
     npoints) {
  //get the angle from each shape that created by number of points(s)
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  //create a vertex coordinates at every......degree
  for (float a = 0; a < TWO_PI; a += angle) {
    //set the position of points of outer boundary of shape
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    //the vertex coordinates for points of outer shape
    vertex(sx, sy);
    //set the position of point of inner boundary of shape
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    //the vertex coordinates for points of inner shape
    vertex(sx, sy);
}
  endShape(CLOSE);
}