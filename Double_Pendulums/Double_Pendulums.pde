/*
*Alex Watson
*Double Pendulum
*
*/

float g = 1; //Gravity -> breaks if set to real value
Point p1, p2;
float cx, cy;
float px2 = -1;
float py2 = -1;
PGraphics canvas;

void setup(){
  size(900, 600);
  cx = width/2;
  cy = 200;
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  p1 = new Point(200, 20);
  p2 = new Point(200, 20);
  p1.theta = PI/2;
  p2.theta = PI/2;
}

void draw(){
  background(255);
  imageMode(CORNER);
  image(canvas, 0, 0, width, height);
  
  //calculate the acceleration of both points
  float num1 = -g * (2 * p1.m + p2.m) * sin(p1.theta);
  float num2 = -p2.m * g * sin(p1.theta-2*p2.theta);
  float num3 = -2*sin(p1.theta-p2.theta)*p2.m;
  float num4 = p2.vx * p2.vx * p2.r + p1.vx * p1.vx * p1.r * cos(p1.theta-p2.theta);
  float den = p1.r * (2*p1.m+p2.m-p2.m*cos(2*p1.theta-2*p2.theta));
  float a1_a = (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(p1.theta-p2.theta);
  num2 = (p1.vx * p1.vx * p1.r * (p1.m+p2.m));
  num3 = g * (p1.m + p2.m) * cos(p1.theta);
  num4 = p2.vx * p2.vx * p2.r * p2.m * cos(p1.theta-p2.theta);
  den = p2.r * (2*p1.m+p2.m-p2.m*cos(2*p1.theta-2*p2.theta));
  float a2_a = (num1*(num2+num3+num4)) / den;
  
  translate(cx, cy);
  stroke(0);
  strokeWeight(2);
  
  p1.x = p1.r * sin(p1.theta);
  p1.y = p1.r * cos(p1.theta);
  
  p2.x = p1.x + p2.r * sin(p2.theta);
  p2.y = p1.y + p2.r * cos(p2.theta);
  
  line(0, 0, p1.x, p1.y);
  fill(0);
  ellipse(p1.x, p1.y, p1.m, p1.m);
  
  line(p1.x, p1.y, p2.x, p2.y);
  fill(0);
  ellipse(p2.x, p2.y, p2.m, p2.m);
    
  p1.vx += a1_a;
  p2.vx += a2_a;
  p1.theta += p1.vx;
  p2.theta += p2.vx;
  
  color c = color((p2.x + p2.y)%257, (p2.x*5)%257, (p2.y*5)%257);
  
  canvas.beginDraw();
  //canvas.background(0, 1);
  canvas.translate(cx, cy);
  canvas.stroke(c);
  if (frameCount > 1) {
    canvas.line(px2, py2, p2.x, p2.y);
  }
  canvas.endDraw();
  
  px2 = p2.x;
  py2 = p2.y;
}
