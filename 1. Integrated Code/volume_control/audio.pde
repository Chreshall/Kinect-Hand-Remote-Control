import processing.sound.*;

SoundFile dreams;
int audHeight = 768;
void setupAud(){
    //bg = loadImage("bgmusic.jpg");
  playImage = loadImage("play-button.png");
  audForward = loadImage("audFwd.png");
  audBackward = loadImage("audBack.png");

  //noStroke();  
  dreams = new SoundFile(this, "dreams.mp3");
  
  dreams.play();
    
  vs1 = new slider(width/4, audHeight/2, 16, int(audHeight/5), 50, 5);
  vs2 = new slider(width/2, audHeight/2, 16, int(audHeight/5), 50, 5);
  
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

void drawAud(){
  image(kinect.GetImage(), width-width/4, 0, width/4, audHeight/3);
  image(kinect.GetMask(), width-width/4, audHeight/3, width/4, audHeight/3);
  image(kinect.GetDepth(), width-width/4-3, audHeight-audHeight/3, width/4+3, audHeight/3);
  noStroke();
  addButtons();
  image(audBackward, playerBarWidth/2-75, audHeight-playerBarHeight/2-15, 30, 30);
  image(playImage, playerBarWidth/2-15, audHeight-playerBarHeight/2-15, 30, 30);
  image(audForward, playerBarWidth/2+45, audHeight-playerBarHeight/2-15, 30, 30);
}

slider vs1, vs2;

void musicPlay(SkeletonData _s) {
  textSize(20);
  fill(#721818);
  text("Volume", width/4 - 35, audHeight/2 - 15);
  text("Speed", width/2 - 30, audHeight/2 - 15);
    
  float vs1Val = map(vs1.getPos(), vs1.getMax(), vs1.getMin(), 0, 1.0);
  float vs2Val = map(vs2.getPos(), vs2.getMax(), vs2.getMin(), 0.5, 1.5);
  
  dreams.amp(vs1Val);
  dreams.rate(vs2Val);
  
  vs1.update(_s);
  vs2.update(_s);
  vs1.display();
  vs2.display();
}
