
PVector obteColor(PVector s, float logModul){
  PVector coloretATornar = new PVector(0,0,0);
    
  if(s.mag() >= 0.000000000001){  
    s.normalize();
  
    //El color serà circular en funció de l'argument de s, amb color pur r, g o b
    // en les arrels cubiques de la unitat.
    coloretATornar.y = pow(1 + s.dot(new PVector(1,0,0)),2); 
    coloretATornar.z = pow(1 + s.dot(new PVector(-1/2,sqrt(3)/2.,0)),2); 
    coloretATornar.x = pow(1 + s.dot(new PVector(-1/2,-sqrt(3)/2.,0)),2); 
    
    // Normalitzem a logModul 255
    coloretATornar.mult(255./coloretATornar.mag());
    
    //La intensitat del color depen del logModul. Modul 1, intensitat 1. Modul 0 intensitat mínima.     
    float llindar = 2;
    float multiplicant = (2.+ llindar) / llindar * logModul/(2 + logModul);
    if(logModul<llindar) coloretATornar.mult(multiplicant);
    if(logModul>=llindar){
      coloretATornar.x =  255 - llindar/logModul * (255 - coloretATornar.x);
      coloretATornar.y =  255 - llindar/logModul * (255 - coloretATornar.y);
      coloretATornar.z =  255 - llindar/logModul * (255 - coloretATornar.z);
    }
  }
  
  return coloretATornar;
}
 