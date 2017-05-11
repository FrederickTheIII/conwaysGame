class Cell {
  int x;
  int y;
  boolean alive;
  int colour;
  int xsize = floor(xysize / cellAmount);
  int ysize = floor(xysize / cellAmount);
  
  Cell(int x_, int y_) {
    this.x = x_;
    this.y = y_;
  }
  
  void display() {
    strokeWeight(1);
    fill(colour);
    rect(this.x * xsize, this.y * ysize, (this.x * xsize) + xsize, (this.y * ysize) + ysize);
  }
  
  void colourChange() {
    stroke(0, 75);
    if (this.alive == true) colour = 255;
    else {
      colour = 51;
    }
  }
  
  void checkNeighbours() {  
    int aliveCount = addNeighbours();
    
    if (this.alive == true) {
      // rules 1 & 3: death rules
      if (aliveCount < 2 || aliveCount > 3) {
        need2change.add(this);
      }
      // Not needed as rule 2 doesn't change anything
      // rule 2
      //else if (aliveCount == 2 || aliveCount == 3) {
       // stay alive
      //}
    } else if (this.alive == false) {
      // rule 4: resurrection rule
      if (aliveCount == 3) {
        need2change.add(this);
      }
    }
  }
  
  int addNeighbours() {
    int alivecount = 0;
    
    int xpos = this.x;
    int ypos = this.y;
    
    
    // This whole mess of code is to count the amount of alive cells nearby.
    // Lots of validation for out-of-bounds array issues.
    
    // top
    if (xpos != 0 && ypos != 0 &&                                     // Top-Left
      cells[xpos - 1][ypos - 1].alive == true) alivecount++;
    
    if (ypos != 0 &&                                                  // Top-Middle
      cells[  xpos  ][ypos - 1].alive == true) alivecount++;
    
    if (xpos != cells[ypos].length - 1 && ypos != 0 &&                // Top-Right
      cells[xpos + 1][ypos - 1].alive == true) alivecount++;
    
    
    // middle
    if (xpos != 0 &&                                                  // Middle-Left
      cells[xpos - 1][  ypos  ].alive == true) alivecount++;
    if (xpos != cells[ypos].length - 1 &&                             // Middle-Right
      cells[xpos + 1][  ypos  ].alive == true) alivecount++;
    
    // bottom
    if (xpos != 0 && ypos != cells.length - 1 &&                      // Bottom-Left
      cells[xpos - 1][ypos + 1].alive == true) alivecount++;
    
    if (ypos != cells.length - 1 &&                                   // Bottom-Middle
      cells[  xpos  ][ypos + 1].alive == true) alivecount++;

    if (xpos != cells[ypos].length - 1 && ypos != cells.length - 1 && // Bottom-Right
      cells[xpos + 1][ypos + 1].alive == true) alivecount++;
    return alivecount;
  }
}