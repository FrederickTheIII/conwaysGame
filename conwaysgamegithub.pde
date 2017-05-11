//// Conway's Game of Life: The Four Rules
// 1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
// 2. Any live cell with two or three live neighbours lives on to the next generation.
// 3. Any live cell with more than three live neighbours dies, as if by overpopulation.
// 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

// Global Variables.
int cellAmount = 50;
int xysize = 800;
boolean pause;
PFont monoFont;
int generationCount = 0;
int fps = 4;

// 2D Array grid of cells.
Cell[][] cells = new Cell[cellAmount][cellAmount];
// Arraylist to hold which cells need to change state.
ArrayList<Cell> need2change = new ArrayList<Cell>();

// runs once, i use this to run all things that need to run once
void setup() {
  size(1000, 800);
  frameRate(50);
  colorMode(HSB);
  background(51);
  
  // Fonts
  monoFont = loadFont("monospaced.vlw");
  textFont(monoFont, 16);
  
  //// For loop to create a 50x50 2D array of Cells.
  stroke(0, 75);
  for (int j = 0; j < cellAmount; j++) {
    for (int i = 0; i < cellAmount; i++) {
      // Creates a new cell
      Cell creation = new Cell(i, j);
      // Deciding if the cell will be alive or dead.
      if (random(1) <= .8) {
        // to function normally: false
        creation.alive = false;
      } else {
        // to function normally: true
        creation.alive = true;
      }
      // Setting one of the grid spaces to the new cell.
      cells[i][j] = creation;
    }
  }
  // Ten cell row
  // {
  //cells[20][15].alive = true;
  //cells[21][15].alive = true;
  //cells[22][15].alive = true;
  //cells[23][15].alive = true;
  //cells[24][15].alive = true;
  //cells[25][15].alive = true;
  //cells[26][15].alive = true;
  //cells[27][15].alive = true;
  //cells[28][15].alive = true;
  //cells[29][15].alive = true;
  // }
  thread("noError");
  // Draws the menu on the first frame.
  graphics();
  if (!pause) {
    generationCount += 1;
  }
}

void draw() {
  thread("noError");
  println("size: " + need2change.size());
  for (Cell cell : need2change) {
    cell.alive = !cell.alive;
  }
  need2change.clear();
  
  // Draws the menu on screen every frame.
  graphics();
}

void createCell(float xpos, float ypos) {
  xpos = floor(xpos / (xysize / cellAmount));
  ypos = floor(ypos / (xysize / cellAmount));
  cells[int(xpos)][int(ypos)].alive = !cells[int(xpos)][int(ypos)].alive;
}



// thread function
void noError() {
  if (!pause) {
    generationCount += 1;
  }
  println("frameRate: " + frameRate);
  println("frameCount: " + frameCount);
  println("frame/fps: " + floor(frameRate) / fps + "\n");
  for (int j = 0; j < cells.length; j++) {
    for (int i = 0; i < cells[j].length; i++) {
      cells[i][j].colourChange();
      cells[i][j].display();
      if (!pause) {
        cells[i][j].checkNeighbours();
      }
    }
  }
}

void keyPressed() {
  if (key == 'p') pause = !pause;
  else if (key == 'c') {
    // grid clear code
    for (int j = 0; j < cellAmount; j++) {
      for (int i = 0; i < cellAmount; i++) {
        cells[i][j].alive = false;
      }
    }
    generationCount = 1;
    pause = true;
  } else if (key == 'r') {
    // grid restart code
    for (int j = 0; j < cellAmount; j++) {
      for (int i = 0; i < cellAmount; i++) {
        // to function normally: false
        if (random(1) <= .8) cells[i][j].alive = false;
          // to function normally: true
        else cells[i][j].alive = true;
      }
    }
  generationCount = 1;
  // step code
  } else if (key == 's') {
    for (int j = 0; j < cells.length; j++) {
      for (int i = 0; i < cells[j].length; i++) {
        cells[i][j].colourChange();
        cells[i][j].display();
        cells[i][j].checkNeighbours();
      }
    }
  for (Cell cell : need2change) {
    cell.alive = !cell.alive;
  }
  need2change.clear();
  generationCount += 1;
  
  graphics();
  
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    // creates/kills cell at xy pos
    if (mouseX < xysize) {
      createCell(mouseX, mouseY);
    
    // pause button
    } else if (mouseX > 853 && mouseX < 953 && mouseY > 720 && mouseY < 755) {
      pause = !pause;
    
    // clear button
    } else if (mouseX > 813 && mouseX < 898 && mouseY > 675 && mouseY < 710) {
      for (int j = 0; j < cellAmount; j++) {
        for (int i = 0; i < cellAmount; i++) {
          cells[i][j].alive = false;
        }
      }
    generationCount = 1;
    pause = true;
    
    // restart button
    } else if (mouseX > 908 && mouseX < 993 && mouseY > 675 && mouseY < 710) {
      for (int j = 0; j < cellAmount; j++) {
        for (int i = 0; i < cellAmount; i++) {
          if (random(1) <= .8) {
          // to function normally: false
            cells[i][j].alive = false;
          } else {
            // to function normally: true
            cells[i][j].alive = true;
          }
        }
      }
    generationCount = 1;
    }
  }
}

// this is where all of my graphics functions are

void graphics() {
  // side menu box
  fill(45);
  strokeWeight(5);
  stroke(30);
  // extra numbers are for correct alignment and to ensure the edges are offscreen
  rect(xysize + 2, 0 - 10, 200 + 10, height + 20);
  
  // fps, generation, etc
  //liveData();
  // buttons
  pauseButton();
  clearButton();
  resetButton();
}

void liveData() {
  fill(255);
  // Shows the generation count
  text("Generation: " + generationCount, width - 180, 40);
  // Shows the live framerate
  text("Framerate:  " + nf(frameRate, 1, 2), width - 180, 60);
}

// Visuals for the Clear Button.
void clearButton() {
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(813, 675, 85, 35);
  fill(0, 200);
  text("Clear", 832, 698);
}

// Visuals for the Reset Button.
void resetButton() {
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(908, 675, 85, 35);
  fill(0, 200);
  text("Restart", 917, 698);
}

// Visuals for the Pause Button.
void pauseButton() {
  if (pause) {
    fill(0, 210, 255);
    stroke(0);
    strokeWeight(1);
    rect(853, 720, 100, 35);
    fill(0, 200);
    text("Paused", 874, 742);
  } else {
    fill(80, 255, 255);
    stroke(0);
    strokeWeight(1);
    rect(853, 720, 100, 35);
    fill(0, 200);
    text("Running", 870, 742);
  }
}