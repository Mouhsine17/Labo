class Player extends GraphicObject {

  float diameter = 50;
  float speed = 5;

  float mass = 220;

  float G = 12;

  Player(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void update(int deltaTime) {

    velocity.x = 0;

    if (keyPressed && (key == 'a' || key == 'A')) {
      velocity.x = -speed;
    }

    if (keyPressed && (key == 'd' || key == 'D')) {
      velocity.x = speed;
    }

    location.add(velocity);

    location.x = constrain(
      location.x,
      diameter / 2,
      width - diameter / 2
    );
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    fill(255, 180, 50);

    ellipse(
      location.x,
      location.y,
      diameter,
      diameter
    );
  }

  PVector attract(Particle particle) {

    PVector force = PVector.sub(location, particle.location);

    float distance = force.mag();

    distance = constrain(distance, 20, 260);

    float magnitude =
      (G * mass * particle.mass)
      /
      (distance * distance);

    force.setMag(magnitude);

    return force;
  }
}
