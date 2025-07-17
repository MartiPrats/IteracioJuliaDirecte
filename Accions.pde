float finura=20;

void keyPressed() {
  // P per imprimir dibuix
  switch(key) {
  case 'F'://Fi
  case 'f':
    if (finura>0.001) { 
      finura=finura/10;
    } else finura=20;
    println(finura); 
    break;
  case 'P'://Print
  case 'p':
    selectFolder("Selecciona una carpeta:", "folderSelectedPrint");
    break;
  case 'R':
  case 'r':
    iteracionsAFer = -1;
  case '+':
    iteracionsAFer += 2; //Inclou el cas seguent!
  case '-':
    if (iteracionsAFer>=0) {
      iteracionsAFer -= 1;
      passos=iteracionsAFer;
    }
    if (iteracionsAFer == -1) {
      passos=1;
      resDeRes = true;
    } else {
      resDeRes = false;
    }
    if (iteracionsAFer == 0) {
      passos=1;
    }
    dibuixa();
    break;
  case 'M':
  case 'm':
    Mandel = !Mandel;
    dibuixa();
    break;
  case 'L':
  case 'l':
    linies = !linies;
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
  case 'z':
  case 'Z':
    fesZoomIn(mouseX,mouseY);
    dibuixa();
    break;
  case 'x':
  case 'X':
    fesZoomOut(mouseX,mouseY);
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
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      if(papersGirats) cursorY -= finura;
      else punt.y -= finura;
      break;
    case DOWN:
      if(papersGirats) cursorY += finura;
      else punt.y += finura;
      break;
    case LEFT:
      if(papersGirats) cursorX -= finura;
      else punt.x -= finura;
      break;
    case RIGHT:
      if(papersGirats) cursorX += finura;
      else punt.x += finura;
      break;
    }
    if(papersGirats) dibuixa();
    else dibuixaEixos();
  }
}

void mouseReleased(){
  papersGirats = !papersGirats;
}

void folderSelectedPrint(File selection) {
  String ruta;
  if (selection == null) {
    println("La finestra ha estat tancada");
  } else {
    ruta = selection.getAbsolutePath();
    saveFrame(ruta + "/funcio####.png");
  }
}