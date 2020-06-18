class Agent {

  PVector location;
  float dir = 0;
  int status = 0; 
  static final int SUSCEPTIBLE = 0;
  static final int INFECTED = 1;
  static final int RECOVERED = 2;
  int recovery = 0;

  Agent() {
    location = new PVector(random(width), random(height));
    if (random(100)<5) {
      status = INFECTED;
      recovery = -120;
    }
    dir = random(2*PI);
  }

  void setLocation(PVector loc) {
    location = loc;
  }

  void setStatus(int i) {
    status = i;
  }
  
  int getStatus() {
    return status;
  }

  void update() {
    if (location.x>width) location.x -= width;
    if (location.x<0) location.x += width;
    if (location.y<0) location.y += height;
    if (location.y>height) location.y -= height;
    location.x+=sin(dir);
    location.y+=cos(dir);
    recovery++; // take a step toward recovery
    if (recovery > 0 && status == INFECTED && random(100)>95) status = RECOVERED;
    for (Agent a : agents) {
      if (distanceTo(a) < 10) {
        // draw susceptible connection due to proximity
        stroke(255);
        line(location.x, location.y, a.location.x, a.location.y);
        // see if transfer disease
        if ((status == SUSCEPTIBLE || status == RECOVERED) && a.status == INFECTED) {
          if (random(100) < 2) {
            recovery = -120;
            status = INFECTED;
          }
        }
      }
    }
  }

  void draw() {
    noStroke();
    if (status == SUSCEPTIBLE) fill(0, 255, 0, 128);
    else if (status == INFECTED) fill(255, 0, 0, 128);
    else if (status == RECOVERED) fill(255, 0, 255);
    ellipse(location.x, location.y, 10, 10);
  }

  float distanceTo(Agent a) {
    return (location.dist(a.location));
  }
}
