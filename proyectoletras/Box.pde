
class Box {

  
  Body body;
  float w;
  float h;

  // Constructor
  Box(float x_, float y_) {
    float x = x_; //posicion en x
    float y = y_; //posicion en y
    w = 24; //ancho
    h = 24; //alto
    
    makeBody(new Vec2(x, y), w, h); //body es una clase, extencion de una clase definida dentro de la libreria box2D. El cuerpo o la parte rigida de la particula, lo que almacena
                                    //todas las leyes de la fisica para las particulas,haciendo operaciones. 
    body.setUserData(this);
  }

  
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }

  
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(0,0,0,0);
    stroke(0);
    //rect(0, 0, w, h);
    popMatrix();
  }

  
  void makeBody(Vec2 center, float w_, float h_) {
    
    BodyDef bd = new BodyDef(); //variable, la extiendo. 
    bd.type = BodyType.DYNAMIC; //que el objeto se mueva. Puede ser Static o dynamic
    bd.position.set(box2d.coordPixelsToWorld(center)); //parametros de x y y
    body = box2d.createBody(bd);//variable global

    
    PolygonShape sd = new PolygonShape(); //una clase dentro de la libreria, extendiendo una variable de esta clase, que haya una nueva forma poligonal.
    float box2dW = box2d.scalarPixelsToWorld(w_/2); //dos variables locales, solo funcionan cuando estoy extendiendo la clase. 
    float box2dH = box2d.scalarPixelsToWorld(h_/2); //una llamada al objeto box2d 
    sd.setAsBox(box2dW, box2dH); //variable sd. le paso este metodo con esos dos parametros.

    
    FixtureDef fd = new FixtureDef(); 
    fd.shape = sd;
    
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    body.createFixture(fd);
    

    
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
  }
}