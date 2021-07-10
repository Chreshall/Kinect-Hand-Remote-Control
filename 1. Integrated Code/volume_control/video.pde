boolean over;

//Mostly Psedo Code, Yet to be Refined

//1. window to select a vido file{ preferrred in mp4}
//2. Play the file
//3. For every frame check if the gesture function has been validated or not
//4. Make changes according to the gesture direction

Movie movie;
String videoPath = null;
PImage play,pause,forward,backward;
boolean playYes = true;
boolean forwardBackward = false;
boolean forBack = true;
boolean volumeCtrl = false;
boolean volumeUpDown = true;
float volume = 0.5;
int barY = 600;
int barXMid = 640 - 50;
int barXLeft = 640 - 200;
int barXRight = 640 + 100;

void setupVideo(){//Window dimensions.
    background(0);
    
    //video
    selectInput("Select an Video (.mp4) File : ","fileSelected"); //Input of any movie file location
    delay(10000); // a 10 Seconds delay to select a movie file else gives a nullpointerException
    movie = new Movie(this, videoPath);
    
    //Remove this later
    //videoPath = "Circle of Love - Sound Design - Rudy Mancuso.mp4";
    movie = new Movie(this, videoPath);
    movie.loop();
      forward = loadImage("fast-forward.png");
  backward = loadImage("fast-backward.png");

}

void drawVideo(){
  if (movie.available() == true) 
  {
    buttonInit();
    //fill(255);
    //text("use SPACEBAR or MOUSE CLICK to play/pause", 1000,30);
    //text("use RIGHT ARROW to Speed up", 1000,50);
    //text("use LEFT ARROW to Slow down", 1000,70);
    //int x= mouseX;
    //int y= mouseY;
    //text( x,1000, 90);
    //text( y,1000, 110);
    buttonBar();
  }
}

void fileSelected(File selection)
{
  videoPath = selection.getAbsolutePath();
}

void buttonInit()
{
  
  if(playYes)
  {
    play=loadImage("play.png");
    play.resize(50,50);
    movie.read();
    movie.play();
    movie.speed(1.0);
    image(movie,0,0,width,height);
    image(play, 50, 120);
    //text("Volume : "+ volume,width - 75, 75);
  }
  else
  {
    pause=loadImage("pause.png");
    pause.resize(50,50);
    movie.pause();
    image(movie,0,0,width,height);
    image(pause, 50, 120);
    //text("Volume : "+ volume,width - 75, 75);
  }
  if(forwardBackward)
  {
    if(forBack)
    {
      forward=loadImage("fast-forward.png");
      forward.resize(50,50);
      movie.read();
      movie.play();
      movie.speed(2.0);
      image(movie,0,0,width,height);
      image(forward, 50, 120);
      //text("Volume : "+ volume,width - 75, 75);
    }
    else
    {
      backward=loadImage("backward.png");
      backward.resize(50,50);
      movie.read();
      movie.play();
      movie.speed(0.5);
      image(movie,0,0,width,height);
      image(backward, 50, 120);
      //text("Volume : "+ volume,width - 75, 75);
    
    }
  }
  if(volumeCtrl)
  {
    if(volumeUpDown)
    {
      if(volume<1.0)
      {
        volume = volume + 0.1;
        movie.volume(volume);
        //text("Volume : "+ volume,width - 75, 75);
      }
    }
    else
    {
      if(volume>0.0)
      {
        volume = volume - 0.1;
        movie.volume(volume);
        //text("Volume : "+ volume,width - 75, 75);
      }
    }
  }
}

void overEventVideo(SkeletonData _s) {
    //Y-BAR all buttons 
    println(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2200);
    fill(255);
    ellipse(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2600,_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1442,50,50);
    if(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1442 > barY && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1442 < barY + 100)
    {
      //X-BAR
      //play pause
      if(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2600>barXMid && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2600<barXMid+100){
        println("Pause / Play");
        forwardBackward = false;
        playYes = !playYes;
      }
      //Slow Motion
      else if(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2600>barXLeft && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2600<barXLeft+100){
        println("Slow Motion");
        forwardBackward = true;
        forBack = false;
      }
      //Fast forward
      else if(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2600>barXRight && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2600<barXRight+100){
        println("Fast Forward");
        forwardBackward = true;
        forBack = true;
      }
      
  }
}

void buttonBar()
{
  fill(#49D295);
  if(playYes)
  {
    play=loadImage("play.png");
    play.resize(100,100);
    image(play, barXMid, barY);
    text("play",barXMid + 50, barY + 110);
  }
  else
  {
    pause=loadImage("pause.png");
    pause.resize(100,100);
    image(pause, barXMid, barY);
    text("pause",barXMid +50, barY + 110);
  }
  
  forward=loadImage("fast-forward.png");
  forward.resize(100,100);
  image(forward, barXRight, barY);
  text("Slow motion",barXLeft, barY + 110);
  
  backward=loadImage("backward.png");
  backward.resize(100,100);
  image(backward, barXLeft, barY);
  text("Fast Motion",barXRight, barY + 110); 
}
