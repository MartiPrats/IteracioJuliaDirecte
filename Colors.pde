
PVector obteColor(PVector s, float logModul) {
  PVector coloretATornar = new PVector(0, 100, 0); //black
  if (s.mag() >= 0.000000000001) {
    PVector signe = s.cross(new PVector(1, 0));
    float angle=0;
    float enCorbaNivell1, enCorbaNivell2;
    if (signe.z != 0) {
      angle=  signe.z/abs(signe.z) * PVector.angleBetween(new PVector(1, 0), s)/(2*PI);
    }
    //float saturation=100* pow(sin(PI/2+PI*0.08*pow(logModul,1)),2);
    float saturation=100-100.* (atan(logModul-2)+PI)/(2*PI);
    //float saturation=100* 1./(.7+0.3*logModul);
    //float saturation=100* 1./(.7+0.3*logModul);
    float bright=0;
    if (mode=='p') {
      enCorbaNivell1=3*abs(sin(2*logModul/log(baseModuls)));
      enCorbaNivell2=3*abs(sin(2*2*PI*angle*extraRadis));
    } else {
      enCorbaNivell1=7*abs(s.x-round(s.x));
      enCorbaNivell2=7*abs(s.y-round(s.y));
    }

    bright=100;
    if (enCorbaNivell1<1) bright= 100 * pow(2*enCorbaNivell1-enCorbaNivell1*enCorbaNivell1, .25);
    if (enCorbaNivell2<1) bright*= .4+.6*pow(2*enCorbaNivell2-enCorbaNivell2*enCorbaNivell2, .5);
    if (s.mag()<0.25) bright*=2*sqrt(s.mag());


    //if (enCorbaNivell<0.2) bright= 100 * pow(5*(enCorbaNivell), 0.25);
    //if (s.mag()<0.0625) bright*=4*sqrt(s.mag());



    s.normalize();

    float hue=(100 * (0.5 +angle));

    coloretATornar.x = hue;
    coloretATornar.y = saturation;
    coloretATornar.z = bright;
  }


  return coloretATornar;
}
