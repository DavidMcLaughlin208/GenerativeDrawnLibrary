void drawnLine(float x1, float y1, float x2, float y2) {
  drawnLine((int) x1, (int) y1, (int) x2, (int) y2);  
}

void drawnLine(int x1, int y1, int x2, int y2) {
    // If the two points are the same no need to iterate. Just run the provided function
    if (x1 == x2 && y1 == y2) {
        ellipse(x1, y1, random(1, 3), random(1, 3));
        return;
    }


    int xDiff = x1 - x2;
    int yDiff = y1 - y2;
    boolean xDiffIsLarger = Math.abs(xDiff) > Math.abs(yDiff);

    int xModifier = xDiff < 0 ? 1 : -1;
    int yModifier = yDiff < 0 ? 1 : -1;

    int longerSideLength = Math.max(Math.abs(xDiff), Math.abs(yDiff));
    int shorterSideLength = Math.min(Math.abs(xDiff), Math.abs(yDiff));
    float slope = (shorterSideLength == 0 || longerSideLength == 0) ? 0 : ((float) (shorterSideLength) / (longerSideLength));

    int shorterSideIncrease;
    for (int i = 1; i <= longerSideLength; i++) {
        shorterSideIncrease = Math.round(i * slope);
        int yIncrease, xIncrease;
        if (xDiffIsLarger) {
            xIncrease = i;
            yIncrease = shorterSideIncrease;
        } else {
            yIncrease = i;
            xIncrease = shorterSideIncrease;
        }
        int currentY = y1 + (yIncrease * yModifier);
        int currentX = x1 + (xIncrease * xModifier);
        stroke(random(0, 50));
        ellipse(currentX, currentY, random(0.1, 3), random(0.1, 3));
        
    }
}
