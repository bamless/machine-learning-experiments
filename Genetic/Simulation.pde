static final int GRID_SZ = 20;
static final int WORLD_SIZE = 40;
static final int PIXEL_WORLD_SZ = WORLD_SIZE * GRID_SZ;
static final int POPULATION_SZ = 2000;

class Simulation {
  PMatrix2D camera = new PMatrix2D();
  Population population = new Population(POPULATION_SZ);
  
  Simulation() {
    camera.translate(WINDOW_WIDTH / 6, WINDOW_HEIGHT / 16);
    camera.scale(0.65, 0.65);
  }
  
  void update() {
    if(population.isDead()) {
      println("Starting over...");
      population = new Population(POPULATION_SZ);
    }
    
    if(!population.isDone())
      population.update();
    else
      population.naturalSelection(0.1);
  }
  
  void show(boolean showAll) {
    pushMatrix();
    applyMatrix(camera);
    
    fill(30);
    rect(0, 0, PIXEL_WORLD_SZ, PIXEL_WORLD_SZ);
    population.show(showAll);
    
    popMatrix();
  }
  
  void showBest() {
    pushMatrix();
    applyMatrix(camera);
    
    fill(30);
    rect(0, 0, PIXEL_WORLD_SZ, PIXEL_WORLD_SZ);
    population.showBest();
    
    popMatrix();
  }
  
}
