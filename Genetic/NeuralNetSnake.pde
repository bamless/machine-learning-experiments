static final int INITIAL_TTL = 200;
static final int CUTOFF = 10;

class NeuralNetSnake extends Snake {
  NeuralNetwork neuralNet;
  
  float[] vision = new float[24];
  PVector tmp = new PVector();
  
  int lifeTime = 0;
  int leftToLive = INITIAL_TTL;
  long fitness = 0;
  
  NeuralNetSnake(NeuralNetwork neuralNet) {
    super();
    this.neuralNet = neuralNet;
  }
  
  NeuralNetSnake() {
    this(new NeuralNetwork(SIGMOID, 24, 18, 4));
  }
  
  NeuralNetSnake clone() {
    NeuralNetSnake clone = new NeuralNetSnake(neuralNet.clone());
    return clone;
  }
  
  void lookTowards(int start, PVector direction) {
    PVector lookPos = tmp;
    lookPos.set(pos);
    
    boolean targetFound = false, tailFound = false;
    
    lookPos.x += direction.x * GRID_SZ;
    lookPos.y += direction.y * GRID_SZ;
    float distance = 1;
    
    while(!outOfBounds(lookPos)) {
      if(!targetFound && lookPos.equals(target.pos)) {
        targetFound = true;
        vision[start] = 1;
      }
      
      if(!tailFound && isInTail(lookPos)) {
        tailFound = true;
        vision[start + 1] = 1 / distance;
      }
      
      lookPos.x += direction.x * GRID_SZ;
      lookPos.y += direction.y * GRID_SZ;
      distance++;
    }
    
    vision[start + 2] = 1 / distance;
  }
  
  void look() {
    for(int i = 0; i < vision.length; i++) {
      vision[i] = 0;
    }
    lookTowards(0, DIR_LEFT);
    lookTowards(3, DIR_LEFT_UP);
    lookTowards(6, DIR_UP);
    lookTowards(9, DIR_RIGHT_UP);
    lookTowards(12, DIR_RIGHT);
    lookTowards(15, DIR_RIGHT_DOWN);
    lookTowards(18, DIR_DOWN);
    lookTowards(21, DIR_LEFT_DOWN);
  }
  
  int argMax(float[] res) {
    float max = -1;
    int prediction = -1;
    for(int i = 0; i < res.length; i++) {
      if(res[i] > max) {
        max = res[i];
        prediction = i;
      }
    }
    return prediction;
  }
  
  int predict() {
    float res[] = neuralNet.feedForward(vision);
    return argMax(res);
  }
  
  void performMove(int prediction) {
    switch(prediction) {
    case 0:
      setDirection(DIR_LEFT);
      break;
    case 1:
      setDirection(DIR_UP);
      break;
    case 2:
      setDirection(DIR_RIGHT);
      break;
    case 3:
      setDirection(DIR_DOWN);
      break;
    default:
      assert(false);
      break;
    }
  }
  
  void eat() {
    leftToLive += 100;
    super.eat();
    if(tail.size() + 1 < CUTOFF) {
      for(int i = 0; i < 3; i++) {
        PVector last = tail.get(tail.size() - 1);
        tail.add(new PVector(last.x, last.y));
      }
    }
  }
  
  void update() {
    lifeTime++;
    if(--leftToLive < 0) {
      dead = true;
      return;
    }
    look();
    performMove(predict());
    super.update();
  }
  
  void show() {
    look();
    super.show();
  }
  
  void computeFitness() {
    int len = tail.size() + 1;
    
    if(len < CUTOFF) {
      fitness = (long)(lifeTime * lifeTime * pow(2, len));
    } else {
      fitness = (long)((lifeTime * lifeTime) * pow(2, 10)) * (len - (CUTOFF - 1));
    }
    
    if(leftToLive <= 0) {
      fitness *= pow((float) Math.E, -len / 30.0f);
    }
  }
  
  long getFitness() {
    return fitness; 
  }
  
  void mutate(float mutationRate) {
    neuralNet.mutate(mutationRate);
  }
  
}
