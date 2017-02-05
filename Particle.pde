class Particle {
  PVector pos,vel,acc,prevPos;
  float maxSpeed = 2;

  Particle(){
    pos = new PVector(random(width-1),random(height-1));
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    prevPos = pos.copy();
  }

  void update() {
    prevPos.x = pos.x;
    prevPos.y = pos.y;

    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);


    if (pos.x >= width) pos.x = prevPos.x = 0;
    if (pos.x < 0) pos.x = prevPos.x = width-1;
    if (pos.y >= height) pos.y = prevPos.y = 0;
    if (pos.y < 0) pos.y = prevPos.y = height-1;

    acc.mult(0);
  }

  void follow(PVector[] flowfield) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = x + y * cols;

    PVector force = flowfield[index];
    applyForce(force);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void show() {
    stroke(255,5);
    strokeWeight(1);
    line(pos.x,pos.y,prevPos.x,prevPos.y);
  }
}
