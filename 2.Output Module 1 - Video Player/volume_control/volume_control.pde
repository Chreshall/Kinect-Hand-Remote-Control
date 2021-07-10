import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import processing.sound.*;
import processing.video.*;

int playerBarHeight, playerBarWidth;


Kinect kinect;
ArrayList <SkeletonData> bodies;

void setup()
{
  
  //Chreshall's setup code start
    size(1280,720); //Window dimensions.
    background(0);
    
    //video
    //uncomment the below part to make it able to play your own files
    //selectInput("Select an Video (.mp4) File : ","fileSelected"); //Input of any movie file location
    delay(10000); // a 10 Seconds delay to select a movie file else gives a nullpointerException
    movie = new Movie(this, videoPath);
    
    //Remove this bottom line to make it free flow selection
    videoPath = "Circle of Love - Sound Design - Rudy Mancuso.mp4";
    movie = new Movie(this, videoPath);
    movie.loop();
  //Chreshall's setup code end
  //size(840, 480);
  
  background(0);
  kinect = new Kinect(this);
  smooth();
  bodies = new ArrayList<SkeletonData>();
  forward = loadImage("fast-forward.png");
  backward = loadImage("fast-backward.png");
  
}
 

void draw()
{
  //Chreshall's draw code start
  if (movie.available() == true) 
  {
    buttonInit();
    buttonBar();
  }
  
  
  //Chreshall's draw code end
  
  
  
  
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
    overEvent(bodies.get(i));
  }
  
  //addButtons();
  image(backward, playerBarWidth/2-75, height-playerBarHeight/2-15, 30, 30);
  //image(playImage, playerBarWidth/2-15, height-playerBarHeight/2-15, 30, 30);
  image(forward, playerBarWidth/2+45, height-playerBarHeight/2-15, 30, 30);
}


void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  
}

void drawSkeleton(SkeletonData _s) 
{
  // Left Arm
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
  Kinect.NUI_SKELETON_POSITION_HAND_LEFT);

  // Right Arm
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
  DrawBone(_s, 
  Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
  Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);

}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(#7a1819);
  
}

void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}
