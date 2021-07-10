class slider {
  int sWidth, sHeight;
  float xPos, yPos;
  float sPos, sNewPos;
  float sPosMin, sPosMax;
  int loose;
  boolean over;
  boolean locked;
  float ratio;
  
  slider (float x, float y, int w, int h, int s, int l) {
    sWidth = w;
    sHeight = h;
    xPos = x - sWidth/2;
    yPos = y;
    sPos = map(s, 0, 100, yPos + sHeight - sWidth, yPos);
    sNewPos = sPos;
    sPosMin = yPos;
    sPosMax = yPos + sHeight - sWidth;
    loose = l;
  }
  
  void update(SkeletonData _s) {
    if (overEvent(_s)) {
      over = true;
    } else {
      over = false;
    }
    
    if (_s.skeletonPositionTrackingState[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED && over) {
      locked = true;
    }
    
    else {
      locked = false;
    }
    
    if (locked) {
      sNewPos = constrain(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*500 - sWidth/2, sPosMin, sPosMax);
    }
    
    if (abs(sNewPos - sPos) > 1) {
      sPos = sPos + (sNewPos - sPos)/loose;
    }
  }
  
  float constrain(float val, float minVal, float maxVal) {
    return min(max(val, minVal), maxVal);
  }
  
  boolean overEvent(SkeletonData _s) {
    fill(255);
      ellipse(_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775,_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538,20,20);
    if (_s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 > yPos && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y*1538 < yPos + sHeight 
    && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 > xPos && _s.skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x*2775 < xPos + sWidth) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    //noStroke();
    stroke(0);
    fill(#721818);
    rect(xPos, yPos, sWidth, sHeight);
    if (over || locked) {
      fill(0);
    } else {
      fill(#b65859);
    }
    rect(xPos, sPos, sWidth, sWidth);
  }
  
  float getPos() {
    return sPos;
  }
  
  float getMax() {
    return sPosMax;  
  }
  
  float getMin() {
    return sPosMin;
  }
}
