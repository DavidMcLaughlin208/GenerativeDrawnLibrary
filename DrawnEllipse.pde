public class DrawnEllipse extends Drawable {
 
  private PVector pos;
  private float xRadius;
  private float yRadius;
  
  public DrawnEllipse(PVector pos, float radius, boolean animated) {
    this(pos, radius, radius, animated);
  }
  
  public DrawnEllipse(PVector pos, float xRadius, float yRadius, boolean animated) {
    this.pos = pos;
    this.xRadius = xRadius;
    this.yRadius = yRadius;
    this.animated = animated;
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
    this.lerpVal += this.lerpValIncrease;
    if (this.lerpVal >= 1.0) {
      this.completed = true;  
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
