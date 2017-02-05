
int tSize;
int h;
float scaleF = 1;
PImage photo;
int secondRow;
String input = "input.jpg";
void setup() {


  size(800, 800, P2D);

  photo = loadImage(input);
  //photo.resize(0, 1080);
  photo.loadPixels();
  background(51);
  tSize = photo.width/50;
  h = tSize/2;
  strokeWeight(map(tSize, 1, 20, 1, 3));
  //image(photo, 0, 0);
  //filter(GRAY);
  background(0);
  println(photo.width);
}

void draw() {

  triangulate(this.g);
  PGraphics pg = createGraphics(int(scaleF*(photo.width-tSize*2)),int(scaleF*photo.height), P2D);
  pg.beginDraw();
  pg.scale(scaleF);
  triangulate(pg);
  pg.save(input.split("\\.")[0]+"_output.png");
  pg.endDraw();



  noLoop();
}


void triangulate(PGraphics pg) {
  for (int i = 0; i<photo.height/h; i++) {
    if (i%2 == 1) {
      pg.pushMatrix();
      pg.translate(-h, 0);
      secondRow = h;
    }
    for (int j = 0; j < photo.width/tSize; j++) {
      //first triangle
      setColor(j*tSize+i*h*photo.width+(tSize/2)+(h/2)*photo.width-secondRow, pg);
      pg.pushMatrix();
      pg.translate(j*tSize, i*h);
      pg.triangle(0, 0, tSize, 0, h, h);

      //second triangle
      setColor(j*tSize+i*h*photo.width+(h/2)*photo.width-secondRow, pg);
      pg.rotate(PI);
      pg.translate(-h, -h);
      pg.triangle(0, 0, tSize, 0, h, h);
      pg.popMatrix();
    }
    if (i%2 == 1) {
      secondRow = 0;
      pg.popMatrix();
    }
  }
}



void setColor(int index, PGraphics pg) {
  color c = photo.pixels[index];
  pg.fill(c, 200);
  pg.stroke(c, 30);
}