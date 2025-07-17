void dibuixaEixos(){
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

void pintaPunts(PVector puntet, int passets){
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

void dibuixa(){
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
 
 void dibuixaNoIterat(){   
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
        
       
        while (p.mag() < 1000 && PVector.sub(p,puntsFixats[0]).mag() > 0.001 && PVector.sub(p,puntsFixats[1]).mag() > 0.001  && i<80){
          p = cMult(p,p);
          p.add(q);
          i+=1;
        }
  
        //get that color
        int co1 = 2 * abs((5 * i) % 240 - 120);
        int co2 = -80 + i +2 * abs((5 * 80) % 240 - 120);
        color c = color(0,0,0);
        if(p.mag() > 1000){
          c = color(co1,co2,co2);
        }
        if( PVector.sub(p,puntsFixats[0]).mag() < 0.001){
          c = color(co2,co1,co2);
        }
        if(PVector.sub(p,puntsFixats[1]).mag() < 0.001){
          c = color(co2,co2,co1);
        }
        if(i == 80){
          c = color(co1,co1,co1);
        }
  
        //put that color in the new image
        img.pixels[counter] = c;
      }
 
      //increment a and counter
      a += 4.0/img.width;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= 4.0/img.height;
     contay+=1;
  }
 
  img.updatePixels();
  //draw image on screen
  image(img,mida,0);
}
 
void dibuixaIterat(){
   img.loadPixels();

  //Create counter for img.pixels array
  int counter = 0;
  q.set(map(cursorX,0,mida,-2,2),map(cursorY,0,mida,2,-2),0);
  
  PVector coloret = new PVector(0,0,0);

// (si fem el límit fa falta)
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
      color c = color(coloret.x,coloret.y,coloret.z);  
      //put that color in the new image
      img.pixels[counter] = c;

      //increment a and counter
      a += 4.0/mida;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= 4.0/mida;
     contay+=1;
  }
 
  img.updatePixels();
  //draw image on screen
  image(img,width/2,0);
}
 
 
 
void dibuixaMandelbrot(){
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
      a += 4.0/imgMandelbrot.width;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= 4.0/imgMandelbrot.height;
     contay+=1;
  }

  imgMandelbrot.updatePixels();
}