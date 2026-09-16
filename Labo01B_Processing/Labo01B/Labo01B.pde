int currentTime;
int previousTime;
int deltaTime;

Player player;
ParticleSystem particleSystem;

boolean variationPair = true;

void setup() {
  size(800, 600);

  currentTime = millis();
  previousTime = millis();

  player = new Player(width / 2, height - 15);

  particleSystem = new ParticleSystem(new PVector(width / 2, height * 0.25),5 , 1000, variationPair );

  particleSystem.setDistance(320/2, 360/2);
  //120 - 160
}

void draw() {
  timeManagement();
  update(deltaTime);
  display();
}

void update(int delta) {
  player.update(delta);
  particleSystem.update(delta, player);
}

void display() {
  background(255);

  particleSystem.display();
  player.display();
}

void timeManagement() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
}
