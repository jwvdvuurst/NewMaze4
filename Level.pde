class Level {
  private mazeMap map;

  private int numberOfFoes;
  private int numberOfObjects;
  private int numberOfCoins;
  private PApplet lvlApp;

  public Level( PApplet ap, int l, int w, int h, int score, int health, int power ) {
    lvlApp = ap;
    
    numberOfFoes = round((w*h)*0.001)+2;
    numberOfObjects = round((w*h)*0.0025)+4;
    numberOfCoins = round((w*h)*0.005);
    
    map = new mazeMap(lvlApp, l, w, h);
  
    map.createPlayer(score, health, power);
 
 
    map.setGoal();
  
    for( int i = 0; i < numberOfFoes; i++ ) {
      map.addFoe();
    }
  
    for( int i = 0; i < numberOfObjects; i++ ) {
      map.addObject();
    }
  
    for( int i = 0; i < numberOfCoins; i++ ) {
      map.addCoin();
    }  
  }
  
  public boolean draw() {
    map.draw();
    map.move();
  
    if (map.isFinished()) {
      println("You made it!");
      return true;
    } else {
      return false;
    }
  }
  
  public boolean isFinished() {
    return map.isFinished();
  }

  public void up() {
    map.up();
  }
  
  public void down() {
    map.down();
  }
  
  public void left() {
    map.left();
  }
  
  public void right() {
    map.right();
  }

  public void zap() {
    map.zap();
  }
  
  public int getX() {
    return map.getX();
  }
  
  public int getY() {
    return map.getY();
  }
  
  public int getScore() {
    return map.getScore();
  }
  
  public int getHealth() {
    return map.getHealth();
  }
  
  public int getPower() {
    return map.getPower();
  }
}
