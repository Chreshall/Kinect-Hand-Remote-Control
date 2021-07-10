import java.io.File; //<>//
PImage[] img;
int pageNumber = 0;
int counter = 0;
int slideCount=0;
File dir = new File("F:\\UTS\\Spring 2019\\intm\\intergrated code - Copy\\volume_control\\data"); // change path to your local system where the file is stored
File[] files = dir.listFiles();
int isSlideShow=0;
int imgXNext, imgYNext, imgWNext, imgHNext;
int imgXPrev, imgYPrev, imgWPrev, imgHPrev;
int imgXPlay, imgYPlay, imgWPlay, imgHPlay;

void setupImage(){
    //textAlign(CENTER, CENTER);
    //fill(255, 0, 0);
    //textSize(28);
    imgXNext = width / 2 - 10;
    imgXPrev = width / 2 - 50;
    imgXPlay = width / 2 + 30;
    imgYPlay=imgYPrev=imgYNext = height - 100;
    imgHPlay=imgWPlay=imgHNext=imgHPrev=imgWPrev=imgWNext = 30;
}

void drawImg(){
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
}

void setInterval(String name,long time){
  intervals.put(name,new TimeoutThread(this,name,time,true));
}
void clearInterval(String name){
  TimeoutThread t = intervals.get(name);
  if(t != null){
    t.kill();
    t = null;
    intervals.put(name,null);
  }
}

HashMap<String,TimeoutThread> intervals = new HashMap<String,TimeoutThread>();

void drawImage() {
    background(255);
    image(loadImage("9.5-512.png"), imgXNext, imgYNext, imgWNext, imgHNext);
    image(loadImage("up_4_3_18_ui_enlarge_13-512.png"), imgXPrev, imgYPrev, imgWPrev, imgHPrev);
    image(loadImage("play.png"), imgXPlay, imgYPlay, imgWPlay, imgHPlay);
    int id = 0;
    for (int i = 4 * pageNumber; i < (4 * pageNumber) + 4; i++) {
        if (i < counter && img[i] != null) {
            int imgX = 0, imgY = 0, imgW = 670, imgH = 300;
            if (id == 1) {
                imgX = 690;
            }
            if (id == 2) {
                imgY = 310;
            }
            if (id == 3) {
                imgY = 310;
                imgX = 690;
            }
            id++;
            image(img[i], imgX, imgY, imgW, imgH);
        }
    }
}
void playSlide(){
  background(255);
  if (slideCount == counter){
    slideCount=0;
  }
  image(img[slideCount], 0, 0, 1366, 768);
  slideCount++;
}
void overEventImage(SkeletonData _s) {
    //if (mousePressed == true) {
      fill(0);
      ellipse(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775,_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538,20,20);
      float disXPlay = imgXPlay - _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775;
      float disYPlay = imgYPlay -  _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538;
        if (sqrt(sq(disXPlay) + sq(disYPlay)) < 30) {
            if (img.length != 0 ) {
              if(isSlideShow ==1){
                isSlideShow=0;
                clearInterval("playSlide");
              }else {
                isSlideShow=1;
                slideCount=0;
                setInterval("playSlide",3000);
              }
            }
        }
        float disXNext = imgXNext - _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775;
        float disYNext = imgYNext - _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538;
        if (sqrt(sq(disXNext) + sq(disYNext)) < 30) {
          isSlideShow=0;
            if (img.length != 0 && (pageNumber + 1) * 4 < counter) {
                pageNumber++;
                drawImage();
            }
        }
        float disXPrev = imgXPrev - _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775;
        float disYPrev = imgYPrev - _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538;
        if (sqrt(sq(disXPrev) + sq(disYPrev)) < 30) {
          isSlideShow=0;
            if (pageNumber > 0 && img.length != 0 ) {
                pageNumber--;
                drawImage();
            }
          }
          
         //if (_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 >= 0 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 <= 0+670 
         //&& _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 >= 0 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 <= 0+300) {
         //   newWindow window = new newWindow(img[pageNumber*4]);
         //   runSketch(new String[]{"newWindow"}, window);
         // }
         // else if (_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 >= 690 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 <= 690+670 
         // && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 >= 0 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 <= 0+300) {
         //   newWindow window = new newWindow(img[(pageNumber*4)+1]);
         //   runSketch(new String[]{"newWindow"}, window);
         // }
         // else if (_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 >= 0 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 <= 0+670 
         // && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 >= 310 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 <= 310+300) {
         //   newWindow window = new newWindow(img[(pageNumber*4)+2]);
         //   runSketch(new String[]{"newWindow"}, window);
         // }
         // else if (_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 >= 690 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 <= 690+670 
         // && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 >= 310 && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 <= 310+300) {
         //   newWindow window = new newWindow(img[(pageNumber*4)+3]);
         //   runSketch(new String[]{"newWindow"}, window);
         // }
        
    }
//}

/**
  Timer Implementation
*/
import java.lang.reflect.Method;
class TimeoutThread extends Thread{
  Method callback;
  long now,timeout;
  Object parent;
  boolean running;
  boolean loop;
 
  TimeoutThread(Object parent,String callbackName,long time,boolean repeat){
    this.parent = parent; 
    try{
      callback = parent.getClass().getMethod(callbackName);
    }catch(Exception e){
      e.printStackTrace();
    }
    if(callback != null){
      timeout = time;
      now = System.currentTimeMillis();
      running = true;  
      loop = repeat; 
      new Thread(this).start();
    }
  }
 
  public void run(){
    while(running){
      if(System.currentTimeMillis() - now >= timeout){
        try{
          callback.invoke(parent);
        }catch(Exception e){
          e.printStackTrace();
        }
        if(loop){
          now = System.currentTimeMillis();
        }else running = false;
      }
    }
  }
  void kill(){
    running = false;
  }
 
}

//class newWindow extends PApplet {
//   PImage images;
//   newWindow(PImage img) {
//    img.resize(1366,768);
//    images=img;
//  }
  
//  public void draw() {
//    background(255);
//    image(images, 0, 0, 1366, 768);
//  }
//}
