public class PackedCircle {
  
  public PVector pos;
  public float radius = 0.0;
  public boolean stopped = false;
  
  public PackedCircle(PVector pos) {
    this.pos = pos;
  }
  
  public void step(ArrayList<PackedCircle> circles, float enclosureRadius) {
    if (!this.stopped) {
      this.radius += 0.5;
      for (PackedCircle neighbor : circles) {
        if (neighbor == this) {
          continue;  
        }
        float distance = this.pos.dist(neighbor.pos);
        if (distance <= this.radius + neighbor.radius) {
          this.stopped = true;  
        }
      }
      if (this.pos.dist(new PVector()) + this.radius >= enclosureRadius) {
        this.stopped = true;
      }
    }
  }

}
