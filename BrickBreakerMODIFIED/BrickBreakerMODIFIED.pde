//Brick breaker game made by Raghu Vaidyanathan and modified by Ali Shazal
//for the course A.rt I.ntel offered by the IM Department at NYU Abu Dhabi.

//Instructions:
//Use wekinator with 3 gesture DTW input.
//Move the paddle with your hands.
//If the ball travels to the bottom of the screen, a life is lost.
//At the end of the game, the final score, as well as the highest 
//streak of bricks hit without the ball touching the paddle will be recorded.

//Necessary for OSC communication with Wekinator:
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;

//Initializers
int rows = 6; //Number of bricks per row
int columns = 6; //Number of columns
int total = rows * columns; //Total number of bricks
int score = 0; //How many bricks have been hit by the player
int gameScore = 0; //The player's score which displays on the screen.
int streak = 0;  //How many bricks in a row the player has hit without the ball touching the paddle or using a missile.
int maxStreak = 0; //Max streak in any given round
int lives = 5; //lives


Paddle paddle2 = new Paddle(); //initialize paddle 
Ball ball2 = new Ball(); //initialize ball 
Brick[] box = new Brick[total]; //Initialize the array that will hold all the bricks

void setup()
{
  //Initialize OSC communication
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  
  size(600, 600);
  background(0);
  smooth();

  //Setup array of all bricks on screen
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      box[i*rows + j] = new Brick((i+1) *width/(rows + 2), (j+1) * 50); //places all the bricks into the array, properly labelled.
    }
  }
}
  

void draw()
{
  background(0);

  //Draw bricks from the array of bricks
  for (int i = 0; i<total; i++)
  {
    box[i].update();
  }

  //Draw paddle and ball
  paddle2.update();
  ball2.update();


  //BALL AND PADDLE/WALL INTERACTIONS
  //If the ball hits the paddle, it goes the other direction
  //If the ball hits the left of the paddle, it goes to the left
  //If the ball hits the right of the paddle, it goes to the right

  //Ball hits left side of paddle
  if (ball2.y == paddle2.y && ball2.x > paddle2.x && ball2.x <= paddle2.x + (paddle2.w / 2) )
  {
    ball2.goLeft();
    ball2.changeY();
    streak = 0; //Streak ends
  }

  //Ball hits right side of paddle
  if (ball2.y == paddle2.y && ball2.x > paddle2.x + (paddle2.w/2) && ball2.x <= paddle2.x + paddle2.w )
  {
    ball2.goRight();
    ball2.changeY();
    streak = 0; //streak ends
  }

  //If the ball hits the RIGHT wall, go in same y direction, but go left  
  if (ball2.x + ball2.D / 2 >= width)
  {
    ball2.goLeft();
  }

  //If the ball hits the LEFT wall, go in same y direction, but go right
  if (ball2.x - ball2.D / 2 <= 0)
  {
    ball2.goRight();
  }

  //If the ball hits the ceiling, go down in a different direction
  if (ball2.y - ball2.D / 2 <= 0)
  {
    ball2.changeY();
  }


  //BALL,  BRICK, and MISSILE INTERACTIONS

  for (int i = 0; i < total; i ++)
  {
    //If ball hits bottom of brick, ball moves down, increment score
    if (ball2.y - ball2. D / 2 <= box[i].y + box[i].h &&  ball2.y - ball2.D/2 >= box[i].y && ball2.x >= box[i].x && ball2.x <= box[i].x + box[i].w  && box[i].hit == false )
    {
      ball2.changeY();
      box[i].gotHit();
      score += 1;
      gameScore += 10;
      streak += 1;

      //Calculate the maximum streak to display final score at end.
      if (streak>maxStreak)
      {
        maxStreak = streak;
      }
    } 

    //If ball hits top of brick ball moves up, increment score
    if (ball2.y + ball2.D / 2 >= box[i].y && ball2.y - ball2.D /2 <= box[i].y + box[i].h/2 && ball2.x >= box[i].x && ball2.x <= box[i].x + box[i].w && box[i].hit == false ) 
    {
      ball2.changeY();
      box[i].gotHit();
      score += 1;
      gameScore += 10;
      streak += 1;

      //Calculate the maximum streak to display final score at end.
      if (streak>maxStreak)
      {
        maxStreak = streak;
      }
    }

    //if ball hits the left of the brick, ball switches to the right, and moves in same direction, increment score
    if (ball2.x + ball2.D / 2 >= box[i].x && ball2.x + ball2.D / 2 <= box[i].x + box[i].w / 2 && ball2.y >= box[i].y && ball2.y <= box[i].y + box[i].h  && box[i].hit == false)
    {
      ball2.goLeft();
      box[i].gotHit();
      score += 1;
      gameScore += 10;
      streak += 1;

      //Calculate the maximum streak to display final score at end.
      if (streak>maxStreak)
      {
        maxStreak = streak;
      }
    }

    //if ball hits the right of the brick, ball switches to the left, and moves in same direction, increment score
    if (ball2.x - ball2.D/2 <= box[i].x + box[i].w && ball2.x +ball2.D / 2 >= box[i].x + box[i].w / 2 && ball2.y >= box[i].y && ball2.y <= box[i].y + box[i].h  && box[i].hit == false)
    {
      ball2.goRight();
      box[i].gotHit();
      score += 1;
      gameScore += 10;
      streak += 1;

      //Calculate the maximum streak to display final score at end.
      if (streak>maxStreak)
      {
        maxStreak = streak;
      }
    }
  }

  //If ball goes off the screen, reset the ball, and lose a life.
  if (ball2.y > height)
  {
    ball2.reset();
    paddle2.reset();
    lives -= 1;
  }


  //Displays score in top left corner!
  textSize(32);
  text(gameScore, 10, 30);

  //Displays lives in bottom left corner
  textSize(18);
  text("LIVES: ", 10, 570);
  text(lives, 70, 570); 

  //If the player wins/loses, he/she can click the mouse to restart the game.
  if ((score == total || lives <= 0) && mousePressed)
  {
    resetGame();
  } 


  //Once the score is equal to the total, bring up the "game over" screen.
  if (score == total)
  {
    gameWin();
  }

  //If no more lives are left, game ends
  if (lives <= 0)
  {
    gameLose();
  }
}

//Function that displays the game screen after the player loses.
void gameLose()
{
  //Says "Game over", displays score, max streak, and allows user to click screen to play again. 
  background(0);
  textSize(32);
  text("GAME OVER", 100, 200);
  text("Score: ", 100, 300);
  text(gameScore, 300, 300);
  text("Max Streak: ", 100, 400); 
  text(maxStreak, 300, 400);
  text("Click mouse to play again!", 100, 500);

  //The game is still technically playing when this screen is brought up, 
  //so these steps help to isolate the ball and missiles.
  ball2.x = -10;
  ball2.y = -10;
  ball2.vx = 0;
  ball2.vy = 0;
  
}

//Function that displays the gameOver screen
void gameWin()
{ 

  //Says "You win!", displays score, max streak, and allows user to click screen to play again. 
  background(0);
  textSize(32);
  text("YOU WIN!", 100, 200);
  text("Score: ", 100, 300);
  text(gameScore, 300, 300);
  text("Max Streak: ", 100, 400); 
  text(maxStreak, 300, 400);
  text("Click mouse to play again!", 100, 500);
  
  //The game is still technically playing when this screen is brought up, 
  //so these steps help to isolate the ball and missiles.
  ball2.x = -10;
  ball2.y = -10;
  ball2.vx = 0;
  ball2.vy = 0;

  //missile2.x = -20;
  //missile2.y = -20;
}


//Function that Resets the game
void resetGame()
{

  //Setup array of all bricks on screen
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j< columns; j++)
    {
      box[i*rows + j] = new Brick((i+1) *width/(rows + 2), (j+1) * 50);
    }

    //Reset all the score values
    score = 0;
    gameScore = 0;
    streak = 0;
    maxStreak = 0;
    lives = 5;
    
  }

  //Reset the ball as well
  ball2.reset();
}


//PADDLE CLASS
class Paddle
{
  float x; //paddle x
  float y; //padlle y
  float w; //paddle width
  float h; //paddle height
  float r; //paddle red val
  float g; //paddle green val
  float b; //paddle blue val

  //Paddle constructor
  Paddle()
  {
    x = (width/2)+200;
    y = 540;
    w = 100;
    h = 10;
    r=255;
    g=255;
    b=255;
  }

  void update()
  {
    //Draw paddle
    fill(r, g, b);
    rect(x, y, w, h);
  }
 
  void reset()
  {
    x = (width/2)-50;
    y = 540;
    w = 100;
    h = 10;
    r=255;
    g=255;
    b=255;
  }
}
  

//BALL CLASS
class Ball
{

  float x;  //ball x
  float y; //ball y
  float vx; //ball velocity in x
  float vy; //ball velocity in y 
  float D; //ball diameter

  //Ball constructor
  Ball()
  {
    x = 300;
    y = 400;
    vx = 0; //Initially, ball just falls straight down
    vy = 4; 
    D = 10;
  }

  //Update the ball
  void update()
  {
    noStroke();
    fill(255);
    ellipse(x, y, D, D);

    y += (vy*0.5); //increment y
    x += (vx*0.5); //increment x
  }

  //Ball goes left
  void goLeft()
  {
    vx = -4; //decrement x
  }

  //Ball goes right
  void goRight()
  {
    vx = 4; //increment x
  }

  //Ball changes in y direction
  void changeY()
  {
    vy *= -1; 
  }

  //If ball goes below paddle, reset
  void reset()
  {
    x = 300;
    y = 400;
    vx = 0;
    vy = 4;
  }
}


//BRICK CLASS
class Brick
{
  float x; //brick x
  float y; //brick y
  float w; //brick width
  float h; //brich height
  float r; //brick red val
  float g; //grick green val
  float b; //brick blue val

  boolean hit; //whether or not the brick has been hit


    Brick(float x0, float y0)
  {
    x = x0;
    y = y0;

    //pastel colors
    r = random(128, 255);
    g = random(128, 255);
    b = random(128, 255);
    w = 50; //brick width
    h = 25; //brick height

    hit = false; //brick is initially not hit
  }

  //Draws the brick
  void update()
  {
    noStroke();
    fill(r, g, b);
    rect(x, y, w, h);
  }

  //What happens to the brick once it gets hit
  void gotHit()
  {
    hit = true; //brick recognizes that it has been hit

    r = 0;
    g = 0;
    b = 0;
    rect(x, y, w, h);
  }
}

void oscEvent(OscMessage theOscMessage) {
 if (theOscMessage.checkAddrPattern("/output_1")==true) {
   paddle2.x-=90;
 } else if (theOscMessage.checkAddrPattern("/output_2")==true) {
   paddle2.x+=90; }
 else if (theOscMessage.checkAddrPattern("/output_3")==true) {
   resetGame();
 } else {
   paddle2.x = paddle2.x;
    println(".");
 }
}