void dibuixaEixos(){
  background(100,0,100);
  if(!resDeRes)image(img,mida,0);

  if(eixos) image(img0,0,0);
  if(Mandel){
    image(imgMandelbrot,0,0,mida,mida);
  }

  stroke(100,50,50);
  //primers eixos coordenats
  line(mida/2,0,mida/2,mida);
  line(mida/4,mida/2-5,mida/4,mida/2+5);
  line(3*mida/4,mida/2-5,3*mida/4,mida/2+5);
  line(mida,mida/2,0,mida/2);  
  line(mida/2-5,mida/4,mida/2+5,mida/4);  
  line(mida/2-5,3*mida/4,mida/2+5,3*mida/4);
  //segons eixos coordenats
  if(zoom.length==4){
    line(mida+mida/2,0,mida+mida/2,mida);
    line(mida+mida/4,mida/2-5,mida+mida/4,mida/2+5);
    line(mida+3*mida/4,mida/2-5,mida+3*mida/4,mida/2+5);
    line(mida+mida,mida/2,mida+0,mida/2);  
    line(mida+mida/2-5,mida/4,mida+mida/2+5,mida/4);  
    line(mida+mida/2-5,3*mida/4,mida+mida/2+5,3*mida/4);
  }
  //Separador
  line(mida,0,mida,mida);
  
  if(quadrat){
    pintaPunts(punt, passos);
  }
  
  if(cursorX<mida){
    stroke(20,100,90);
    fill(20,100,90);
    line(mida/2,mida/2,cursorX,cursorY);
    ellipse(cursorX,cursorY,10,10);
    stroke(0);
  }
  
  int posicio=zoom.length;
  fill(100,50,50);
  rect(20, mida-40, mida/2-80, 30); 
  String text1, text2;
  if(map(cursorY,0,mida,2,-2)>=0) text1 = "+"+ (map(cursorY,0,mida,2,-2));
  else text1 = ""+ map(cursorY,0,mida,2,-2);
  if(map(punt.y,0,mida,zoom[posicio-1],zoom[posicio-2])>=0) text2 = "+"+  map(punt.y,0,mida,zoom[posicio-1],zoom[posicio-2]);
  else text2 = ""+  map(punt.y,0,mida,zoom[posicio-1],zoom[posicio-2]);
  
  String s = " c = " + map(cursorX,0,mida,-2,2)  + text1 + " i" + "\n z_0 = " + map(punt.x,0,mida,zoom[posicio-4],zoom[posicio-3]) + text2 + " i";
  fill(0,100,0);
  text(s, 20, mida-40, mida-80, 30);  // Text wraps within text box
}

void pintaPunts(PVector puntet, int passets){
  int posicio=zoom.length;
  PVector aux = new PVector(0,0);
  PVector auxx = new PVector(0,0);
  PVector oriaux = new PVector(0,0);//finestra sense zoom
  PVector oriauxx = new PVector(0,0);//finestra sense zoom
  //PVector oripuntet = new PVector(0,0);//finestra sense zoom
  
  //oripuntet.set(map(puntet.x, 0,mida,zoom[posicio-4],zoom[posicio-3]),map(puntet.y,0,mida,zoom[posicio-1],zoom[posicio-2]));
  //oripuntet.set(map(oripuntet.x,zoom[0],zoom[1], 0,mida),map(oripuntet.y,zoom[3],zoom[2],0,mida));
  
  stroke(87,100,50);
  fill(87,100,80);
  if(zoom.length==4)line(mida+mida/2,mida/2,mida+punt.x,punt.y);
  //line(mida/2,mida/2,punt.x,punt.y);
  ellipse(mida+puntet.x,puntet.y,10,10);
  //if(passets == passos && eixos) ellipse(oripuntet.x,oripuntet.y,10,10);
  aux.set(map(puntet.x, 0,mida,zoom[posicio-4],zoom[posicio-3]),map(puntet.y,0,mida,zoom[posicio-1],zoom[posicio-2]));
  oriaux.set(map(puntet.x, 0,mida,zoom[0],zoom[1]),map(puntet.y,0,mida,zoom[3],zoom[2]));
  aux = cMult(aux,aux);
  oriaux.set(map(aux.x,zoom[0],zoom[1], 0,mida),map(aux.y,zoom[3],zoom[2],0,mida));
  auxx.set(aux.x+map(cursorX,0,mida,zoom[0],zoom[1]),aux.y+map(cursorY,0,mida,zoom[3],zoom[2]));
  aux.set(map(aux.x,zoom[posicio-4],zoom[posicio-3], 0,mida),map(aux.y,zoom[posicio-1],zoom[posicio-2],0,mida));
  stroke(40,100,50);
  if(passos == 1){
    if(linies){if(zoom.length==4){line(mida+mida/2,mida/2,mida+aux.x,aux.y);}}
    //if(linies)line(mida/2,mida/2,aux.x,aux.y);
  }else{
    if(linies){
      line(mida+puntet.x,puntet.y,mida+aux.x,aux.y);
      // line(puntet.x,puntet.y,aux.x,aux.y);
    }
  }
  fill(40,100,80);
  if(linies)ellipse(mida+aux.x,aux.y,10,10);
  //if(linies)ellipse(aux.x,aux.y,10,10);
  stroke(0,100,0);    
  
  if(cursorX<mida){
    stroke(18,100,50);
    fill(18,100,90);
    auxx.set(map(auxx.x,zoom[posicio-4],zoom[posicio-3],0,mida),map(auxx.y,zoom[posicio-1],zoom[posicio-2],0,mida));
    oriauxx.set(oriaux.x+cursorX-mida/2,oriaux.y+cursorY-mida/2);
    if(linies){
      line(mida+aux.x,aux.y,mida+auxx.x,auxx.y);
      //line(aux.x,aux.y,auxx.x,auxx.y);
    }
    else{
      line(mida+puntet.x,puntet.y,mida+auxx.x,auxx.y);
      //line(puntet.x,puntet.y,auxx.x,auxx.y);
    }
    ellipse(mida+auxx.x,auxx.y,10,10);
    if(passets == 1 && eixos && oriauxx.x<mida) ellipse(oriauxx.x,oriauxx.y,10,10);
    stroke(0,100,0);
  }
  if(passets>1){
    pintaPunts(auxx, passets-1);
  }
}

void dibuixa(){
  if(!itera){
    dibuixaNoIterat();
  }else{
    if(!resDeRes){
      dibuixaIterat();
    }
  }   
  dibuixaEixos();
 }
 
 void dibuixaNoIterat(){   
   img.loadPixels();

  //Create counter for img.pixels array
  int counter = 0;
  q = new PVector(map(cursorX,0,mida,-2,2),map(cursorY,0,mida,2,-2));

  PVector[] puntsFixats = puntsFixos(q);
  
  //Create coefficients of complex number a + bi
  int posicio = zoom.length;
  float b= zoom[posicio-1];
  int contay=0;
  float a= zoom[posicio-4];
  int contax=0;
 
  while (contay < img.height){
    a =zoom[posicio-4]; 
    contax=0;
    while (contax < img.width){
      /*if( a*a + b*b >= 4){
        img.pixels[counter] = color(0,0,0);
      }*/
      //else{           
        {//Create complex number as vector
        p = new PVector(a,b);
        
        int i=0;
        
       
        while (p.mag() < 1000 && PVector.sub(p,puntsFixats[0]).mag() > 0.001  && i<maxiter){
          p = cMult(p,p);
          p.add(q);
          i+=1;
        }
  
        //get that color
        //int co1 = 2 * abs((5 * i) % 240 - 120);
        //int co2 = -80 + i +2 * abs((5 * 80) % 240 - 120);
        
        //colorMode(HSB, 100);
        int br = 100 - abs(i % 100 );
        int sa=100 - abs( 50*i % 100 );
        color c = color(0,sa,br);
        if(p.mag() > 1000){
          c = color(0,sa,br);
        }
        if( PVector.sub(p,puntsFixats[0]).mag() < 0.001){
          c = color(10+(i % orbitaEstablePeriode)*80/orbitaEstablePeriode,sa,br);
        }
/*        if(PVector.sub(p,puntsFixats[1]).mag() < 0.001){
          c = color(co2,co2,co1);
          if(orbitaEstablePeriode==2 && i%2 == 0){
            c = color(co2,co1,co2);
          }
        }*/
        if(i == maxiter){
          c = color(0,sa/2,80);
        }
  
        //put that color in the new image
        img.pixels[counter] = c;
        //colorMode(RGB, 255);
      }
 
      //increment a and counter
      a += (zoom[posicio-3]-zoom[posicio-4])/img.width;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= (zoom[posicio-1]-zoom[posicio-2])/img.height;
     contay+=1;
  }
 
  img.updatePixels();
  //draw image on screen
}
 
void dibuixaIterat(){
   img.loadPixels();

  //Create counter for img.pixels array
  int counter = 0;
  q.set(map(cursorX,0,mida,-2,2),map(cursorY,0,mida,2,-2),0);
  
  PVector coloret = new PVector(0,100,0);

// (si fem el límit fa falta)
// PVector[] puntsFixats = puntsFixos(q);
 
  
  //Create coefficients of complex number a + bi
  int posicio = zoom.length;
  float b= zoom[posicio-1];
  int contay=0;
  float a= zoom[posicio-4];
  int contax=0;


  while (contay < mida){
    a = zoom[posicio-4];
    contax=0;
    while (contax < mida){
      //Create complex number as vector
      p.set(a,b,0);
      int exponent = 1;
        
      //Fem les iteracions, amb control de si ens escapem 
      exponent = funcioInnocent();
        
      coloret = obteColor(p, exponent*log(p.mag()));
      color c = color(coloret.x,coloret.y,coloret.z);  
      //put that color in the new image
      img.pixels[counter] = c;

      //increment a and counter
      a += (zoom[posicio-3]-zoom[posicio-4])/img.height;
      contax +=1;
      counter += 1;
     }
     //increment b
     b -= (zoom[posicio-1]-zoom[posicio-2])/img.height;
     contay+=1;
  }
 
  img.updatePixels();
  //draw image on screen
}
 
 
 
void dibuixaMandelbrot(){
  imgMandelbrot.loadPixels();

  //Create counter for img.pixels array
  int counter = 0;
  PVector coloret = new PVector(0,0,0);

  //Create coefficients of complex number a + bi
  float b=2;
  int contay=0;
  float a=-2;
  int contax=0;
  colorMode(RGB,255);

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
  colorMode(HSB,100);

  imgMandelbrot.updatePixels();
}