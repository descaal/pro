
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


Box2DProcessing box2d;


Box box;
PImage background;

ArrayList<Particle> particles;


Spring spring;


float xoff = 0;
float yoff = 1000;
int flag=0;

void setup() {
  
  size(772,483);
  smooth();

  
  box2d = new Box2DProcessing(this); //extiende el objeto box2d
  box2d.createWorld(); //llama a este metodo. 

  
  box2d.listenForCollisions();

 
  box = new Box(width/2,height/2);


  spring = new Spring();
  spring.bind(width/2,height/2,box);

  
  particles = new ArrayList<Particle>();


}

void draw() {
  switch(flag){
    case 0:
    background = loadImage("proyecto3.jpg");
    background(background);
    if(mousePressed)
      flag++;
    break;
  case 1: 
  background(255);
  if (random(5) < 0.2) {
    float sz = random(4,8);
    particles.add(new Particle(width/2,-20,sz));
  }

  box2d.step(); //cada vez que llamo el metodo step es para que funcione la fisica y los objetos tomen la posición que les corresponde
  float x = noise(xoff)*width;
  float y = noise(yoff)*height;
  xoff += 0.01;
  yoff += 0.01;
 
   spring.update(mouseX,mouseY); //click para generar en distintas areas
   box.body.setAngularVelocity(0);
  
  for (int i = particles.size()-1; i >= 0; i--) { //llamar a todas las particulas en general
    Particle p = particles.get(i);
    p.display(); //metodo para no llamar miembro por miemmbro 
    // Particles that leave the screen, we delete them
    
    if (p.done()) {
      particles.remove(i);
    }
  }
  
  box.display(); //dibujar en cada llamada de metodo
 
  break;
}
}



void beginContact(Contact cp) {
  
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
 
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  // If object 1 is a Box, then object 2 must be a particle
  // Note we are ignoring particle on particle collisions
  if (o1.getClass() == Box.class) {
    Particle p = (Particle) o2;
    p.change();
  } 
 
  else if (o2.getClass() == Box.class) {
    Particle p = (Particle) o1;
    p.change();
  }
}


// Objects stop touching each other
void endContact(Contact cp) {
}