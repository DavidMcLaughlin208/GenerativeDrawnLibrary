public class DrawnEllipse extends Drawable {
 
  private PVector pos;
  private float xRadius;
  private float yRadius;
  private boolean shaded;
  
  public DrawnEllipse(PVector pos, float radius, boolean animated, boolean shaded) {
    this(pos, radius, radius, animated, shaded);
  }
  
  public DrawnEllipse(PVector pos, float xRadius, float yRadius, boolean animated, boolean shaded) {
    this.pos = pos;
    this.xRadius = xRadius;
    this.yRadius = yRadius;
    this.animated = animated;
    this.shaded = shaded;
  }
  
  public void draw() {
    if (!this.completed) {
       if (!this.animated) {
         while (!this.completed) {
           step();
         }
       } else {
         step();
       }
    }
    
  }
  
  private void step() {
    drawSegment();
    if (this.shaded) {
      drawShadeSegment();  
    }
    this.lerpVal += this.lerpValIncrease;
    if (this.lerpVal >= 1.0) {
      this.completed = true;  
    }
  }
  
  private boolean ellipseContainsPoint(int x, int y) {
    double p = ((double)Math.pow((x - this.pos.x), 2)
                    / (double)Math.pow(this.xRadius, 2))
                   + ((double)Math.pow((y - this.pos.y), 2)
                      / (double)Math.pow(this.yRadius, 2));
    return p < 1;
  }
  
  private void drawShadeSegment() {
    float localLerpVal = 0.0;
    float localLerpValIncrease = 0.02;
    float yStart = (float) Math.floor(lerp(this.pos.y - yRadius, this.pos.y + yRadius, this.lerpVal));
    float yEnd = (float) Math.floor(lerp(this.pos.y - yRadius, this.pos.y + yRadius, this.lerpVal + lerpValIncrease));
    for (int y = (int) (yStart); y < yEnd; y+=3) {
      localLerpVal = 0.0;
      while (localLerpVal < 1.0) {
        float x1 = lerp(this.pos.x - xRadius, this.pos.x + xRadius, localLerpVal);
        float x2 = lerp(this.pos.x - xRadius, this.pos.x + xRadius, localLerpVal + localLerpValIncrease);
        if (ellipseContainsPoint((int) x1, y)) {
          drawnLine(x1, y, x2, y);
        }
        localLerpVal += localLerpValIncrease;
      }
    }
  }
  
  private void drawSegment() {
    float angle = lerp(0, 360, this.lerpVal);  
    float toAngle = lerp(0, 360, this.lerpVal + this.lerpValIncrease);
    int x1 = (int) (this.pos.x + xRadius * cos(radians(angle)));
    int y1 = (int) (this.pos.y + yRadius * sin(radians(angle)));
    int x2 = (int) (this.pos.x + xRadius * cos(radians(toAngle)));
    int y2 = (int) (this.pos.y + yRadius * sin(radians(toAngle)));
    drawnLine(x1, y1, x2, y2);   
  }
  
}
