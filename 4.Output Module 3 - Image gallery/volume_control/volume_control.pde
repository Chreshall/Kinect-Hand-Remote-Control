import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
import processing.sound.*;
import processing.video.*;

int playerBarHeight, playerBarWidth;

Kinect kinect;
ArrayList <SkeletonData> bodies;


void setup()
{
  //Sujoy's setup code start
  
  size(1366, 768);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    textSize(28);
    imgXNext = width / 2 - 10;
    imgXPrev = width / 2 - 50;
    imgXPlay = width / 2 + 30;
    imgYPlay=imgYPrev=imgYNext = height - 100;
    imgHPlay=imgWPlay=imgHNext=imgHPrev=imgWPrev=imgWNext = 30;
  //Sujoy's setup code end
  
  background(0);
  kinect = new Kinect(this);
  smooth();
  bodies = new ArrayList<SkeletonData>();
}
 

void draw()
{
  //Sujoy's draw code start
  int len = files.length;
    img = new PImage[len];
    counter = 0;
    for (int i = 0; i <= len - 1; i++) {
        String path = files[i].getAbsolutePath();
        if (path.toLowerCase().endsWith(".png") || path.toLowerCase().endsWith(".jpg") || path.toLowerCase().endsWith(".jpeg") || path.toLowerCase().endsWith(".gif")) {
            img[counter++] = loadImage(path);
        }
    }
    if (img.length != 0 && isSlideShow==0) {
        drawImage();
    }
  
  //Sujoy's draw code end
    
  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
     //Jasmeet's integration to run it with kinect
    overEvent(bodies.get(i));
  }
  
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
