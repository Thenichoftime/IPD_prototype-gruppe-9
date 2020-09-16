/*Various variables.
MAX is number of pages
Not completely sure of GAP, other than
It's for coordinates, for the buttons
*/

int MAX=4, GAP=1;

import processing.video.*;
Capture cam;


//Image variables
PImage forside;
PImage QRcode;
PImage side1;
PImage side2;
PImage side4;


//Page variable and center x and y coordinate
int page;
float cx,cy;

//Back and next button variables
Button back, next;

void setup(){
  size(1189,841);
  
  /*Connecting images to image files
  Make sure the image files are in the same folder
  as the .pde file*/
  forside=loadImage("IPD_forside.png");
  QRcode=loadImage("QRcode_medialogi.png");
  side1=loadImage("Hvad_er_medialogi.png");
  side2=loadImage("Job_og_karriere.png");
  side4=loadImage("Hjemmeside.JPG");
  
  cam=new Capture(this,640,480,30);
  cam.start();
  
  imageMode(CENTER);
  textAlign(CENTER,CENTER);
  
  stroke(0);
  strokeWeight(1.5);
  
  //Sets center coordinates to center of window
  cx=width/2;
  cy=height/2;
  
  //Defining how the buttons look and position
  back=new Button("<-",GAP,height-Button.H-GAP);
  next=new Button("->",width-Button.W-GAP,height-Button.H-GAP);
}

void draw(){
  background(0300);
  
  //Whether or not the buttons are shown + textsize
  textSize(Button.TXTSZ);
  if (page>0) back.display();
  if (page<MAX) next.display();
  
  //Not sure of function, but IT IS CRUCIAL!
  method("page"+page);
}

//If statement to determine if the mouse is on the button
void mousePressed(){
  if(page>0 && back.isHovering) --page;
  else if(page<MAX && next.isHovering) ++page;
  
  //Makes the window only update, when nescessary
  redraw();
}

void mouseReleased(){
  if(page>0 && pmouseX<mouseX) --page;
  else if(page<MAX && pmouseX>mouseX) ++page;
}

//Highlights buttons, when mouse is over them
void mouseMoved(){
  back.isInside();
  next.isInside();
  
  redraw();
}

//page0-4 determines, what is shown on those pages
void page0(){
  forside.resize(width,height);
  image(forside,cx,cy-Button.H);
  
}

void page1(){
  side1.resize(width,height);
  image(side1,cx,cy-Button.H);
}

void page2(){
  if(cam.available()){
    cam.read();
  }
  image(cam,cx,cy-200);
  side2.resize(width,height);
  image(side2,cx,cy-Button.H);
}

void page3(){
   textSize(0100);
  fill(Button.TXTC);
  text("Studieliv",cx,cy);
}

void page4(){
  side4.resize(width,height);
  image(side4,cx,cy-Button.H);
   textSize(0100);
  fill(Button.TXTC);
  text("Hvis du vil vide mere...",cx,100);
  image(QRcode,cx,cy);
}

//Defining Button class
class Button {
  static final int W = 60, H = 40, TXTSZ = 020;
  static final color BTNC = #00A0A0, HOVC = #00FFFF, TXTC = 0;
 
  final String label;
  final int x, y, xW, yH;
 
  boolean isHovering;
 
  Button(String txt, int xx, int yy) {
    label = txt;
 
    x = xx;
    y = yy;
 
    xW = xx + W;
    yH = yy + H;
  }
 
  void display() {
    fill(isHovering? HOVC : BTNC);
    rect(x, y, W, H);
 
    fill(TXTC);
    text(label, x + W/2, y + H/2);
  }
 
  boolean isInside() {
    return isHovering = mouseX > x & mouseX < xW & mouseY > y & mouseY < yH;
  }
}
