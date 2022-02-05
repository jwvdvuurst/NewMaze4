class HealthBox extends GameObject {

  public HealthBox( mazeMap m ) {
    super(m, objectType.object);
    m.getCell(getX(), getY()).setObject(this);
  }

  public void action( person p ) {
    p.upHealth(10);
    map.getCell(getX(), getY()).clearType();
    map.getCell(getX(), getY()).clearObject();
    markForDeletion();
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

    p.fill(255);
    p.stroke(255, 0, 0);

    float dw=cw/5;
    float dh=ch/5;

    p.rect(sx, sy, cw, ch);

    p.fill(255, 0, 0);

    p.rect(sx+(2*dw), sy+dh, dw, dh);  //square 7
    p.rect(sx+dw, sy+(2*dh), 3*dw, dh); //squares 11,12,13
    p.rect(sx+(2*dw), sy+(3*dh), dw, dh); //square 17

    p.stroke(0);
    p.fill(0);
  }
}
