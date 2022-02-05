class person extends GameObject {
  
  protected int health=100;
  protected int power=100;
  protected int score = 0;
    
  public person( mazeMap m, objectType t ) {
    super(m,t);  
  }
  
  public boolean isPlayer() {
    return (getType() == objectType.player);
  }
      
  public void upHealth( int value ) {
    health += value;
  }
  
  public void downHealth( int value ) {
    health -= value;
  }
  
  public void PowerUp( int value ) {
    power += value;
  }
  
  public void addScore( int value ) {
    score += value;
  }
}
