public enum Direction {
  Center,
  N,
  NE,
  E,
  SE,
  S,
  SW,
  W,
  NW;
  
  public static Direction getRandomDirection() {
    return Direction.N;
  }
}
    
    
public class Matrix {
  private int cellSide;
  private int buffer;
  private int cells;
  ArrayList<ArrayList<Cell>> matrix = new ArrayList<>();
  
  public Matrix(int cellLength) {
      this.cellSide = cellLength;
      this.cells = height / this.cellSide;
      this.buffer = (height % this.cells) / 2;
      setupMatrix();
  }
  
  private void setupMatrix() {
    for (int y = 0; y < this.cells; y++) {
      matrix.add(new ArrayList<Cell>());
      for (int x = 0; x < this.cells; x++) {
        matrix.get(y).add(new Cell(this, x, y, this.buffer, this.cellSide));
      }   
    }
  }
  
  public Cell get(int x, int y) {
    if (y >= 0 && y < this.matrix.size()) {
      ArrayList<Cell> row = this.matrix.get(y);
      if (x >= 0 && x < row.size()) {
        return row.get(x);  
      }
    }
    return null;
  }
  
  public class Cell {
    public int matrixX;
    public int matrixY;
    public int buffer;
    public int cellSide;
    public boolean seeded = false;
    public HashMap<Direction, PVector> directions = new HashMap<Direction, PVector>();
    public HashMap<Direction, ArrayList<Direction>> connections = new HashMap<Direction, ArrayList<Direction>>();
    public Matrix matrix;
    
    public Cell(Matrix matrix, int matrixX, int matrixY, int buffer, int cellSide) {
      this.matrix = matrix;
      this.matrixX = matrixX;
      this.matrixY = matrixY;
      this.buffer = buffer;
      this.cellSide = cellSide;
      directions.put(Direction.N, new PVector(midX(), topY())); 
      directions.put(Direction.NE, new PVector(rightX(), topY())); 
      directions.put(Direction.E, new PVector(rightX(), midY())); 
      directions.put(Direction.SE, new PVector(rightX(), bottomY())); 
      directions.put(Direction.S, new PVector(midX(), bottomY())); 
      directions.put(Direction.SW, new PVector(leftX(), bottomY())); 
      directions.put(Direction.W, new PVector(leftX(), midY()));
      directions.put(Direction.NW, new PVector(leftX(), topY()));
      directions.put(Direction.Center, new PVector(midX(), midY()));
    }
    
    private int leftX() {
      return buffer + matrixX * cellSide;
    }
    
    private int midX() {
      return buffer + matrixX * cellSide + cellSide/2;
    }
    
    private int rightX() {
      return buffer + matrixX * cellSide + cellSide;
    }
    
    private int topY() {
      return buffer + matrixY * cellSide;
    }
    
    private int midY() {
      return buffer + matrixY * cellSide + cellSide/2;
    }
    
    private int bottomY() {
      return buffer + matrixY * cellSide + cellSide;
    }
    
    public void propagate(Direction entryPoint) {
      Direction dir = Direction.getRandomDirection();
      ArrayList<Direction> connectionList = new ArrayList<Direction>();
      connectionList.add(dir);
      this.connections.put(entryPoint, connectionList);
      Cell neighboringCell = this.getNeighboringCell(dir);
      if (neighboringCell != null) {
        neighboringCell.propagate(Direction.S);  
      }
    }
    
    private Cell getNeighboringCell(Direction dir) {
      return this.matrix.get(this.matrixX, this.matrixY - 1);  
    }
  }
  
  public void seedPath() {
    Cell center = this.matrix.get(this.cells/2).get(this.cells/2);
    center.propagate(Direction.Center);
  }
  
  public void draw(ShapesFactory sf) {
    for (int y = 0; y < this.cells; y++) {
      for (int x = 0; x < this.cells; x++) {
        Cell cell = this.matrix.get(y).get(x);
        for (Direction dir : cell.connections.keySet()) {
          ArrayList<Direction> connex = cell.connections.get(dir);
          for (Direction connectingDir : connex) {
            sf.lineFromVectors(cell.directions.get(dir), cell.directions.get(connectingDir), true);  
          }
        }
      }
    }
  }
  
  //public void draw(ShapesFactory sf) {
  //  for (int y = 0; y < this.cells; y++) {
  //    ArrayList<HashMap<String, Boolean>> row = matrix.get(y);
  //    for (int x = 0; x < this.cells; x++) {
  //      boolean n = row.get(x).get("N");
  //      boolean e = row.get(x).get("E");
  //      boolean s = row.get(x).get("S");
  //      boolean w = row.get(x).get("W");
  //      PVector nVec = new PVector(this.buffer + (x) * this.cellSide + this.cellSide/2, this.buffer + (y) * this.cellSide);
  //      PVector eVec = new PVector(this.buffer + (x) * this.cellSide + this.cellSide, this.buffer + (y) * this.cellSide + this.cellSide/2);
  //      PVector sVec = new PVector(this.buffer + (x) * this.cellSide + this.cellSide/2, this.buffer + (y) * this.cellSide + this.cellSide);
  //      PVector wVec = new PVector(this.buffer + (x) * this.cellSide, this.buffer + (y) * this.cellSide + this.cellSide/2);
  //      if (n && e) {
  //        sf.lineFromVectors(nVec.copy(), eVec.copy(), true);  
  //      }
  //      if (n && s) {
  //        sf.lineFromVectors(nVec.copy(), sVec.copy(), true);
  //      }
  //      if (n && w) {
  //        sf.lineFromVectors(nVec.copy(), wVec.copy(), true); 
  //      }
  //      if (e && s) {
  //        sf.lineFromVectors(eVec.copy(), sVec.copy(), true);  
  //      }
  //      if (e && w) {
  //        sf.lineFromVectors(eVec.copy(), wVec.copy(), true);  
  //      }
  //      if (s && w) {
  //        sf.lineFromVectors(sVec.copy(), wVec.copy(), true);  
  //      }
  //      if (n && e && s && w) {
  //        sf.circleFromVector(new PVector(this.buffer + (x) * this.cellSide + this.cellSide/2, this.buffer + (y) * this.cellSide + this.cellSide/2), 5f, true, random(1) > 0.5);  
  //      }
  //    }
  //  }
  //}
  
}
