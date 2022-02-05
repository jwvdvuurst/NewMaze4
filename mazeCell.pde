class mazeCell {
  
  private boolean cellOpen = false;
  private boolean cellActive = false;
  private objectType type = objectType.empty;
  private GameObject object = null;
  
  public mazeCell( boolean open ) {
    cellOpen = open;
  } 
  
  public void setOpen() {
    cellOpen = true;
  }
  
  public boolean isOpen() {
    return cellOpen;
  }
  
  public void setActive( objectType t ) {
    type = t;
    
    if (type != objectType.empty) {
       cellActive = true;
    } else {
      cellActive = false;
    } 
  }
  
  public void resetActive() {
    cellActive = false;
    type = objectType.empty;
  }
  
  public boolean isActive() {
    return cellActive;
  }
  
  public boolean isPlayer() {
    return cellActive && (type == objectType.player);
  }
  
  public objectType getType() {
    return type;
  }
  
  public void setType( objectType t ) {
    type = t;
  }
  
  public void clearType() {
    setType(objectType.empty);
  }
  
  public GameObject getObject() {
    return object;
  }
  
  public void setObject( GameObject o ) {
    object = o;
  }
  
  public void clearObject() {
    object = null;
  }
}
    
