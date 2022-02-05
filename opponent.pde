class opponent extends person {

  boolean zap;

  public opponent( mazeMap m ) {
    super(m, objectType.opponent);
    zap = false;
    m.getCell(getX(), getY()).setObject(this);
  }

  public void move( int playx, int playy ) {
    int t = round(random(10));
    int count = 3;
    boolean moveOk = false;
    
    int ox = getX();
    int oy = getY();
    int nx = ox;
    int ny = oy;

    while ( (count > 0) && !moveOk ) {
      nx = ox;
      ny = oy;

      if (t%2 == 0) {
        int dx = playx - nx;
        int dy = playy - ny;
        int dist2 = dx*dx + dy*dy;

        if (dist2 < 400) {
          if (abs(dx) > abs(dy)) {
            if ((dx < 0) && map.isOpen(nx-1, ny)) nx--;
            if ((dx > 0) && map.isOpen(nx+1, ny)) nx++;
          } else {
            if ((dy < 0) && map.isOpen(nx, ny-1)) ny--;
            if ((dy > 0) && map.isOpen(nx, ny+1)) ny++;
          }
        }
      } else {
        int d = round(random(4));

        switch(d) {
        case 0: 
          if (map.isOpen(nx-1, ny)) nx--; 
          break;
        case 1: 
          if (map.isOpen(nx+1, ny)) nx++; 
          break;
        case 2: 
          if (map.isOpen(nx, ny-1)) ny--; 
          break;
        case 3: 
          if (map.isOpen(nx, ny+1)) ny++; 
          break;
        }
      }
      
      if ((nx != ox) || (ny != oy)) {
        if (map.isActive(nx,ny)) {
          objectType ot = map.getType(nx,ny);
          
          switch(ot) {
            case empty:
               moveOk = true;
               break;
            case object:
               boolean use = (random(100) > 75.0);            
               if (use) {
                 moveOk = true;
                 GameObject o = map.getObject(nx,ny);
                 o.action(this);
               }
               break;
            case opponent: break;
            case player:   break;
          }                   
        } else {
          moveOk = true;
        }
      }
      
      if (!moveOk) count--;  
    }

    if (moveOk) {
      map.getCell(ox, oy).clearObject();
      map.resetCellActive(ox, oy);
      setCoordinates(nx, ny);
      map.setCellActive(nx, ny, objectType.opponent);
      map.getCell(nx, ny).setObject(this);
    }
  }

  public void action( person p ) {
    p.downHealth(5);
  }

  public void zapped() {
    zap = true;
    downHealth(20);
  }

  public void draw( PApplet p, int sx, int sy, int cw, int ch ) {
    if (zap) {
      p.fill(255, 255, 255);
      zap = false;
    } else {
      if (health >= 100) {
        p.fill(255, 0, 0);
      } else {
        p.fill(255, round((100-health)*2.55), 0);
      }
    }

    if (health == 0) {
      markForDeletion();
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
}
