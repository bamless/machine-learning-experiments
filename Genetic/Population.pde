class Population {
  int gen = 0;
  
  NeuralNetSnake[] snakes;
  int deadSnakes = 0;
  
  NeuralNetSnake best;
  int lastImprovement;
  int currentBest = 0;
  
  long totalFitness;
 
  Population(int count) {
    snakes = new NeuralNetSnake[count];
    for(int i = 0; i < count; i++) {
      snakes[i] = new NeuralNetSnake();
    }
    best = snakes[0].clone();
  }
  
  void update() {
    for(Snake s : snakes) {
      if(!s.isDead()) {
        s.update();
        if(s.isDead()) deadSnakes++;
      }
    }
    setCurrentBest();
  }
  
  boolean isDone() {
    return deadSnakes == snakes.length;
  }
  
  void setCurrentBest() {
    int max = 0;
    int idx = 0;
    for(int i = 0; i < snakes.length; i++) {
      NeuralNetSnake s = snakes[i];
      if(!s.isDead() && s.tail.size() + 1 > max) {
        max = s.tail.size() + 1;
        idx = i;
      }
    }
    
    if(snakes[currentBest].isDead() || max > snakes[currentBest].tail.size() + 6)
      currentBest = idx;
  }
  
  void setBestSnake() {
    for(NeuralNetSnake s : snakes) {
      if(s.getFitness() > best.getFitness()) {
        best = s;
        lastImprovement = gen;
      }
    }
  }
  
  NeuralNetSnake selectForBreeding() {
    long rand = floor(random(totalFitness));
    
    long sum = 0;
    for(NeuralNetSnake s : snakes) {
      sum += s.getFitness();
      if(sum > rand)
        return s;
    }
 
    assert(false);
    return null;
  }
  
  NeuralNetSnake breed(NeuralNetSnake s1, NeuralNetSnake s2) {
    return new NeuralNetSnake(s1.neuralNet.crossOver(s2.neuralNet));
  }
  
  void computeFitness() {
    totalFitness = 0;
    for(NeuralNetSnake s : snakes) {
      s.computeFitness();
      totalFitness += s.getFitness();
    }
  }
  
  void naturalSelection(float mutationRate) {
    gen++;
    computeFitness();
    setBestSnake();

    NeuralNetSnake[] newSnakes = new NeuralNetSnake[snakes.length];
    newSnakes[0] = best.clone();
    println("gen " + gen + " best " + (best.tail.size() + 1) + " " + best.getFitness());
    
    for(int i = 1; i < newSnakes.length; i++) {
      NeuralNetSnake parent1 = selectForBreeding();
      NeuralNetSnake parent2 = selectForBreeding();
      NeuralNetSnake newSnake = breed(parent1, parent2);
      newSnake.mutate(mutationRate);
      newSnakes[i] = newSnake;
    }
    
    snakes = newSnakes;
    currentBest = START_LEN;
    deadSnakes = 0;
  }
  
  boolean isDead() {
    if(gen - lastImprovement > 30 && best.tail.size() + 1 < 40) {
      return true;
    }
    return false;
  }
  
  void show(boolean drawAll) {
    if(drawAll) {
      for(Snake s : snakes) {
        if(!s.isDead()) s.show();
      }
    } else {
      if(!snakes[currentBest].isDead())  snakes[currentBest].show();
    }
  }
  
  void showBest() {
    if(!snakes[0].isDead()) snakes[0].show();
  }
  
}
