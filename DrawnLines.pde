float rotateAngle = 0;  
float lineLerpVal = 0.0;
float lerpValIncrease = 0.02;
float lineModifier = 1;
float noiseScale = 0.05;
float radius = 50;
boolean drawLines = true;

ShapesFactory sf;

void setup() {
  fullScreen();
  //colorMode(HSB, 255);
  background(200, 200, 200);
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
  for (int angle = 0; angle <= 360; angle += 20) {
      int x1 = (int) (height * cos(radians(angle)));
      int y1 = (int) (height * sin(radians(angle)));
      int x2 = (int) (100 * cos(radians(angle)));
      int y2 = (int) (100 * sin(radians(angle)));
      sf.lineFromVectors(new PVector(x1, y1), new PVector(x2, y2), true);   
  }
  sf.circleFromVector(new PVector(), 50f, true);
  
}


void draw() {
  push();
  translate(width/2, height/2);
  
  //lineLerpVal += lerpValIncrease * lineModifier;
  //if (drawLines) {
  //  for (int angle = 0; angle <= 360; angle += 20) {
      
  //    int x1 = (int) (height * cos(radians(angle)));
  //    int y1 = (int) (height * sin(radians(angle)));
  //    int x2 = (int) (100 * cos(radians(angle)));
  //    int y2 = (int) (100 * sin(radians(angle)));
      
  //    float x3 = lerp(x1, x2, lineLerpVal);
  //    float y3 = lerp(y1, y2, lineLerpVal);
  //    float x4 = lerp(x1, x2, lineLerpVal + lerpValIncrease);
  //    float y4 = lerp(y1, y2, lineLerpVal + lerpValIncrease);
      
  //    drawnLine((int) x3, (int) y3, (int) x4, (int) y4);
      
      
  //  }
  //}
  //if (lineLerpVal >= 1.0 || lineLerpVal <= 0.0) {
  //  lineModifier *= -1.0;  
  //  drawLines = false;
  //}
  //rotate(radians(rotateAngle));
  ////if (radius < 300)
  //if (drawLines)
  //  drawnCircle(0, 0, radius, lineLerpVal);
  //pop();
  //rotateAngle += 0.5;
  sf.draw();
  pop();
}

void drawnCircle(int x, int y, float radius, float lineLerpVal) {
  float angle = lerp(0, 360, lineLerpVal);  
  float toAngle = lerp(0, 360, lineLerpVal + lerpValIncrease);
  int x1 = (int) (x + radius * cos(radians(angle)));
  int y1 = (int) (y + radius * sin(radians(angle)));
  int x2 = (int) (x + radius * cos(radians(toAngle)));
  int y2 = (int) (y + radius * sin(radians(toAngle)));
  drawnLine(x1, y1, x2, y2);
  
}

void drawnLine(PVector p1, PVector p2) {
  drawnLine((int) p1.x, (int) p1.y, (int) p2.x, (int) p2.y);  
}
