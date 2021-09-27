Point[] points = new Point[1000];
Perceptron perceptron = new Perceptron();

void setup() {
  frameRate(75);
  size(700, 700);
  
  // Create the fake data set
  for(int i = 0; i < points.length; i++) {
    points[i] = new Point();
  }
}

void draw() {
  // Train the perceptron
  for(Point p : points) {
    // Use a stupidly low learning rate in order to show the separation line moving
    perceptron.train(1e-5, p.getVector(), p.label);
  }
  
  // Draw the points with different graphics depending on their classification
  background(255);
  for(Point p : points) {
    p.show();
    if(perceptron.guess(p.getVector()) == p.label) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    ellipse(p.pixelX(), p.pixelY(), 5, 5);
  }
  
  // Draw the currently learned separation line
  perceptron.show();
}
