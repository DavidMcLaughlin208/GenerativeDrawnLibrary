float rotateAngle = 0;  
float noiseScale = 0.05;
Matrix mat;
ArrayList<PackedCircle> circles = new ArrayList<PackedCircle>();

ShapesFactory sf;

public PVector getRandomPointInCircle(float radius) {
  float len = random(0, radius);
  float angle = random(0, 360);
  float x = len * cos(radians(angle));
  float y = len * sin(radians(angle));
  return new PVector(x, y);  
}

void setup() {
  fullScreen();
  //size(600, 600);
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
  //for (int angle = 0; angle <= 360; angle += 20) {
  //    int x1 = (int) (height * cos(radians(angle)));
  //    int y1 = (int) (height * sin(radians(angle)));
  //    int x2 = (int) (100 * cos(radians(angle)));
  //    int y2 = (int) (100 * sin(radians(angle)));
  //    sf.lineFromVectors(new PVector(x1, y1), new PVector(x2, y2), true);   
  //}
  //sf.spiralFromVector(new PVector(), 200f, 0.1, true, true);
  mat = new Matrix(50);
  mat.seedPath();
  
  
  
  //////////////////////
  // Spiral Row //
  //float spiralRadius = 200f;
  //for (int x = 0; x < width; x+=spiralRadius) {
  //  for (int y = (int) spiralRadius; y < height; y+=spiralRadius) {
  //    sf.spiralFromVector(new PVector(x, y), spiralRadius, 0.12, false, true);
  //  }
  //}
  
  
  ////////////////
  
  
  //////////////////////
  // Spiral ////////////
  float radius = 200f;
  ArrayList<PVector> origins = new ArrayList<PVector>();
  origins.add(new PVector(0, 0));
  origins.add(new PVector(width, 0));
  origins.add(new PVector(width, height));
  origins.add(new PVector(0, height));
  origins.add(new PVector(width/2, height/2));
  for (PVector origin : origins) {
    sf.spiralFromVector(origin.copy(), radius, 0.12, false, true);
    for (int i = 0; i < 7; i++) {
      sf.circleFromVector(origin.copy(), radius + (i * i * 5), true, false);
    }
    
    for (int angle = 0; angle <= 360; angle += 10) {
        int x1 = (int) (((radius + (6*6*5)) * cos(radians(angle))) + origin.x);
        int y1 = (int) (((radius + (6*6*5)) * sin(radians(angle))) + origin.y);
        int x2 = (int) ((radius * cos(radians(angle))) + origin.x);
        int y2 = (int) ((radius * sin(radians(angle))) + origin.y);
        sf.lineFromVectors(new PVector(x1, y1), new PVector(x2, y2), true);   
    }
  }
  sf.lineFromVectors(new PVector(0, height/2), new PVector(width/6, height/2), true);
  
  sf.lineFromVectors(new PVector(width/6, height/2), new PVector(width/3, height/16), true);
  sf.lineFromVectors(new PVector(width/6, height/2), new PVector(width/3, height - height/16), true);
  
  sf.lineFromVectors(new PVector(width/3, height/16), new PVector(width - width/3, height/16),  true);
  sf.lineFromVectors(new PVector(width/3, height - height/16), new PVector(width - width/3, height - height/16), true);
  
  sf.lineFromVectors(new PVector(width - width/6, height/2), new PVector(width - width/3, height/16), true);
  sf.lineFromVectors(new PVector(width - width/6, height/2), new PVector(width - width/3, height - height/16), true);
  
  sf.lineFromVectors(new PVector(width - width/6, height/2), new PVector(width, height/2), true);
  
  /////////////////////
  
  
  /////////////////////
  // Circle Packing //
  
  //float rad = height/2;
  //int failureCount = 0;
  //sf.circleFromVector(new PVector(), rad, true, false);
  //int failureLimit = 50;
  //while (failureCount < failureLimit) {
  //  for (PackedCircle circ : circles) {
  //    circ.step(circles, rad);  
  //  }
    
  //  while (failureCount < failureLimit) {
  //    PVector pos = getRandomPointInCircle(rad);
  //    boolean failed = false; 
  //    for (PackedCircle circ : circles) {
  //      if (circ.pos.dist(pos) < circ.radius) {
  //        failed = true;
  //        break;
  //      }
  //    }
  //    if (failed) {
  //      failureCount++;  
  //      continue;
  //    }
  //    circles.add(new PackedCircle(pos));
  //    failureCount = 0;
  //    break;
  //  }
    
  //}
  
  //background(255);
  //////////////////
}

void pullCircs() {
  for (int i = 0; i < 5; i++) {
    if (circles.size() > 0) {
      PackedCircle circ = circles.get(0);
      circles.remove(0);
      if (circ.radius > 30) {
        sf.spiralFromVector(circ.pos, circ.radius, 0.1, true, true);
      } else if (circ.radius > 10) {
        sf.circleFromVector(circ.pos, circ.radius, true, false);
      } else {
        sf.circleFromVector(circ.pos, circ.radius, true, true);  
      }
    }
  }  
}

void draw() {
  //pullCircs();
  push();
  //translate(width/2, height/2);
  //rotate(radians(rotateAngle += 0.17));
  //if (frameCount % 10 == 0) {
  //  fill(240, 50);
  //  rect(0, 0, width, height);
  //}
  

  //mat.step(sf);
  sf.draw();
  pop();
}
