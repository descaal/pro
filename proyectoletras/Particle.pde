
class Particle {

  // We need to keep track of a Body and a radius
  Body body;
  letra abc;
  float r;
  color col;
  char ch;
  int a,g,b;
  Particle(float x, float y, float r_) {
    r = r_;
    a = (int) random( 0, 255); 
    g = (int) random( 0, 255);
    b = (int) random( 0, 255);
    ch = (char) random( 65, 91); // Asignamos una letra aleatoria entre 65 y 91 ascii
   
    makeBody(x, y, r); //genera nuevo cuerpo, en posicion x y en y
    body.setUserData(this);
    col = color(random(255),random(255),random(255));
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }


  void change() {
    col = color(255, 0, 0);
  }

  
  boolean done() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }


  // 
  void display() { //dibujar un rectangulo
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle();
    pushMatrix(); //dentro de un pushmatrix y popmatrix porque utiliza la funcion rotate
    translate(pos.x, pos.y);
    rotate(a);
    //stroke(0);
    strokeWeight(1);
    //ellipse(0, 0, r*2, r*2);
    
    //line(0, 0, r, 0);
    popMatrix();
    textSize(26);
    fill(col);
    text(ch,pos.x, pos.y);
  }

  
  void makeBody(float x, float y, float r) {
    
    BodyDef bd = new BodyDef();
    
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;

    
    body.createFixture(fd);

    body.setAngularVelocity(random(-10, 10)); //velocidad angular, hace que el cuerpo gire sobre su propio eje.
  }
}