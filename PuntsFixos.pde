PVector[] puntsFixos(PVector c){
  PVector[] zZero = new PVector[100];
  
  orbitaEstablePeriode = 1;
  for(int i=0; i<zZero.length;i++)  zZero[i] = new PVector(0,0);  

  for(int i=0; i<1000; i++){
    zZero[0] = cMult(zZero[0],zZero[0]);
    zZero[0].add(c);
    if(zZero[0].mag()>2){
      zZero[0].set(10,10);
      break;
    }
  }
  
  for(int i=1; i<zZero.length; i++){
    zZero[i] = cMult(zZero[i-1],zZero[i-1]);
    zZero[i].add(c);
    if(PVector.sub(zZero[i],zZero[0]).mag()<0.000001){
      orbitaEstablePeriode = i ;
      break;
    }
    
    if(zZero[i].mag()>2.){
      zZero[i].set(10,10);
      orbitaEstablePeriode = 0;
      break;
    }
  }
  
  


  return zZero;
}
/*PVector[] puntsFixos(PVector c){
  PVector[] zZero = new PVector[2];
  
  zZero[0] = new PVector(0,0);
  zZero[1] = new PVector(0,0);
  orbitaEstablePeriode =1;
  
  PVector arrel = cSqrt(cMult(c, new PVector(-4,0)).add(new PVector(1,0)));
  
  zZero[0].add(new PVector(1,0));
  zZero[0].add(arrel);
  zZero[0].mult(1./2);

  zZero[1].add(new PVector(1,0));
  zZero[1].sub(arrel);
  zZero[1].mult(1./2);

   
  if(zZero[0].mag() >= 1./2) zZero[0].set(10,10); //derivada major que 1.
  if(zZero[1].mag() >= 1./2) zZero[1].set(10,10); //derivada major que 1.

  if((zZero[0].x == 10) && (zZero[1].x == 10)){
    orbitaEstablePeriode=2;
    zZero[0] = new PVector(0,0);
    zZero[1] = new PVector(0,0);
    //println(zZero[1]);
  
    arrel = cSqrt(cMult(c, new PVector(-4,0)).add(new PVector(-3,0)));
  
    zZero[0].add(new PVector(-1,0));
    zZero[0].add(arrel);
    zZero[0].mult(1./2);

    zZero[1].add(new PVector(-1,0));
    zZero[1].sub(arrel);
    zZero[1].mult(1./2);
    
    if(zZero[0].mag()*zZero[1].mag() >= 1./4){
      zZero[0].set(10,10); //derivada major que 1.
      zZero[0].set(10,10);
      orbitaEstablePeriode=0;
    }
  }

  return zZero;
}*/