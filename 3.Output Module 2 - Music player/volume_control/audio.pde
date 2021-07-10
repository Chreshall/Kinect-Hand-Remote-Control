import processing.sound.*;

SoundFile dreams;

slider vs1, vs2;

void musicPlay(SkeletonData _s) {
  textSize(20);
  fill(#721818);
  text("Volume", width/4 - 35, height/2 - 15);
  text("Speed", width/2 - 30, height/2 - 15);
    
  float vs1Val = map(vs1.getPos(), vs1.getMax(), vs1.getMin(), 0, 1.0);
  float vs2Val = map(vs2.getPos(), vs2.getMax(), vs2.getMin(), 0.5, 1.5);
  
  dreams.amp(vs1Val);
  dreams.rate(vs2Val);
  
  vs1.update(_s);
  vs2.update(_s);
  vs1.display();
  vs2.display();
}
