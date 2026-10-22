abstract class GraphicObject {

  PVector location;
  PVector velocity;
  PVector acceleration;

  color fillColor = color(200);
  color strokeColor = color(255);
  float strokeWeightValue = 1;

  abstract void update(int deltaTime);

  abstract void display();
}
