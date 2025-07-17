PImage img, img0, imgMandelbrot;
PVector p,q,r, punt;
float cursorX, cursorY, k, kmin= 0.1;
int iteracionsAFer=50, mida, passos = 1, orbitaEstablePeriode=0, maxiter=100,extraRadis=1;
float[] zoom = {-2,2,-2,2};
boolean Mandel = false, itera = true, resDeRes = true, noCanvi = false, quadrat=true, eixos=false, linies = true, papersGirats=true;
char mode='p'; //'p' polar 'c' cartesianes
float baseModuls=2; //2.71828182846

  
void setup(){
  colorMode(HSB, 100);
  size(1200,600);
  noCursor();
  mida = height;
  background(100,0,100);
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
    if(papersGirats){
      if(punt.x != mouseX || punt.y != mouseY){
        punt.x = mouseX;
        punt.y = mouseY;        
        dibuixaEixos();
      }
    }else{
      if(cursorX != mouseX || cursorY != mouseY){
        cursorX = mouseX;
        cursorY = mouseY;
        dibuixa();
      }
    }
  }else{
    background(50,0,100);
    if(Mandel){
      image(imgMandelbrot,0,0,mida,mida);
    }
    if(!resDeRes || !itera){
       image(img,mida,0);
    }
    dibuixaEixos();
    
  }
}
