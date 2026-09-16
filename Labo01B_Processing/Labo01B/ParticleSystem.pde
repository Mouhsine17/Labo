class ParticleSystem {

  PVector position;

  ArrayList<Particle> particles;

  int particleRate;
  int lastParticleTime;
  int maxParticles;

  float activationDistance;
  float deactivationDistance;

  boolean variationPair;

  ParticleSystem(
    PVector position,
    int particleRate,
    int maxParticles,
    boolean pair
  ) {

    this.position = position.copy();
    this.particleRate = particleRate;
    this.maxParticles = maxParticles;
    this.variationPair = pair;

    lastParticleTime = 0;

    particles = new ArrayList<Particle>();

    activationDistance = 150;
    deactivationDistance = 190;
  }

  void setDistance(
    float activation,
    float deactivation
  ) {

    activationDistance = max(0, activation);

    deactivationDistance = max(
      activationDistance,
      deactivation
    );
  }

  void update(int deltaTime, Player player) {

    if (
      millis() - lastParticleTime > particleRate
      &&
      particles.size() < maxParticles
    ) {

      lastParticleTime = millis();

      particles.add(
        new Particle(
          position,
          variationPair
        )
      );
    }

    for (
      int i = particles.size() - 1;
      i >= 0;
      i--
    ) {

      Particle p = particles.get(i);

      PVector gravity = new PVector(
        0,
        0.015 * p.mass
      );

      p.applyForce(gravity);

      float distance = PVector.dist(
        p.location,
        player.location
      );

      if (
        !p.affected
        &&
        distance <= activationDistance
      ) {
        p.setAffected(true);
      }

      if (
        p.affected
        &&
        distance >= deactivationDistance
      ) {
        p.setAffected(false);
      }

      if (p.affected) {
        PVector attraction = player.attract(p);
        p.applyForce(attraction);
      }

      p.update(deltaTime);

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void display() {

    noStroke();
    fill(180);

    ellipse(
      position.x,
      position.y,
      20,
      20
    );

    for (Particle p : particles) {
      p.display();
    }
  }
}
