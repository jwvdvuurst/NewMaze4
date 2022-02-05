class Coin extends GameObject {
    public Coin( mazeMap m ) {
    super(m, objectType.coin);
    m.getCell(getX(), getY()).setObject(this);
  }

  public void action( person p ) {
    if (p.getType() == objectType.player) {
       p.addScore(1);
       map.getCell(getX(), getY()).clearType();
       map.getCell(getX(), getY()).clearObject();
       markForDeletion();
    }
  }

  public void draw( PApplet p, int sx, int sy, int cw, int ch ) {
    // divide the square up into 25 (5x5) little squares
    //  c0  c1  c2  c3  c4
    // +---+---+---+---+---+
    // | 0 | 1 | 2 | 3 | 4 | r0
    // +---+---+---+---+---+ 
    // | 5 | 6 | 7 | 8 | 9 | r1
    // +---+---+---+---+---+ 
    // |10 |11 |12 |13 |14 | r2
    // +---+---+---+---+---+ 
    // |15 |16 |17 |18 |19 | r3
    // +---+---+---+---+---+ 
    // |20 |21 |22 |23 |24 | r4
    // +---+---+---+---+---+
    //
    // Squares 7, 11,12,13 and 17 need to be colored red

    float dw=cw/5;
    float dh=ch/5;

    p.fill(255, 255, 0);

    p.rect(sx+(2*dw), sy+(0*dh), dw, dh);  //square 2
    p.rect(sx+(1*dw), sy+(1*dh), dw, dh);  //square 6
    p.rect(sx+(3*dw), sy+(1*dh), dw, dh);  //square 8    
    p.rect(sx+(0*dw), sy+(2*dh), dw, dh);  //square 10    
    p.rect(sx+(4*dw), sy+(2*dh), dw, dh);  //square 14
    p.rect(sx+(1*dw), sy+(3*dh), dw, dh);  //square 16
    p.rect(sx+(3*dw), sy+(3*dh), dw, dh);  //square 18    
    p.rect(sx+(2*dw), sy+(4*dh), dw, dh);  //square 22
    
    p.stroke(0);
    p.fill(0);
  }
}
