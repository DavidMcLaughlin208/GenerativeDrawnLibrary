public abstract class Drawable {
  
  boolean completed = false;
  boolean animated;
  float lerpVal = 0.0;
  float lerpValIncrease = 0.02;
  
  public abstract void draw();
  
}
