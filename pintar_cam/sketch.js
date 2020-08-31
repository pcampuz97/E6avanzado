
var video;
var vScale = 16;

var particles = [];

var slider;

function setup() {
  createCanvas(824.6, 620);
  pixelDensity(1);
  video = createCapture(VIDEO);
  video.size(width / vScale, height / vScale);
  for (var i = 0; i < 1000; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
  slider = createSlider(0, 255, 255);
  background(50);
}

function mousePressed(){

}

function draw() {
  background(50);
  video.loadPixels();
  for (var i = 0; i < particles.length; i++) {
    particles[i].update();
    particles[i].show();
  }
}
