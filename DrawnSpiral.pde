public class DrawnSpiral extends Drawable {
 
  private PVector pos;
  private float xRadius;
  private float yRadius;
  private float xMaxRadius;
  private float yMaxRadius;
  private float xIncrements;
  private float yIncrements;
  private boolean oscillate;
  private float lerpMultiplier = 1.0;
  private float rotationAngle = 0.0;
  private int stepsPerFrame; 
  
  public DrawnSpiral(PVector pos, float maxRadius, float increments, boolean animated, boolean oscillate) {
    this.pos = pos;
    this.xRadius = 0;
    this.yRadius = 0;
    this.xMaxRadius = maxRadius;
    this.yMaxRadius = 100;
    this.animated = animated;
    this.xIncrements = increments;
    this.yIncrements = this.yMaxRadius * (this.xIncrements/this.xMaxRadius);
    this.oscillate = oscillate;
    int stepsToComplete = (int) (this.xMaxRadius / increments);
    this.stepsPerFrame = (int) ((float) stepsToComplete * this.lerpValIncrease);
  }
  
  public void draw() {
    if (!this.completed) {
       if (!this.animated) {
         while (!this.completed) {
           step();
         }
       } else {
         for (int i = 0; i < this.stepsPerFrame; i++) {
           step();
         }
       }
    }
    
  }
  
  private void step() {
    push();
    translate(this.pos.x, this.pos.y);
    if (this.oscillate) {
      rotate(radians(rotationAngle));
    }
    drawSegment();
    this.xRadius += this.xIncrements;
    this.yRadius += this.yIncrements;
    this.lerpVal += this.lerpValIncrease * this.lerpMultiplier;
    if (this.oscillate && (this.lerpVal < 0.0 || this.lerpVal > 1.0)) {
      this.lerpMultiplier *= -1.0;  
    }
    this.rotationAngle += 0.3;
    if (this.xRadius >= xMaxRadius) {
      this.completed = true;  
    }
    pop();
  }
  
  private void drawSegment() {
    float angle = lerp(0, 360, this.lerpVal);  
    float toAngle = lerp(0, 360, this.lerpVal + this.lerpValIncrease);
    int x1 = (int) (this.xRadius * cos(radians(angle)));
    int y1 = (int) (this.yRadius * sin(radians(angle)));
    int x2 = (int) (this.xRadius * cos(radians(toAngle)));
    int y2 = (int) (this.yRadius * sin(radians(toAngle)));
    drawnLine(x1, y1, x2, y2);   
  }
  
}
