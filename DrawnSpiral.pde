public class DrawnSpiral extends Drawable {
 
  private PVector pos;
  private float radius;
  private float maxRadius;
  private float increments;
  private boolean oscillate;
  private float lerpMultiplier = 1.0;
  private float rotationAngle = 0.0;
  
  public DrawnSpiral(PVector pos, float maxRadius, float increments, boolean animated, boolean oscillate) {
    this.pos = pos;
    this.radius = 0;
    this.maxRadius = maxRadius;
    this.animated = animated;
    this.increments = increments;
    this.oscillate = oscillate;
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
    push();
    //translate(this.pos.x, this.pos.y);
    //rotate(radians(rotationAngle));
    drawSegment();
    this.radius += this.increments;
    this.lerpVal += this.lerpValIncrease * this.lerpMultiplier;
    if (this.oscillate && (this.lerpVal < 0.0 || this.lerpVal > 1.0)) {
      this.lerpMultiplier *= -1.0;  
    }
    this.rotationAngle += 0.2;
    if (this.radius >= maxRadius) {
      this.completed = true;  
    }
    pop();
  }
  
  private void drawSegment() {
    float angle = lerp(0, 360, this.lerpVal);  
    float toAngle = lerp(0, 360, this.lerpVal + this.lerpValIncrease);
    int x1 = (int) (this.pos.x + this.radius * cos(radians(angle)));
    int y1 = (int) (this.pos.y + this.radius * sin(radians(angle)));
    int x2 = (int) (this.pos.x + this.radius * cos(radians(toAngle)));
    int y2 = (int) (this.pos.y + this.radius * sin(radians(toAngle)));
    drawnLine(x1, y1, x2, y2);   
  }
  
}
