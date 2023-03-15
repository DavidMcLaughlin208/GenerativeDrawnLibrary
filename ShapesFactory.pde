
public class ShapesFactory {
 
  private ArrayList<Drawable> shapes = new ArrayList<>();
  
  public ShapesFactory() {}
  
  public void lineFromVectors(PVector start, PVector end, boolean animated) {
    DrawnLine line = new DrawnLine(start, end, animated);
    shapes.add(line);
  }
  
  public void circleFromVector(PVector pos, float radius, boolean animated, boolean shaded) {
    DrawnEllipse circle = new DrawnEllipse(pos, radius, animated, shaded);
    shapes.add(circle);
  }
  
  public void ellipseFromVector(PVector pos, float xRadius, float yRadius, boolean animated, boolean shaded) {
    DrawnEllipse ellipse = new DrawnEllipse(pos, xRadius, yRadius, animated, shaded);
    shapes.add(ellipse);
  }
  
  public void spiralFromVector(PVector pos, float maxRadius, float increments, boolean animated, boolean oscillate) {
    DrawnSpiral spiral = new DrawnSpiral(pos, maxRadius, increments, animated, oscillate);
    shapes.add(spiral);
  }
  
  public void draw() {
    //lines.stream().forEach(line -> {
    //  if (!line.completed) {
    //    line.draw();  
    //  }
    //});  
    for (int i = 0; i < shapes.size(); i++) {
      shapes.get(i).draw();  
    }
  }
  
}
