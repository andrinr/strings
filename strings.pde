ArrayList<J> joints;
int num = 50;
int mid;
float var = 200;
float factor = 0.00002;
int f;

void setup(){
  background(0);
  frameRate(60);
  smooth();
  size(1920,1080);
  stroke(255);
  strokeWeight(2);
  mid = height / 2;
  
  joints = new ArrayList<J>();
  
 
  float step = width / float(num);
  for (int i = 0; i <= num; i++){
    joints.add(new J(step * i, mid));
  }
}

void draw(){
  fill(0, 15);
  rect(0, 0, width, height);  
  noFill();
  for (int j = 0; j < 10 ; j++){
    f++;
    stroke(
    noise(f/200.+1230.3)*255,
    noise(f/200.+142.6)*255,
    noise(f/200.)*255
   );
    beginShape();
    for (J joint : joints){
      joint.update();
      curveVertex(joint.pos.x(),joint.pos.y());
    }
    endShape();
 
    if (random(1) > 0.997){
      var = random(1000) + 100;
      float midX = width/2. + random(-500,500);
      for (int i = 0; i <= num; i++){
        joints.get(i).speed += 100./(var*sqrt(2*PI))*exp(-0.5*pow((joints.get(i).pos.x()-midX)/var,2.));
      }
    }
  }
}

class J{
  V pos;
  float speed;
  float size;
  
  J(float x, float y){
    this.pos = new V(x,y);
    this.speed = 0;
    this.size = random(2) + 1;
  }
  
  void draw(){
    speed *= 0.99;
    point(pos.x(),pos.y());
  }
  
  void update(){
    speed += factor*(mid - pos.y());
    pos.y += speed;
  }
}
