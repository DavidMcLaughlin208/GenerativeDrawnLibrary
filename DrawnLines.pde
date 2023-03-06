float rotateAngle = 0;  
float noiseScale = 0.05;

ShapesFactory sf;

void setup() {
  size(600, 600);
  //colorMode(HSB, 255);
  background(240, 240, 240);
  fill(0);
  
  //color bg1 = color(255, 229, 114);
  //color bg2 = color(155, 145, 99);
  //noiseDetail(3,1);

  //for (int x = 0; x < width; x++) {
  //  for (int y = 0; y < height; y++) {
  //    float noiseVal = noise(x * noiseScale, y * noiseScale);
  //    color col = lerpColor(bg1, bg2, noiseVal);
  //    stroke(col);
  //    point(x, y);
  //  }
  //}
  
  sf = new ShapesFactory();
  //for (int angle = 0; angle <= 360; angle += 20) {
  //    int x1 = (int) (height * cos(radians(angle)));
  //    int y1 = (int) (height * sin(radians(angle)));
  //    int x2 = (int) (100 * cos(radians(angle)));
  //    int y2 = (int) (100 * sin(radians(angle)));
  //    sf.lineFromVectors(new PVector(x1, y1), new PVector(x2, y2), true);   
  //}
  //sf.ellipseFromVector(new PVector(), 20f, 50f, false, true);
  Matrix mat = new Matrix(50);
  //mat.seed();
  //mat.draw(sf);
  mat.seedPath();
  mat.draw(sf);
}

void draw() {
  push();
  //translate(width/2, height/2);
  //rotate(radians(rotateAngle += 0.2));
  sf.draw();
  pop();
}
