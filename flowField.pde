float scl = 50;
float inc = 0.2;
int cols, rows;
float zoff = 0;
Particle[] particles;
PVector[] flowfield;

void setup() {
  size(1600,900, P2D); //<>//

  cols = floor(width/scl);
  rows = floor(height/scl);

  particles = new Particle[10000];
  for(int i = 0; i<particles.length; i++) {
    particles[i] = new Particle();
  }

  flowfield = new PVector[cols * rows];
  background(0); //<>//
}

void draw() {
  float yoff = 0;
  for(int y = 0; y < rows; y++){
    float xoff = 0;
    for(int x = 0; x < cols; x++){
      int index = x + y * cols;
      float a = noise(xoff,yoff, zoff) * TWO_PI * 4;
      PVector v = PVector.fromAngle(a);
    //   pushMatrix();
    //   stroke(255,50);
    //   strokeWeight(1);
    //   translate(x*scl,y*scl);
    //   line(0,0,v.x*scl/2,v.y*scl/2);
      v.setMag(0.2);
      flowfield[index] = v;
      //
    //   popMatrix();

      xoff+= inc;
    }
    yoff += inc;

  }
  zoff += 0.005;
  for(Particle p : particles ) {
    p.follow(flowfield);
    p.update();
    p.show();
  }
  println(frameRate);
}
