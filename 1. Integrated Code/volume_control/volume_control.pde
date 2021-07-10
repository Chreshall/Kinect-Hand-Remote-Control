import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import beads.*;
import processing.sound.*;
import processing.video.*;

AudioContext ac,ac1;
WavePlayer wp;
Gain g;
Glide gainGlide;
Glide freqGlide;
PImage playImage, audForward, audBackward;;
PowerSpectrum ps;
int active = 0;

int playerBarHeight, playerBarWidth;


Kinect kinect;
ArrayList <SkeletonData> bodies;

//Test t = new Test(580, 20, 40, 20);

void setup()
{
  size(1366, 800);
  setupDisplay();

  kinect = new Kinect(this);
  smooth();
  bodies = new ArrayList<SkeletonData>();

}
 

void draw()
{
  if(overbuttons(0, height-30, 100, 40) || active == 1)
  {
    clear();
    if(active != 1){
      setupAud();
      active=1;
    }
   //image(music,width/6,height/5, width/1.5, height/2);
   //backbutton();
    drawAud();
   buttons();
   
  }

 if(overbuttons((width/2)-50,height-30,100,40) || active == 2)
  {
    //clear();
    if(active != 2){
      setupVideo();
      active=2;
    }
   
   //image(video,width/6,height/5, width/1.5, height/2);
   
   drawVideo();
   //backbutton();
  buttons();
  }
   
   
  if(overbuttons(width - 100,height-30,100,40) || active == 3)
  {
    if(active != 3){
      setupImage();
      active=3;
    }
   clear();  
   background(0);
   //image(imgDisp,width/6,height/5, width/1.5, height/2);
   drawImg();
   //backbutton();
   buttons();
  }
  

  
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
     //Jasmeet's integration to run it with kinect
    if(active==1)
      musicPlay(bodies.get(i));
    if(active==3)
      overEventImage(bodies.get(i));
    if(active==2)
    overEventVideo(bodies.get(i));
  }
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
  //if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
  //  _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
  //  line(_s.skeletonPositions[_j1].x*width*2, 
  //  _s.skeletonPositions[_j1].y*audHeight*2, 
  //  _s.skeletonPositions[_j2].x*width*2, 
  //  _s.skeletonPositions[_j2].y*audHeight*2);
  //}
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
