int funcioInnocent(){
  int exponent = 1;
  for(int i=0; i<iteracionsAFer; i++){
    exponent = exponent * aplicaF();
  }
  return exponent;
}

void funcioInnocentBreak(){
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

int aplicaF(){
  int exponent = 1;
  //Tipic grau 2
  p = cMult(p,p); 
  if( p.mag() > 100000000 ){
    p.mult(1./sqrt(p.mag()));
    exponent = 2;
  }
  if( p.mag() > 100000000 ){
    p.mult(1./sqrt(p.mag()));
    exponent = 4;
  }
  p.add(q);
  
  
  return exponent;
}