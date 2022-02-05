class GameObject {
  
  protected mazeMap map;
  private int gox;
  private int goy;
  private objectType type;
  private boolean delete;
  
  public GameObject( mazeMap m, objectType t ) {
    delete = false;
    map = m;
    type = t;
    
    boolean ok = false;
    
    while( !ok ) {
      int x = round(random(map.width()));
      int y = round(random(map.height()));
      
      if (map.isOpen(x, y) && !map.isActive(x, y)) {
        gox = x;
        goy = y;
        ok = true;
        
        map.setCellActive(x,y,t);
      }
    }
  }
  
  public GameObject( mazeMap m, objectType t, PVector p ) {
    delete = false;
    map = m;
    type = t;
    
    gox = round(p.x);
    goy = round(p.y);
    map.setCellActive(gox,goy,t);
  }
  
  public boolean isThis( int x, int y ) {
    return ((gox==x) && (goy==y));
  }

  public void move( int playx, int playy ) {
  }
    
  public int getX() {
    return gox;
  }
  
  public int getY() {
    return goy;
  }
  
  public PVector coordinates() {
    return new PVector(gox,goy);
  }
  
  public void setX( int x ) {
    gox = x;
  }
  
  public void setY( int y ) {
    goy = y;
  }
  
  public void setCoordinates( int x, int y ) {
    if ((x >= 0) && (x < map.width()) &&
        (y >= 0) && (y < map.height())) {
      setX(x);
      setY(y);
    }
  }
   
  public void draw( PApplet p, int sx, int sy, int cw, int ch ) {
    p.fill(128);
    p.rect(sx,sy,sx+cw,sy+ch);
    p.fill(0);
  }
  
  public void action( person p ) {    
  }
  
  public objectType getType() {
    return type;
  }
  
  public boolean canBeDeleted() {
    return delete;
  }
  
  public void markForDeletion() {
    delete = true;
  }
}
