void fesZoomIn(int a, int b){
  if(a<0 || a> mida || b<0 ||b>mida) return;
  
  int posicio=zoom.length;
  float x = map(a,0,mida,zoom[posicio-4],zoom[posicio-3]);
  float y = map(b,0,mida,zoom[posicio-1],zoom[posicio-2]);
  
  zoom=append(zoom,(x+zoom[posicio-4])/2);
  zoom=append(zoom,(x+zoom[posicio-3])/2);
  zoom=append(zoom,(y+zoom[posicio-2])/2);
  zoom=append(zoom,(y+zoom[posicio-1])/2);
}

void fesZoomOut(int a, int b){
  if (zoom.length>4){
    zoom=shorten(zoom);
    zoom=shorten(zoom);
    zoom=shorten(zoom);
    zoom=shorten(zoom);
  }
}