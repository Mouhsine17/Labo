class Particle extends GraphicObject {

  float diameter = 12;
  float mass;
  float lifespan;

  boolean affected = false;

  boolean variationPair;

  Particle(PVector startPosition, boolean pair) {

    location = startPosition.copy();

    variationPair = pair;

    mass = random(0.8, 1.5);

    velocity = new PVector(
      random(-1.5, 1.5),
      random(-1, 1)
    );

    acceleration = new PVector(0, 0);

    lifespan = 255;
  }

  void applyForce(PVector force) {

    PVector f = PVector.div(force, mass);

    acceleration.add(f);
  }

  void update(int deltaTime) {

    velocity.add(acceleration);

    velocity.limit(200);

    location.add(velocity);

    lifespan -= 0.5;

    acceleration.mult(0);
  }

  void display() {

    stroke(255, lifespan);


      if (affected) {
        fill(0, 255, 0, lifespan);
      } else {
        fill(0, 120, 255, lifespan);
      }

    ellipse(
      location.x,
      location.y,
      diameter,
      diameter
    );
  }

  boolean isDead() {
    return lifespan <= 0;
  }

  void setAffected(boolean value) {
    affected = value;
  }
}
