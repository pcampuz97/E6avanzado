class Particle {
  float x;
  float y;
  float tam;
  float vx;
  float vy;


  Particle() {
    x = random(-10, 10);
    y = random(-10, 10);
    tam = random(4, 20);
    float a = random(-10, 10);
    float speed = random(1, 2);
    vx = cos(a)*speed;
    vy = sin(a)*speed;
  }


  void display(int opacidad) {
    noStroke();
    color c = video.get(int(x), int(y));
    fill(c, opacidad);
    rect(x, y, tam, tam);
  }

  void move() {
    x = x + vx; //random(-5, 5);
    y = y + vy; //random(-5, 5);
    if (y < 0) {
      y = height;
    } 

    if (y > height) {
      y = 0;
    }
    if (x < 0) {
      x = width;
    } 

    if (x > width) {
      x = 0;
    }
  }
}
