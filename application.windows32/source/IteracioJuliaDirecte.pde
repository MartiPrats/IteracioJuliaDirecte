PImage img, img0, imgMandelbrot;
PVector p,q,r, punt;
float k, kmin= 0.1;
int cursorX, cursorY, iteracionsAFer=50;
int mida, passos = 1;
boolean Mandel = false, itera = true, resDeRes = true, noCanvi = true, quadrat=false, eixos=false;

  
void setup(){
  size(1200,600);
  noCursor();
  mida = height;
  background(255);
//  PImage myphoto = loadImage("/Users/mprats/Dropbox/Mates-investigacio/Presentacions/imatges/BAC/Sagrada.jpg");
  img = createImage(mida,mida,RGB);
  img0 = createImage(mida,mida,RGB);
  imgMandelbrot = createImage(2*mida,2*mida,ARGB);

  p = new PVector(0,0);
  q = new PVector(0,0);
  punt = new PVector(3*mida/4,mida/2);

  dibuixaEixos();
  dibuixaMandelbrot();
  iteracionsAFer=-1;
//  k=kmin;
  cursorX=mida/2;
  cursorY=mida/2;
  dibuixaIterat();
  img0=img.copy();
}

void draw(){
  if(!noCanvi){
    if(cursorX != mouseX || cursorY != mouseY){
      cursorX = mouseX;
      cursorY = mouseY;
      dibuixa();
    }
  }else{
    background(255);
    if(Mandel){
      image(imgMandelbrot,0,0,mida,mida);
    }
    if(!resDeRes || !itera){
       image(img,mida,0);
    }
    dibuixaEixos();
  }
}