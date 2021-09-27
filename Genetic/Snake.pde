static final int START_LEN = 3;

static final PVector DIR_LEFT = new PVector(-1, 0);
static final PVector DIR_RIGHT = new PVector(1, 0);
static final PVector DIR_UP = new PVector(0, -1);
static final PVector DIR_DOWN = new PVector(0, 1);

static final PVector DIR_LEFT_UP = new PVector(-1, -1);
static final PVector DIR_RIGHT_UP = new PVector(1, -1);
static final PVector DIR_LEFT_DOWN = new PVector(-1, 1);
static final PVector DIR_RIGHT_DOWN = new PVector(1, 1);

class Snake {
  PVector pos, dir;
  boolean dead = false;
  
  Target target;
  ArrayList<PVector> tail = new ArrayList<PVector>();
  
  Snake() {
    init();
  }
  
  void init() {
    pos = new PVector(PIXEL_WORLD_SZ / 2, PIXEL_WORLD_SZ / 2);
    dir = new PVector(0, 0).set(DIR_RIGHT);
    target = new Target();
    for(int i = 0; i < START_LEN; i++) {
      tail.add(new PVector(pos.x - GRID_SZ * (i + 1), pos.y));
    }
  }
  
  void reset() {
    dead = false;
    tail.clear();
    init();
  }
  
  boolean isDead() {
    return dead;
  }
  
  void die() {
    dead = true;
  }
  
  boolean isInTail(PVector p) {
     return tail.contains(p);
  }
  
  boolean outOfBounds(PVector p) {
    return p.x < 0 || p.y < 0 || p.x >= PIXEL_WORLD_SZ || p.y >= PIXEL_WORLD_SZ;
  }
  
  void eat() {
    target.randomPos();
    while(isInTail(target.pos) || pos.equals(target.pos)) {
      target.randomPos();
    }
    PVector last = tail.get(tail.size() - 1);
    tail.add(new PVector(last.x, last.y));
  }
  
  void checkCollisions() {
    if(pos.equals(target.pos)) {
      eat();
    }
    if(isInTail(pos) || outOfBounds(pos)) {
      die();
    }
  }
  
  void moveSnake() {
    for(int i = tail.size() - 1; i > 0; i--) {
       PVector curr = tail.get(i);
       curr.set(tail.get(i - 1));
    }
    tail.get(0).set(pos);
    pos.x += dir.x * GRID_SZ;
    pos.y += dir.y * GRID_SZ;
  }
  
  void update() {
    moveSnake();    
    checkCollisions();
  }
  
  void setDirection(PVector dir) {
    this.dir.set(dir);
  }
  
  void show() {
    fill(20, 62, 233);
    stroke(0);
    rect(pos.x, pos.y, GRID_SZ, GRID_SZ);
    fill(234, 252, 243);
    for(PVector t : tail) {
      rect(t.x, t.y, GRID_SZ, GRID_SZ);
    }
    target.show();
  }

}

class Target {
  PVector pos = new PVector();
  
  Target() {
    randomPos();
  }
  
  void randomPos() {
    int gridX = floor(random(0, PIXEL_WORLD_SZ / GRID_SZ));
    int gridY = floor(random(0, PIXEL_WORLD_SZ / GRID_SZ));
    pos.set(gridX * GRID_SZ, gridY * GRID_SZ);
  }
  
  void show() {
    fill(20, 225, 57);
    stroke(0);
    rect(pos.x, pos.y, GRID_SZ, GRID_SZ);
  }
}
