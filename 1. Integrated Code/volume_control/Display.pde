PImage pic1;
PImage pic2;
PImage pic3;

PImage video;
PImage music;
PImage imgDisp;



void setupDisplay() {
  background(0);  
  video= loadImage("v.jpeg");
  music = loadImage("m.jpeg");
  imgDisp = loadImage("im.jpeg");
 
 Firstpage();

}

void Firstpage()
{
 pic1 = loadImage("1.png");
 
  pic2 = loadImage("2.png");
  
  pic3 = loadImage("3.png");
  
 
  
   image(pic1,0,3.5*height/5, width/6, height/5);
  image(pic2,2.5*width/3,3.5*height/5, width/6, height/5);
  image(pic3,width/2.5,3.5*height/5,width/6,height/5);
  textSize(30);
  text("Which module you want to choose?",400,200);
  textSize(25);
  text("Click on the Green buttons to choose a module.",370,250);
  
  buttons();




}
//void backbutton()
//{
  
//  fill (#4CA091);
//  rect(width/2,height-40,80,40);9-
//  fill (255);
//  text("BACK ",width/1.78,height-20);
//  if(overbuttons(width/2, height-40, 80, 40))
//    {
//     Firstpage();
//    }
//}

void buttons()
{
    textSize(12);
    fill (#4CA091); 
    //rect(width/20-50,height/20-20,100,40);
    rect((width/2)-50,height-30,100,40);
    rect(width-100,height-30,100,40);
    rect(0,height-30,100,40);
   // rect(width/1.50,height/1.37,80,40);
    
    
    
    fill (255);
 
    text("MUSIC ",10,height-15);
    text("VIDEO ",width/2 - 35,height-15);
    text("IMAGE ",width - 78,height-15);
    //text("ORIGINAL",width/1.45,height/1.3);
    
    

}

boolean overbuttons(float x, float y, int width, int height)  {
  if ( mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height && mousePressed) {
    return true;
  } else {
    return false;
  }
}
