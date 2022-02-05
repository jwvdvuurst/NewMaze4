
int l = 1;

Level level;


void createLevel( int l, int score, int health, int power ) {
  int w = (l*5)+10;
  int h = (l*5)+10;

  println("== new level will be "+w+" x "+h+" cells big ==");
  level=new Level(this, l, w,h,score,health,power);
  
  println("== created ==");
}

void setup() {
  fullScreen();
  
  createLevel(l, 0, 0, 0);
}
  
void draw() {
  if (level.draw()) {
    int score = level.getScore();
    int health = level.getHealth();
    int power = level.getPower();
    println("== creating new level "+l+" ==");
    l++;
    createLevel(l, score, health, power);
  }
}
   
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      level.up();
    }
    if (keyCode == RIGHT) {
      level.right();
    }
    if (keyCode == DOWN) {
      level.down();
    }
    if (keyCode == LEFT) {
      level.left();
    }
  } else {
    if (key == ' ') {
      level.zap();
    }
  }
  
  println( "Keypressed ",keyCode," : [",level.getX(),",",level.getY(),"] " );
}  
