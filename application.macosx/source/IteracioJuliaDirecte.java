import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class IteracioJuliaDirecte extends PApplet {

PImage img, img0, imgMandelbrot;
PVector p,q,r, punt;
float k, kmin= 0.1f;
int cursorX, cursorY, iteracionsAFer=50;
int mida, passos = 1;
boolean Mandel = false, itera = true, resDeRes = true, noCanvi = true, quadrat=false, eixos=false;

  
public void setup(){
  
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

public void draw(){
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

public void keyPressed() {
  // P per imprimir dibuix
  switch(key){
    case 'P':
    case 'p':
      selectFolder("Selecciona una carpeta:", "folderSelectedPrint");
      break;
    case 'R':
    case 'r':
      iteracionsAFer = -1;
    case '+':
      iteracionsAFer += 2; //Inclou el cas seguent!
    case '-':
      if(iteracionsAFer>=0){
        iteracionsAFer -= 1;
      }
      if(iteracionsAFer == -1){
        resDeRes = true;
      }else{
        resDeRes = false;
      }
      dibuixa();
      break;
    case 'M':
    case 'm':
      Mandel = !Mandel;
      dibuixa();
      break;
    case 'I':
    case 'i':
      itera = !itera;
      dibuixa();
      break;
    case 'e':
    case 'E':
      eixos =! eixos;
      dibuixa();
      break;
    case 'q':
    case 'Q':
      quadrat =! quadrat;
      dibuixa();
      break;
    case '0':
      cursorX=mida/2;
      cursorY=mida/2;
      noCanvi = !noCanvi;
      dibuixa();
      break;
    case '1':
      passos = 1;
      dibuixa();
      break;      
    case '2':
      passos = 2;
      dibuixa();
      break;      
    case '3':
      passos = 3;
      dibuixa();
      break;      
    case '4':
      passos = 4;
      dibuixa();
      break;      
    case '5':
      passos = 5;
      dibuixa();
      break;      
  }
  if(key == CODED){
    switch(keyCode){
      case UP:
        punt.y -= 20;
        break;
      case DOWN:
        punt.y += 20;
        break;
      case LEFT:
        punt.x -= 20;
        break;
      case RIGHT:
        punt.x += 20;
        break;
    }
    dibuixa();
  }
}

 
public void folderSelectedPrint(File selection) {
   String ruta;
   if (selection == null) {
      println("La finestra ha estat tancada");
    } 
    else {
      ruta = selection.getAbsolutePath();
      saveFrame(ruta + "/funcio####.png");
    }
 }

public PVector obteColor(PVector s, float logModul){
  PVector coloretATornar = new PVector(0,0,0);
    
  if(s.mag() >= 0.000000000001f){  
    s.normalize();
  
    //El color ser\u00e0 circular en funci\u00f3 de l'argument de s, amb color pur r, g o b
    // en les arrels cubiques de la unitat.
    coloretATornar.y = pow(1 + s.dot(new PVector(1,0,0)),2); 
    coloretATornar.z = pow(1 + s.dot(new PVector(-1/2,sqrt(3)/2.f,0)),2); 
    coloretATornar.x = pow(1 + s.dot(new PVector(-1/2,-sqrt(3)/2.f,0)),2); 
    
    // Normalitzem a logModul 255
    coloretATornar.mult(255.f/coloretATornar.mag());
    
    //La intensitat del color depen del logModul. Modul 1, intensitat 1. Modul 0 intensitat m\u00ednima.     
    float llindar = 2;
    float multiplicant = (2.f+ llindar) / llindar * logModul/(2 + logModul);
    if(logModul<llindar) coloretATornar.mult(multiplicant);
    if(logModul>=llindar){
      coloretATornar.x =  255 - llindar/logModul * (255 - coloretATornar.x);
      coloretATornar.y =  255 - llindar/logModul * (255 - coloretATornar.y);
      coloretATornar.z =  255 - llindar/logModul * (255 - coloretATornar.z);
    }
  }
  
  return coloretATornar;
}
 
public void dibuixaEixos(){
  if(eixos) image(img0,0,0);
  if(Mandel){
    image(imgMandelbrot,0,0,mida,mida);
  }

  stroke(150);
  line(mida/2,0,mida/2,mida);
  line(mida/4,mida/2-5,mida/4,mida/2+5);
  line(3*mida/4,mida/2-5,3*mida/4,mida/2+5);
  line(mida,mida/2,0,mida/2);  
  line(mida/2-5,mida/4,mida/2+5,mida/4);  
  line(mida/2-5,3*mida/4,mida/2+5,3*mida/4);
  stroke(0);
  
  if(quadrat){
    pintaPunts(punt, passos);
  }
  
  if(mouseX<mida){
    stroke(200,200,0);
    fill(200,200,0);
    line(mida/2,mida/2,mouseX,mouseY);
    ellipse(mouseX,mouseY,10,10);
    stroke(0);
  }
}

public void pintaPunts(PVector puntet, int passets){
  PVector aux = new PVector(0,0);
  PVector auxx = new PVector(0,0);
  stroke(150,0,150);
  fill(150,0,150);
  line(mida/2,mida/2,punt.x,punt.y);
  ellipse(puntet.x,puntet.y,10,10);
  aux.set(map(puntet.x, 0,mida,-2,2),map(puntet.y,0,mida,2,-2));
  aux = cMult(aux,aux);
  aux.set(map(aux.x,-2,2, 0,mida),map(aux.y,2,-2,0,mida));
  stroke(0,150,50);
  if(passos == 1){
    line(mida/2,mida/2,aux.x,aux.y);
  }else{
    line(puntet.x,puntet.y,aux.x,aux.y);
  }
  fill(0,150,50);
  ellipse(aux.x,aux.y,10,10);
  stroke(0,0,0);    
  
  if(mouseX<mida){
    stroke(250,250,0);
    fill(250,250,0);
    auxx.set(aux.x+mouseX-mida/2,aux.y+mouseY-mida/2);
    line(aux.x,aux.y,auxx.x,auxx.y);
    ellipse(auxx.x,auxx.y,10,10);
    stroke(0);
  }
  if(passets>1){
    pintaPunts(auxx, passets-1);
  }
}

public void dibuixa(){
  background(255);
  dibuixaEixos();
  if(!itera){
    dibuixaNoIterat();
  }else{
    if(!resDeRes){
      dibuixaIterat();
    }
  }   
 }
 
 public void dibuixaNoIterat(){   
   img.loadPixels();

  //Create counter for img.pixels array
  int counter = 0;
  q = new PVector(map(cursorX,0,mida,-2,2),map(cursorY,0,mida,2,-2));

  PVector[] puntsFixats = puntsFixos(q);
  
  //Create coefficients of complex number a + bi
  float b= 2;
  int contay=0;
  float a=-2;
  int contax=0;
 
  while (contay < img.height){
    a =-2; 
    contax=0;
    while (contax < img.width){
      /*if( a*a + b*b >= 4){
        img.pixels[counter] = color(0,0,0);
      }*/
      //else{           
        {//Create complex number as vector
        p = new PVector(a,b);
        
        int i=0;
        
       
        while (p.mag() < 1000 && PVector.sub(p,puntsFixats[0]).mag() > 0.001f && PVector.sub(p,puntsFixats[1]).mag() > 0.001f  && i<80){
          p = cMult(p,p);
          p.add(q);
          i+=1;
        }
  
        //get that color
        int co1 = 2 * abs((5 * i) % 240 - 120);
        int co2 = -80 + i +2 * abs((5 * 80) % 240 - 120);
        int c = color(0,0,0);
        if(p.mag() > 1000){
          c = color(co1,co2,co2);
        }
        if( PVector.sub(p,puntsFixats[0]).mag() < 0.001f){
          c = color(co2,co1,co2);
        }
        if(PVector.sub(p,puntsFixats[1]).mag() < 0.001f){
          c = color(co2,co2,co1);
        }
        if(i == 80){
          c = color(co1,co1,co1);
        }
  
        //put that color in the new image
        img.pixels[counter] = c;
      }
 
      //increment a and counter
      a += 4.0f/img.width;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= 4.0f/img.height;
     contay+=1;
  }
 
  img.updatePixels();
  //draw image on screen
  image(img,mida,0);
}
 
public void dibuixaIterat(){
   img.loadPixels();

  //Create counter for img.pixels array
  int counter = 0;
  q.set(map(cursorX,0,mida,-2,2),map(cursorY,0,mida,2,-2),0);
  
  PVector coloret = new PVector(0,0,0);

// (si fem el l\u00edmit fa falta)
// PVector[] puntsFixats = puntsFixos(q);
 
  
  //Create coefficients of complex number a + bi
  float b= 2;
  int contay=0;
  float a= -2;
  int contax=0;
 
  while (contay < mida){
    a = -2; 
    contax=0;
    while (contax < mida){
      //Create complex number as vector
      p.set(a,b,0);
      int exponent = 1;
        
      //Control de si ens escapem 
      exponent = funcioInnocent();
        
      coloret = obteColor(p, exponent*log(p.mag()+1));
      int c = color(coloret.x,coloret.y,coloret.z);  
      //put that color in the new image
      img.pixels[counter] = c;

      //increment a and counter
      a += 4.0f/mida;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= 4.0f/mida;
     contay+=1;
  }
 
  img.updatePixels();
  //draw image on screen
  image(img,width/2,0);
}
 
 
 
public void dibuixaMandelbrot(){
  imgMandelbrot.loadPixels();

  //Create counter for img.pixels array
  int counter = 0;
  PVector coloret = new PVector(0,255,255);

  //Create coefficients of complex number a + bi
  float b=2;
  int contay=0;
  float a=-2;
  int contax=0;
 
  while (contay < imgMandelbrot.height){
    a = -2; 
    contax=0;
    while (contax < imgMandelbrot.width){
        coloret.set(255,255,255);
        //Create complex number as vector
        p.set(0,0,0);
        q.set(a,b,0);
        funcioInnocentBreak();
        
        if(p.mag() < 2){
          coloret.set(0,0,0);
        }
  
        //put that color in the image
        imgMandelbrot.pixels[counter] = color(coloret.x,coloret.y,coloret.z, 255-coloret.z);
      
      //increment a and counter
      a += 4.0f/imgMandelbrot.width;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= 4.0f/imgMandelbrot.height;
     contay+=1;
  }

  imgMandelbrot.updatePixels();
}

//Function for multiplying complex numbers as vectors:
public PVector cMult(PVector a, PVector b){  
  double xx = a.x*b.x-a.y*b.y;
  double yy = a.x*b.y+a.y*b.x;
  PVector c = new PVector(0,0);
  c.x = (float)(xx);
  c.y = (float)(yy);
  return c;
}


public PVector cInvert(PVector a){
 PVector c = new PVector(a.x/pow(a.mag(),2),-a.y/pow(a.mag(),2));
 return c;
}

public PVector cSqrt(PVector a){
 PVector c = new PVector(sqrt(a.mag()),0);
  c.rotate(PVector.angleBetween(a,new PVector(1,0))/2);

 if(cMult(c,c).sub(a).mag()<0.00001f){ 
   return c;
 }else{
   c.rotate(- PVector.angleBetween(a,new PVector(1,0)));
   return c;
 }
}

public PVector cExp(PVector a){
 PVector c = new PVector(cos(a.y), sin(a.y));
 c.mult(exp(a.x));
  return c;
}
public int funcioInnocent(){
  int exponent = 1;
  for(int i=0; i<iteracionsAFer; i++){
    exponent = exponent * aplicaF();
  }
  return exponent;
}

public void funcioInnocentBreak(){
  for(int i=0; i<iteracionsAFer; i++){
    aplicaF();
    if(p.mag()>2){
      return;
    }
  }
}
 
/*int limit(PVector[] puntsFixats){
  int i=0;

  while (p.mag() < 1000 && PVector.sub(p,puntsFixats[0]).mag() > 0.001 && PVector.sub(p,puntsFixats[1]).mag() > 0.001  && i<80){
    aplicaF();
    i+=1;
  }
  return i;
}*/

public int aplicaF(){
  int exponent = 1;
  //Tipic grau 2
  p = cMult(p,p); 
  if( p.mag() > 100000000 ){
    p.mult(1.f/sqrt(p.mag()));
    exponent = 2;
  }
  if( p.mag() > 100000000 ){
    p.mult(1.f/sqrt(p.mag()));
    exponent = 4;
  }
  p.add(q);
  
  
  return exponent;
}

public PVector[] puntsFixos(PVector c){
  PVector[] zZero = new PVector[2];
  
  zZero[0] = new PVector(0,0);
  zZero[1] = new PVector(0,0);
  
  PVector arrel = cSqrt(cMult(c, new PVector(-4,0)).add(new PVector(1,0)));
  
  zZero[0].add(new PVector(1,0));
  zZero[0].add(arrel);
  zZero[0].mult(1.f/2);
  if(zZero[0].mag() >= 1/2) zZero[0].set(10,10); //derivada major que 1.

  zZero[1].add(new PVector(1,0));
  zZero[1].sub(arrel);
  zZero[1].mult(1.f/2);
  if(zZero[1].mag() >= 1/2) zZero[0].set(10,10);

  return zZero;
}
  public void settings() {  size(1200,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "IteracioJuliaDirecte" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
