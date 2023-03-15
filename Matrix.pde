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
}
    
    
public class Matrix {
  private int cellSide;
  private int buffer;
  private int cells;
  ArrayList<ArrayList<Cell>> matrix = new ArrayList<>();
  HashMap<Cell, Direction> cellsToPropagate = new HashMap<Cell, Direction>();
  HashMap<Cell, Direction> cellsToPropagateNext = new HashMap<Cell, Direction>();
  ArrayList<Cell> cellsToDraw = new ArrayList<Cell>();
  HashMap<Direction, PVector> neighborOffset = new HashMap<Direction, PVector>();
  HashMap<Direction, Direction> neighborDirection = new HashMap<Direction, Direction>();
  private ArrayList<Direction> dirList = new ArrayList<Direction>();
  ArrayList<Cell> seenCells = new ArrayList<Cell>();
  
  public Matrix(int cellLength) {
      this.cellSide = cellLength;
      this.cells = height / this.cellSide;
      this.buffer = (height % this.cells) / 2;
      setupMatrix();
      neighborOffset.put(Direction.N, new PVector(0, -1));
      neighborOffset.put(Direction.NE, new PVector(1, -1));
      neighborOffset.put(Direction.E, new PVector(1, 0));
      neighborOffset.put(Direction.SE, new PVector(1, 1));
      neighborOffset.put(Direction.S, new PVector(0, 1));
      neighborOffset.put(Direction.SW, new PVector(-1, 1));
      neighborOffset.put(Direction.W, new PVector(-1, 0));
      neighborOffset.put(Direction.NW, new PVector(-1, -1));
      
      neighborDirection.put(Direction.N, Direction.S);
      neighborDirection.put(Direction.NE, Direction.SW);
      neighborDirection.put(Direction.E, Direction.W);
      neighborDirection.put(Direction.SE, Direction.NW);
      neighborDirection.put(Direction.S, Direction.N);
      neighborDirection.put(Direction.SW, Direction.NE);
      neighborDirection.put(Direction.W, Direction.E);
      neighborDirection.put(Direction.NW, Direction.SE);
      
      dirList.add(Direction.N);
      dirList.add(Direction.NE);
      dirList.add(Direction.E);
      dirList.add(Direction.SE);
      dirList.add(Direction.S);
      dirList.add(Direction.SW);
      dirList.add(Direction.W);
      dirList.add(Direction.NW);
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
    int matrixY = y;
    int matrixX = x;
    if (y < 0) {
      matrixY += this.matrix.size();
    }
    if (y >= this.matrix.size()) {
      matrixY -= this.matrix.size();  
    }
    if (x < 0) {
      matrixX += this.matrix.get(0).size();
    }
    if (x >= this.matrix.get(0).size()) {
      matrixX -= this.matrix.get(0).size();  
    }
    return this.matrix.get(matrixY).get(matrixX);
  }
  
    public Direction getRandomDirection() {
      return dirList.get((int) Math.floor(random(dirList.size())));
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
      Direction dir1 = this.matrix.getRandomDirection();
      Direction dir2 = this.matrix.getRandomDirection();
      ArrayList<Direction> connectionList = new ArrayList<Direction>();
      connectionList.add(dir1);
      //connectionList.add(dir2);  
      this.connections.put(entryPoint, connectionList);
      for (Direction dir : connectionList) {
        Cell neighboringCell = this.getNeighboringCell(dir);
        //if (seenCells.indexOf(neighboringCell) == -1) {
          cellsToPropagateNext.put(neighboringCell, getNeighborEntryPoint(dir));
          //seenCells.add(neighboringCell);
        //}
      }
    }
    
    private Direction getNeighborEntryPoint(Direction dir) {
      return this.matrix.neighborDirection.get(dir);  
    }
    
    private Cell getNeighboringCell(Direction dir) {
      PVector offset = this.matrix.neighborOffset.get(dir);
      return this.matrix.get(this.matrixX + (int) offset.x, this.matrixY + (int) offset.y);  
    }
  }
  
  public void seedPath() {
    Cell center = this.matrix.get(this.cells/2).get(this.cells/2);
    cellsToPropagate.put(center, Direction.Center);
  }
  
  public void step(ShapesFactory sf) {
    for (Cell cell : cellsToPropagate.keySet()) {
      cell.propagate(cellsToPropagate.get(cell));
      for (Direction dir : cell.connections.keySet()) {
        ArrayList<Direction> connex = cell.connections.get(dir);
        for (Direction connectingDir : connex) {
          sf.lineFromVectors(cell.directions.get(dir), cell.directions.get(connectingDir), true);  
        }
      }
    }
    cellsToPropagate.clear();
    cellsToPropagateNext.keySet().forEach(k -> cellsToPropagate.put(k, cellsToPropagateNext.get(k)));
    cellsToPropagateNext.clear();
  }
  
}
