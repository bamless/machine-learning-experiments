// Formula used to generate the points separation
float separation(float x) {
  return 0.87 * x + 0.33;
}

class Point {
  float x, y;
  int label;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  Point() {
    this.x = random(-1, 1);
    this.y = random(-1, 1);
    this.label = y < separation(x) ? 1 : -1;
  }
  
  float[] getVector() {
    return new float[] {this.x, this.y};
  }
  
  int getLabel() {
    return label;
  }
  
  // Converts the point's x value from -1, 1 to 0, width
  float pixelX() {
    return map(x, -1, 1, 0, width);
  }
  
  // Converts the point's y value from -1, 1 to 0, height
  float pixelY() {
    return map(y, -1, 1, height, 0);
  }
  
  // Visualize the data in screen space
  void show() {
    stroke(0);
    if(label == 1)
      fill(255);
    else
      fill(0);   
    ellipse(pixelX(), pixelY(), 10, 10);
  }
}
