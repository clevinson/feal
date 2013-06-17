Atom thisAtom;
Atom[] world;
int downMouseX, downMouseY;

void setup(){

    if( jQuery(document).height() > jQuery(window).height() ){
      setupHeight = jQuery(document).height();
    }else{
      setupHeight = jQuery(window).height();
      jQuery('canvas').width(jQuery(window).width());
      jQuery('canvas').height(setupHeight);
      size(jQuery(window).width(), setupHeight);
    }

  frameRate(40);
  background(0);
  ellipseMode(RADIUS);
}

void draw(){
  float speed = dist(mouseX, mouseY, pmouseX, pmouseY)/5;
  fade(2);
  if(mousePressed){
    fade(speed);
    float red = map(mouseX, 0, width, 0, 255);
    float blue = map(mouseY, 0, height, 0, 255);
    color col = color(red, 80, blue, 100);
    int radius = (int)dist(downMouseX, downMouseY, mouseX, mouseY);

    thisAtom.update(radius, col);
    thisAtom.display();
  }
}

void mousePressed(){
  downMouseX = mouseX;
  downMouseY = mouseY;
  thisAtom = new Atom(mouseX, mouseY);
}

void fade(float alpha){
  noStroke();
  fill(0, alpha);
  rect(0, 0, width, height);
}

class Atom {
  float xpos, ypos;
  int radius, prevRadius, maxRadius = 0;
  color strokeColor, lastColor;

  Atom(float x, float y) {
    xpos = x;
    ypos = y;
  }

  void update(int r, int col) {
    prevRadius = radius;
    radius = r;
    lastColor = strokeColor;
    strokeColor = col;
    growing = (radius >= prevRadius);
  }

  void display(){
    noFill();
    drawEdgeGradient();
  }

  void drawEdgeGradient(){
      int edge = min(radius*0.2, 40);
      for(int r = radius - edge; r < radius + edge; r++){
        distance = abs(r - radius);
        float thisAlpha = map(distance, 0, edge, alpha(strokeColor), 0);
        stroke(strokeColor,thisAlpha);
        ellipse(xpos, ypos, r, r);
      }
  }
}

color colorMap(int i, int x1, int x2, color col1, color col2){
  float red1 = red(col1);
  float red2 = red(col2);
  float green1 = green(col1);
  float green2 = green(col2);
  float blue1 = blue(col1);
  float blue2 = blue(col2);
  float alpha1 = alpha(col1);
  float alpha2 = alpha(col2);

  float thisRed = map(i, x1, x2, red1, red2);
  float thisGreen = map(i, x1, x2, green1, green2);
  float thisBlue = map(i, x1, x2, blue1, blue2);
  float thisAlpha = map(i, x1, x2, alpha1, alpha2);

  return color(thisRed, thisGreen, thisBlue, thisAlpha);
}
