class player extends person {

  public player( mazeMap m ) {
    super(m, objectType.player);
  }
  
  public player( mazeMap m, int score, int health, int power ) {
    super(m, objectType.player);
    addScore(score);
    upHealth(health);
    PowerUp(power);
  }  

  public void draw( PApplet p, int sx, int sy, int cw, int ch ) {
    if (health >= 100) {
      p.fill(0, 0, 255);
    } else {
      p.fill(0, round((100-health)*2.55), 255);
    }

    int hcw = (cw / 2);
    int hch = (ch / 2);
    int radius = hcw;
    if (hch < radius) radius = hch;

    int tsx = sx + hcw;
    int tsy = sy + hch;

    p.circle(tsx, tsy, radius);
    p.fill(0);
  }

  private void moveTo(int oldx, int oldy, int newx, int newy) {
    boolean moveok = true;

    if ((newx >= 0) && (map.isOpen(newx, newy))) {
      if (map.isActive(newx, newy)) {
        switch(map.getType(newx, newy)) {
        case empty: 
          moveok = true; 
          break;
        case player: 
          println("invalid, there can be only one!"); 
          break;
        case opponent: 
          println("blocked by opponent");
          //map.getObject(newx, newy).action(this);
          moveok = false;
          break;
        case object: 
          println("== object ==");
          map.getObject(newx, newy).action(this);
          moveok = true; 
          break;
        case coin:
          println("== coin ==");
          map.getObject(newx, newy).action(this);
          moveok = true; 
          break;    
        case finish:
          println("== finish =="); 
          map.getObject(newx, newy).action(this);
          moveok = true;
          break;
        default:     
          moveok = true; 
          break;
        }
      }
    } else {
      moveok = false;
    }

    if (moveok) {
      map.getCell(oldx, oldy).clearObject();
      map.resetCellActive(oldx, oldy);
      map.setCellActive(newx, newy, objectType.player);
      setCoordinates(newx, newy);
      map.getCell(newx, newy).setObject(this);
    }
  }

  public void left() {
    int oldx = getX();
    int oldy = getY();
    int newx = oldx - 1;
    int newy = oldy;

    moveTo(oldx, oldy, newx, newy);
  }

  public void right() {
    int oldx = getX();
    int oldy = getY();
    int newx = oldx + 1;
    int newy = oldy;

    moveTo(oldx, oldy, newx, newy);
  }

  public void up() {
    int oldx = getX();
    int oldy = getY();
    int newx = oldx;
    int newy = oldy - 1;

    moveTo(oldx, oldy, newx, newy);
  }

  public void down() {
    int oldx = getX();
    int oldy = getY();
    int newx = oldx;
    int newy = oldy + 1;

    moveTo(oldx, oldy, newx, newy);
  }

  public void zap() {
    if (power > 0) {
      power--;

      int sx = getX();
      int sy = getY();
      int nr = 0;

      for ( int x = 0; x < 4; x++ ) {
        for ( int y = 0; y < 4; y++ ) {
          int ox = sx+x-2;
          int oy = sy+y-2;
          GameObject g = map.getCell(ox, oy).getObject();
          if (g != null) {
            objectType t = g.getType();
            if (t == objectType.opponent) {
              opponent o = (opponent)g;
              o.zapped();
              nr++;
            }
          }
        }
      }

      println( "Nr of opponents zapped: ", nr );
    }
  }
  
  public int getScore() {
    return score;
  }
  
  public int getHealth() {
    return health;
  }
  
  public int getPower() {
    return power;
  }
}
