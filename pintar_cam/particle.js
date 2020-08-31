// Daniel Shiffman
// code for https://youtu.be/vqE8DMfOajk

function Particle(x, y) {
  this.x = x;
  this.y = y;
  this.r = random(4, 43);

  this.update = function() {
    this.x += random(-10, 10);
    this.y += random(-10, 10);

    this.x = constrain(this.x, 0, width);
    this.y = constrain(this.y, 0, height);
  };

  this.show = function() {
    noStroke();
    let px = floor(this.x / vScale);
    let py = floor(this.y / vScale);
    let col = video.get(px, py);
    //console.log(col);
    fill(col[0]-slider.value(), col[1]-slider.value(), col[2]-slider.value(), 110);
    rect(this.x, this.y, this.r);
  };
}
