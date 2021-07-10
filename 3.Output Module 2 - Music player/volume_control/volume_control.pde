import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import beads.*;

AudioContext ac,ac1;
WavePlayer wp;
Gain g;
Glide gainGlide;
Glide freqGlide;
PImage playImage, forward, backward;
PowerSpectrum ps;

int playerBarHeight, playerBarWidth;


Kinect kinect;
ArrayList <SkeletonData> bodies;

//Test t = new Test(580, 20, 40, 20);

void setup()
{
  size(840, 480);
  background(0);
  kinect = new Kinect(this);
  smooth();
  bodies = new ArrayList<SkeletonData>();
  //bg = loadImage("bgmusic.jpg");
  playImage = loadImage("play-button.png");
  forward = loadImage("fast-forward.png");
  backward = loadImage("fast-backward.png");
  //noStroke();  
  dreams = new SoundFile(this, "dreams.mp3");
  
  dreams.play();
    
  vs1 = new slider(width/4, height/2, 16, int(height/5), 50, 5);
  vs2 = new slider(width/2, height/2, 16, int(height/5), 50, 5);
  
  ac1 = new AudioContext();
  //selectInput("Select an audio file:", "fileSelected");

  freqGlide = new Glide(ac1, 0, 500);
  wp = new WavePlayer(ac1,freqGlide, Buffer.SINE); //ac, freq, pattern
  
  gainGlide = new Glide(ac1, 0, 1); //ac, initial value, transition time
  g = new Gain (ac1,1,gainGlide);//ac, inputs, value
  g.addInput(wp);
  
  
  ac1.out.addInput(g);
  ac1.start();
}
 

void draw()
{
  background(0);
  image(kinect.GetImage(), width-width/4, 0, width/4, height/3);
  image(kinect.GetMask(), width-width/4, height/3, width/4, height/3);
  image(kinect.GetDepth(), width-width/4-3, height-height/3, width/4+3, height/3);
  noStroke();
  
  
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
    musicPlay(bodies.get(i));
  }
  
  addButtons();
  image(backward, playerBarWidth/2-75, height-playerBarHeight/2-15, 30, 30);
  image(playImage, playerBarWidth/2-15, height-playerBarHeight/2-15, 30, 30);
  image(forward, playerBarWidth/2+45, height-playerBarHeight/2-15, 30, 30);
}


void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  //String s1 = str(_s.dwTrackingID);
  //text(s1, _s.position.x*width, _s.position.y*height);
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
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width, 
    _s.skeletonPositions[_j1].y*height, 
    _s.skeletonPositions[_j2].x*width, 
    _s.skeletonPositions[_j2].y*height);
  }
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
