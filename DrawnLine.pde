

public class DrawnLine extends Drawable {
  PVector start;
  PVector end;
 
  public DrawnLine(PVector start, PVector end, boolean animated) {
    this.start = start.copy();
    this.end = end.copy();
    this.animated = animated;
  }
  
  public void draw() {
    if (!completed) {
      if (!animated) {
        drawnLine((int) this.start.x, (int) this.start.y, (int) this.end.x, (int) this.end.y);
        this.completed = true;
      } else {
        float x1 = lerp(this.start.x, this.end.x, lerpVal);
        float x2 = lerp(this.start.x, this.end.x, Math.min(lerpVal + lerpValIncrease, 1.0));
        float y1 = lerp(this.start.y, this.end.y, lerpVal);
        float y2 = lerp(this.start.y, this.end.y, Math.min(lerpVal + lerpValIncrease, 1.0));
        drawnLine(x1, y1, x2, y2);
        this.lerpVal += lerpValIncrease;
        if (this.lerpVal >= 1.0) {
          this.completed = true;  
        }
      } 
    }
  }
  
}
