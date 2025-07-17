
//Function for multiplying complex numbers as vectors:
PVector cMult(PVector a, PVector b){  
  double xx = a.x*b.x-a.y*b.y;
  double yy = a.x*b.y+a.y*b.x;
  PVector c = new PVector(0,0);
  c.x = (float)(xx);
  c.y = (float)(yy);
  return c;
}


PVector cInvert(PVector a){
 PVector c = new PVector(a.x/pow(a.mag(),2),-a.y/pow(a.mag(),2));
 return c;
}

PVector cSqrt(PVector a){
 PVector c = new PVector(sqrt(a.mag()),0);
  c.rotate(PVector.angleBetween(a,new PVector(1,0))/2);

 if(cMult(c,c).sub(a).mag()<0.00001){ 
   return c;
 }else{
   c.rotate(- PVector.angleBetween(a,new PVector(1,0)));
   return c;
 }
}

PVector cExp(PVector a){
 PVector c = new PVector(cos(a.y), sin(a.y));
 c.mult(exp(a.x));
  return c;
}