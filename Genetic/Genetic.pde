final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 600;

final int SLOW_SPEED = 20;
final int FAST_SPEED = 500;

Simulation s = new Simulation();
boolean showAll = true;
boolean showBest = false;

void setup() {
  frameRate(FAST_SPEED);
  size(800, 600);
}

void update() {
  s.update();
}

void show() {
  if(showBest)
    s.showBest();
  else
    s.show(showAll);
}

void draw() {
  //noLoop();
  update();
  background(255);
  show();
}

void keyPressed() {
  switch(key) {
  case 'a':
    showAll = !showAll;
    break;
  case 'b':
    showBest = !showBest;
    break;
  case 's':
    frameRate(SLOW_SPEED);
    break;
  case 'f':
    frameRate(FAST_SPEED);
    break;
  }
}
