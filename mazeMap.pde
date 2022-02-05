class mazeMap {
  private ArrayList<mazeCell> cells;
  private int mazeWidth = 0;
  private int mazeHeight = 0;
  private PApplet mazeApp;
  private int cellWidth = 30;
  private int cellHeight = 30;
  private int counter=0;
  private PVector goal = null;
  private boolean finished = false;
  private int level;


  private player Plyr = null;
  //  private ArrayList<opponent> foes;
  private ArrayList<GameObject> objects;

  public mazeMap( PApplet app, int l, int w, int h ) {
    if (app == null) {
      println( "No PApplet reference passed" );
      app.exit();
    }
    mazeApp = app;
    level = l;

    if (( w > 0) && (h > 0)) {
      mazeWidth = w;
      mazeHeight = h;

      while (mazeWidth*cellWidth < mazeApp.width) {
        cellWidth++;
      }

      while (mazeHeight*cellHeight < mazeApp.height) {
        cellHeight++;
      }

      int size = mazeWidth * (mazeHeight+1);
      int n = 0;

      cells = new ArrayList<mazeCell>();

      for ( int i = 0; i < size; i++ ) {
        cells.add( new mazeCell(false) );
      }

      int px = (mazeWidth/2);
      int py = (mazeHeight/2);

      while ((px > 0) && (px < mazeWidth-1) &&
        (py > 0) && (py < mazeHeight-1) && (n < size/3)) {

        getCell(px, py).setOpen();  

        int nx = px;
        int ny = py;
        int tries = 0;

        while ((nx == px) && (ny == py) && (tries < 16)) {
          tries++;
          int t = round(random(12));

          switch(t) {
          case 0: 
            if ((ny-1 > 0) && !isOpen(nx, ny-1)) { 
              ny--;
            }; 
            break;
          case 1: 
            if ((nx+1 < mazeWidth) && !isOpen(nx+1, ny)) {
              nx++;
            }; 
            break;
          case 2: 
            if ((ny+1 < mazeHeight) && !isOpen(nx, ny+1)) {
              ny++;
            }; 
            break;
          case 3: 
            if ((nx-1 > 0) && !isOpen(nx-1, ny)) {
              nx--;
            }; 
            break;
          case 4: 
            if (ny-1 == 0) { 
              ny--;
            }; 
            break;
          case 5: 
            if (nx+1 == mazeWidth) {
              nx++;
            }; 
            break;
          case 6: 
            if (ny+1 == mazeHeight) { 
              ny++;
            }; 
            break;
          case 7: 
            if (nx-1 == 0) { 
              nx--;
            }; 
            break;
          case 8: 
            if (ny-1 > 0) { 
              ny--;
            }; 
            break;
          case 9: 
            if (nx+1 < mazeWidth) {
              nx++;
            }; 
            break;
          case 10: 
            if (ny+1 < mazeHeight) {
              ny++;
            }; 
            break;
          case 11: 
            if (nx-1 > 0) {
              nx--;
            }; 
            break;
          }
        }

        if (tries < 16) {
          px = nx;
          py = ny;
        } else {
          int t = round(random(4));

          if (t%2 == 0) {
            px += (round(random(6))-3);
          } else {
            py += (round(random(6))-3);
          }
        }
        n++;

        //println("step ", n, " [", px, ",", py, "] ");
      }
      
      goal = new PVector(px,py);

      //      foes = new ArrayList<opponent>();
      objects = new ArrayList<GameObject>();

      return;
    }

    println( "wrong dimensions given ", w, " and ", h );
    app.exit();
  }

  public mazeCell getCell( int x, int y ) {
    int idx = (y * mazeWidth) + x;

    return cells.get(idx);
  }

  public PApplet getApplet() {
    return mazeApp;
  }

  public void createPlayer() {
    if (Plyr == null) {
      Plyr = new player(this);
    }
  }
  
  public void createPlayer( int score, int health, int power ) {
    if (Plyr == null) {
      Plyr = new player(this, score, health, power);
    }
  }  

  public void addFoe() {
    opponent o = new opponent(this);
    objects.add(o);
  }

  public void addObject() {
    if ( round(random(10)) < 5 ) {
      objects.add( new HealthBox(this) );
    } else {
      objects.add( new PowerUp(this) );
    }
  }

  public void addCoin() {
    objects.add( new Coin(this) );
  }
  
  public PVector getGoal() {
    return goal;
  }
  
  public void setGoal() {
    objects.add(new Finish(this));
  }
  
  public void finished() {
    this.finished = true;
  }
  
  public boolean isFinished() {
    return this.finished;
  }

  public void prune() {
    ArrayList<GameObject> removes = new ArrayList<GameObject>();
    for ( GameObject o : objects ) {
      if (o.canBeDeleted()) {
        removes.add(o);
      }
    }

    for ( GameObject o : removes ) {
      getCell(o.getX(), o.getY()).clearObject();
      getCell(o.getX(), o.getY()).resetActive();
      objects.remove(o);
    }
  }

  public void createMaze() {
  }

  public void draw() {
    int cx = Plyr.getX();
    int cy = Plyr.getY();    
    int halfx  = (mazeApp.width / (cellWidth*2));
    int halfy  = (mazeApp.height / (cellHeight * 2));
    int startx = cx - halfx;
    int stopx  = cx + halfx;
    int starty = cy - halfy;
    int stopy  = cy + halfy;

    if (startx < 0) { 
      stopx += -startx; 
      startx = 0;
    }
    if (starty < 0) { 
      stopy += -starty; 
      starty = 0;
    }
    if (stopx  > mazeWidth) { 
      startx -= (stopx - mazeWidth); 
      stopx = mazeWidth;
    }
    if (stopy  > mazeHeight) { 
      starty -= (stopy - mazeHeight); 
      stopy = mazeHeight;
    }

    mazeApp.background(255);
    mazeApp.stroke(0);
    mazeApp.fill(0);

    for ( int y = starty; y < stopy; y++ ) {
      for ( int x = startx; x < stopx; x++ ) {
        int idx = y*mazeWidth + x;
        int sx  = (x - startx) * cellWidth;
        int sy  = (y - starty) * cellHeight;

        if (!cells.get(idx).isOpen()) {
          mazeApp.rect(sx, sy, cellWidth, cellHeight);
        } else {
          if (cells.get(idx).isActive()) {
            switch(cells.get(idx).getType()) {
            case empty: 
              break;
            case player: 
              Plyr.draw(mazeApp, sx, sy, cellWidth, cellHeight); 
              break;
            case opponent: //fall-through
            case object:
            case coin:
            case finish:
              for ( GameObject o : objects ) {
                if (o.isThis(x, y)) {
                  o.draw(mazeApp, sx, sy, cellWidth, cellHeight);
                }
              }
              break;
            }
          }
        }
      }
    }

    mazeApp.fill(0, 0, 255);
    mazeApp.textSize(32);
    mazeApp.text("Level "+level+" H "+Plyr.health+" P "+Plyr.power+" Score: "+Plyr.score, 40, 40 );    
  }

  public int width() {
    return mazeWidth;
  }

  public int height() {
    return mazeHeight;
  }

  public int radius() {
    return round(sqrt(cellWidth*cellWidth + cellHeight*cellHeight));
  }

  public void setCellActive( int x, int y, objectType t ) {
    int idx = (y * mazeWidth) + x;

    cells.get(idx).setActive(t);
  }

  public void resetCellActive( int x, int y ) {
    int idx = (y * mazeWidth) + x;

    cells.get(idx).resetActive();
  }

  public boolean isActive( int x, int y ) {
    int idx = (y * mazeWidth) + x;

    return cells.get(idx).isActive();
  }

  public boolean isOpen( int x, int y ) {
    int idx = (y * mazeWidth) + x;

    if ((idx < 0) || (idx > cells.size())) return false;

    if (idx < cells.size()) {
      return cells.get(idx).isOpen();
    } else {
      return false;
    }
  }

  public boolean isPlayer( int x, int y ) {
    int idx = (y * mazeWidth) + x;

    return cells.get(idx).isPlayer();
  }

  public objectType getType( int x, int y ) {
    int idx = (y * mazeWidth) + x;

    return cells.get(idx).getType();
  }

  public GameObject getObject( int x, int y ) {
    for ( GameObject o : objects ) {
      if (o.isThis(x, y)) {
        return o;
      }
    }
    return new GameObject(this, objectType.empty);
  }

  public void move() {
    counter++;

    if (counter % 10 == 0) {
      for ( GameObject o : objects ) {
        o.move( Plyr.getX(), Plyr.getY() );
      }

      counter=0;
    }

    prune();
  }

  public void left() {
    Plyr.left();
  }

  public void up() {
    Plyr.up();
  }

  public void right() {
    Plyr.right();
  }

  public void down() {
    Plyr.down();
  }

  public int getX() {
    return Plyr.getX();
  }

  public int getY() {
    return Plyr.getY();
  }

  public void zap() {
    Plyr.zap();
  }
  
  public int getScore() {
    return Plyr.getScore();
  }
  
  public int getHealth() {
    return Plyr.getHealth();
  }
  
  public int getPower() {
    return Plyr.getPower();
  }
}
