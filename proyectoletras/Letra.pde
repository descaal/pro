class letra {
  float x;
  float y;
  char ch;
  int r, g, b;
  
  letra(float xi, float yi) { 
    x = xi;
    y = yi;
    ch = (char) random( 65, 91); 
    r = (int) random( 0, 255); 
    g = (int) random( 0, 255);
    b = (int) random( 0, 255);
  }
  
  void dibujar(){
    fill( r, g, b); 
    text(ch, x, y); 
    x += random(-5, 5); 
    y -= random(5); 
  }
  
  float obtenery(){
    return y; 
  }
}