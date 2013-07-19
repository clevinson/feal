Atom[] world = new Atom[500];

void setup(){
  background(255,255,250);

  size(document.width*2,document.height*2, JAVA2D);
  smooth();

  for(int i=0; i<world.length; i++){
    world[i] = new Atom((int)random(width), (int)random(height));
  }
}

void draw(){
  for(int i=0; i<world.length; i++){
    Atom atom = world[i];
    atom.display();
    atom.tick(1);
    if(mousePressed){
      //atom.scale_gravity_mag(2); //<>//
    }else{
     // atom.scale_gravity_mag(0.5);
    }
  }
}
/*
void mousePressed(){
  for(int i=0; i<world.length; i++){
    world[i].gravitate(mouseX,mouseY);
  }
}
*/
class Atom {
  
  float xpos, ypos;
  PVector perlin_vel;
  PVector gravity_vel;
  color myColor;

  Atom(float x,float y){
    this.xpos = x;
    this.ypos = y;
    set_velocity();
    colorMode(HSB, 100);
    float hue = 100*y/width;
    myColor = color(55 + hue/20, 100, 20);
    gravity_vel = new PVector(0.001,0.001);
  }
  
  float x(){
    return xpos;
  }
  
  float y(){
    return ypos;
  }
  
  void tick(float t){
    xpos = xpos + perlin_vel.x*t + gravity_vel.x*t;
    ypos = ypos + perlin_vel.y*t + gravity_vel.y*t;
    
    set_velocity();
  }
  
  void set_velocity(){
    float angle = noise(xpos/noiseScale,ypos/noiseScale)*TWO_PI*noiseSpin;
    perlin_vel = new PVector(cos(angle), sin(angle));
  }
  
  void display(){
    pushStyle();
    myStyle();
    point(xpos, ypos);
    popStyle();
  }
  
  void myStyle(){
    strokeWeight(1);
    stroke(myColor, 20);
  }
  
  void gravitate(float x,float y){
    float angle = atan2(y - ypos, x - xpos);
    gravity_vel = new PVector(cos(angle), sin(angle));
  }
  
  void scale_gravity_mag(float scaler){
    gravity_vel.mult(scaler);
  }

}
