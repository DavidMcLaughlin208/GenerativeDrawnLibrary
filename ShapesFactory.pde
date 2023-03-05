
public class ShapesFactory {
 
  private ArrayList<Drawable> shapes = new ArrayList<>();
  
  public ShapesFactory() {}
  
  public void lineFromVectors(PVector start, PVector end, boolean animated) {
    DrawnLine line = new DrawnLine(start, end, animated);
    shapes.add(line);
  }
  
  public void circleFromVector(PVector pos, float radius, boolean animated) {
    DrawnEllipse circle = new DrawnEllipse(pos, radius, animated);
    shapes.add(circle);
  }
  
  public void ellipseFromVector(PVector pos, float xRadius, float yRadius, boolean animated) {
    DrawnEllipse ellipse = new DrawnEllipse(pos, xRadius, yRadius, animated);
    shapes.add(ellipse);
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
