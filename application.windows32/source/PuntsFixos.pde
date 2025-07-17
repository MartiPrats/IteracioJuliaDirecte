
PVector[] puntsFixos(PVector c){
  PVector[] zZero = new PVector[2];
  
  zZero[0] = new PVector(0,0);
  zZero[1] = new PVector(0,0);
  
  PVector arrel = cSqrt(cMult(c, new PVector(-4,0)).add(new PVector(1,0)));
  
  zZero[0].add(new PVector(1,0));
  zZero[0].add(arrel);
  zZero[0].mult(1./2);
  if(zZero[0].mag() >= 1/2) zZero[0].set(10,10); //derivada major que 1.

  zZero[1].add(new PVector(1,0));
  zZero[1].sub(arrel);
  zZero[1].mult(1./2);
  if(zZero[1].mag() >= 1/2) zZero[0].set(10,10);

  return zZero;
}