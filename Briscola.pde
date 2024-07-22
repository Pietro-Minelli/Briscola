import processing.sound.*; //<>//

Giocatore g1;
Giocatore cpu;
Carta mazzo[];
PImage retroCarta;
int nCarteRimaste;
boolean carteDisponibili[];
Carta briscola;
int menuIniziale=0;
int aChiTocca;
int chiHaPreso;
int cartaDaAvanzareGiocatore;
int cartaDaAvanzareCpu;
boolean hannoGiocatoEntrambi=false;
int indiceg=0;
int indicec=0;
boolean haTerminato=false;
boolean haTerminatodiDareLecarte=true;
int puntiGiocatore=0;
int puntiCpu=0;
SoundFile suonocarta;
boolean fineProgramma=false;
color coloreSfondo;
int rc, gc, bc;
PImage xrossa;
PFont fontb;

void setup() {
  fullScreen();
  cursor(WAIT);
  background(0);
  mazzo=new Carta[40];
  retroCarta=loadImage("Tema1.png");
  nCarteRimaste=mazzo.length;
  carteDisponibili=new boolean[40];
  for (int i=0; i<carteDisponibili.length; i++) {
    carteDisponibili[i]=true;
  }
  int r=(int)random(1, 41);
  constrain(r, 1, 40);
  briscola=new Carta(r, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  carteDisponibili[r-1]=false;
  int r1, r2;
  do {
    r=(int)random(1, 41);
    constrain(r, 1, 40);
  } while (carteDisponibili[r-1]==false);
  carteDisponibili[r-1]=false;
  do {
    r1=(int)random(1, 41);
    constrain(r1, 1, 40);
  } while (carteDisponibili[r1-1]==false);
  carteDisponibili[r1-1]=false;
  do {
    r2=(int)random(1, 41);
    constrain(r2, 1, 40);
  } while (carteDisponibili[r2-1]==false);
  carteDisponibili[r2-1]=false;
  mazzo[r-1]=new Carta(r, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  mazzo[r1-1]=new Carta(r1, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  mazzo[r2-1]=new Carta(r2, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  g1=new Giocatore(mazzo[r-1], mazzo[r1-1], mazzo[r2-1], 1);
  do {
    r=(int)random(1, 41);
    constrain(r, 1, 40);
  } while (carteDisponibili[r-1]==false);
  carteDisponibili[r-1]=false;
  do {
    r1=(int)random(1, 41);
    constrain(r1, 1, 40);
  } while (carteDisponibili[r1-1]==false);
  carteDisponibili[r1-1]=false;
  do {
    r2=(int)random(1, 41);
    constrain(r2, 1, 40);
  } while (carteDisponibili[r2-1]==false);
  carteDisponibili[r2-1]=false;
  mazzo[r-1]=new Carta(r, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  mazzo[r1-1]=new Carta(r1, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  mazzo[r2-1]=new Carta(r2, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  cpu=new Giocatore(mazzo[r-1], mazzo[r1-1], mazzo[r2-1], 2);
  aChiTocca=(int) random(1, 101);
  if (aChiTocca<=50) {
    aChiTocca=1;
    g1.haGiocatoPerPrimo=true;
    cpu.haGiocatoPerPrimo=false;
  } else {
    aChiTocca=2;
    cpu.haGiocatoPerPrimo=true;
    g1.haGiocatoPerPrimo=false;
  }
  cartaDaAvanzareGiocatore=-1;
  cartaDaAvanzareCpu=-1;
  chiHaPreso=0;
  nCarteRimaste-=6;
  suonocarta=new SoundFile(this, "suonocarta.mp3");
  suonocarta.amp(1);
  rc=(int)random(255);
  gc=(int)random(255);
  bc=(int)random(255);
  coloreSfondo=color(rc, gc, bc);
  xrossa=loadImage("x.png");
  fontb=createFont("zorque.ttf", 10);
  textFont(fontb);
}

void mouseClicked() {
  if (menuIniziale==1) {
  }  
  menuIniziale=1;
  if (mouseX>=width-width/5&&mouseX<=width-width/5+20&&mouseY>=height-height/7&&mouseY<=height-height/7+20) {
    rc=(int)random(255);
    gc=(int)random(255);
    bc=(int)random(255);
    coloreSfondo=color(rc, gc, bc);
  }
}

void keyPressed() {
  menuIniziale=1;
}

void draw() {
  if (menuIniziale==0) {
    textAlign(CENTER, CENTER);
    textSize(width/10);
    fill(255-rc, 255-gc, 255-bc);
    text("PREMI UN TASTO\nPER GIOCARE", width/2, height/2);
  } else if (menuIniziale==1&&fineProgramma==false) {
    background(coloreSfondo);
    sfondo();
    musicaEColore();
    if (aChiTocca==1&&hannoGiocatoEntrambi==false&&haTerminato==false&&haTerminatodiDareLecarte==true) {
      if (cartaDaAvanzareGiocatore==-1) {
        cartaDaAvanzareGiocatore=g1.update();
      } else if (g1.carteInMano[cartaDaAvanzareGiocatore].y>height/2) {
        g1.carteInMano[cartaDaAvanzareGiocatore].y-=width/76;
        if (g1.carteInMano[cartaDaAvanzareGiocatore].y<height/2) {
          g1.carteInMano[cartaDaAvanzareGiocatore].y=height/2;
        }
      } else if (g1.carteInMano[cartaDaAvanzareGiocatore].x<width/1.6) {
        g1.carteInMano[cartaDaAvanzareGiocatore].x+=width/76;
        if (g1.carteInMano[cartaDaAvanzareGiocatore].x>width/1.6) {
          g1.carteInMano[cartaDaAvanzareGiocatore].x=width/1.6;
        }
      } else if (g1.carteInMano[cartaDaAvanzareGiocatore].x>=width/1.6) {
        g1.cartaGiocata=g1.carteInMano[cartaDaAvanzareGiocatore];
        if (g1.haGiocatoPerPrimo) {
          aChiTocca=2;
        } else {
          hannoGiocatoEntrambi=true;
          g1.chiHaPreso(cartaDaAvanzareGiocatore);
        }
      }
    } else if (aChiTocca==2&&hannoGiocatoEntrambi==false&&haTerminato==false&&haTerminatodiDareLecarte==true) {
      if (cartaDaAvanzareCpu==-1) {
        cartaDaAvanzareCpu=cpu.updateCpu(g1);
        suonocarta.play();
      } else if (cpu.carteInMano[cartaDaAvanzareCpu].y<height/2) {
        cpu.carteInMano[cartaDaAvanzareCpu].y+=width/76;
        if (cpu.carteInMano[cartaDaAvanzareCpu].y>height/2) {
          cpu.carteInMano[cartaDaAvanzareCpu].y=height/2;
        }
      } else if (cpu.carteInMano[cartaDaAvanzareCpu].x<width/1.6) {
        cpu.carteInMano[cartaDaAvanzareCpu].retro=false;
        cpu.carteInMano[cartaDaAvanzareCpu].x+=width/76;
        if (cpu.carteInMano[cartaDaAvanzareCpu].x>width/1.6) {
          cpu.carteInMano[cartaDaAvanzareCpu].x=width/1.6;
        }
      } else if (cpu.carteInMano[cartaDaAvanzareCpu].x>=width/1.6) {
        cpu.cartaGiocata=cpu.carteInMano[cartaDaAvanzareCpu];
        if (cpu.haGiocatoPerPrimo) {
          aChiTocca=1;
        } else {
          hannoGiocatoEntrambi=true;
          cpu.chiHaPresoCpu(cartaDaAvanzareCpu);
        }
      }
    } else if (hannoGiocatoEntrambi==true&&cartaDaAvanzareCpu!=-1&&cartaDaAvanzareGiocatore!=-1) {
      for (int i=0; i<g1.nCarteInMano; i++) {
        if (g1.carteInMano[i]==g1.cartaGiocata) {
          indiceg=i;
        }
      }
      for (int i=0; i<cpu.nCarteInMano; i++) {
        if (cpu.carteInMano[i]==cpu.cartaGiocata) {
          indicec=i;
        }
      }
      if (chiHaPreso==1&&g1.carteInMano[indiceg].y<=height+g1.carteInMano[indiceg].alt) {
        g1.carteInMano[indiceg].y+=width/76;
        cpu.carteInMano[indicec].y+=width/76;
      } else if (chiHaPreso==2&&g1.carteInMano[indiceg].y>=0-g1.carteInMano[indiceg].alt) {
        g1.carteInMano[indiceg].y-=width/76;
        cpu.carteInMano[indicec].y-=width/76;
      } else {
        if (chiHaPreso==2) {
          cpu.haGiocatoPerPrimo=true;
          g1.haGiocatoPerPrimo=false;
        } else if (chiHaPreso==1) {
          g1.haGiocatoPerPrimo=true;
          cpu.haGiocatoPerPrimo=false;
        }
        hannoGiocatoEntrambi=false;
        haTerminato=true;
        haTerminatodiDareLecarte=false;
        g1.carteInMano[indiceg].edisponibile=false;
        cpu.carteInMano[indicec].edisponibile=false;
        aggiornaPunti();
        if (nCarteRimaste==0) {
          cartaDaAvanzareCpu=-1;
          cartaDaAvanzareGiocatore=-1;
          haTerminato=false;
          haTerminatodiDareLecarte=true;
          indiceg=0;
          indicec=0;
        }
        if (cpu.carteInMano[0].edisponibile==false&&cpu.carteInMano[1].edisponibile==false&&cpu.carteInMano[2].edisponibile==false) {
          fineProgramma=true;
        }
      }
    } else if (hannoGiocatoEntrambi==false&&haTerminato&&haTerminatodiDareLecarte==false&&nCarteRimaste>2&&nCarteRimaste>0) {
      daiCarte();
      haTerminato=false;
    } else if (hannoGiocatoEntrambi==false&&haTerminato&&haTerminatodiDareLecarte==false&&nCarteRimaste==2&&nCarteRimaste>0) {
      daiUltimeCarte();
      haTerminato=false;
    }
    if (g1.haGiocatoPerPrimo) {
      g1.show();
      cpu.showCpu();
    } else {
      cpu.showCpu();
      g1.show();
    }
    turniEPunti();
  } else {
    background(0);
    textAlign(CENTER, CENTER);
    textSize(width/10);
    if (puntiGiocatore>puntiCpu) {
      text("HAI VINTO\nPUNTI: "+puntiGiocatore+"\nPUNTI CPU: "+puntiCpu, width/2, height/2);
    } else if (puntiGiocatore<puntiCpu) {
      text("HAI PERSO\nPUNTI: "+puntiGiocatore+"\nPUNTI CPU: "+puntiCpu, width/2, height/2);
    } else {
      text("PAREGGIO\nPUNTI: "+puntiGiocatore+"\nPUNTI CPU: "+puntiCpu, width/2, height/2);
    }
  }
  if (mouseX>=g1.carteInMano[0].x-g1.carteInMano[0].larg/2&&mouseX<=g1.carteInMano[0].x+g1.carteInMano[0].larg/2&&mouseY>=height-g1.carteInMano[0].alt&&g1.carteInMano[0].edisponibile) {
    cursor(HAND);
  } else if (mouseX>=g1.carteInMano[1].x-g1.carteInMano[1].larg/2&&mouseX<=g1.carteInMano[1].x+g1.carteInMano[1].larg/2&&mouseY>=height-g1.carteInMano[1].alt&&g1.carteInMano[1].edisponibile) {
    cursor(HAND);
  } else if (mouseX>=g1.carteInMano[2].x-g1.carteInMano[2].larg/2&&mouseX<=g1.carteInMano[2].x+g1.carteInMano[2].larg/2&&mouseY>=height-g1.carteInMano[2].alt&&g1.carteInMano[2].edisponibile) {
    cursor(HAND);
  } else if (mouseX>=width-30&&mouseY<=20&&menuIniziale==1) {
    cursor(HAND);
    image(xrossa, width-15, 10, 30, 20);
    if (mousePressed) {
      cursor(WAIT);
      exit();
    }
  } else if (mouseX>=briscola.x-briscola.alt/2&&mouseX<=briscola.x+briscola.alt/2&&mouseY>=briscola.y-briscola.larg/2&&mouseY<=briscola.y+briscola.larg/2&&nCarteRimaste>0) {
    cursor(HAND);
  } else if ((mouseX>=width-width/5&&mouseX<=width-width/5+20&&mouseY>=height-height/7&&mouseY<=height-height/7+20)) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}

void sfondo() {
  if (nCarteRimaste>0) {
    //if (mouseX>=1470&&mouseX<=1825&&mouseY>=440&&mouseY<=635) {
    if (mouseX>=briscola.x-briscola.alt/2&&mouseX<=briscola.x+briscola.alt/2&&mouseY>=briscola.y-briscola.larg/2&&mouseY<=briscola.y+briscola.larg/2&&nCarteRimaste>0) {
      //cursor(HAND);
      imageMode(CENTER);
      image(retroCarta, width-width/10, height/2, 57*width/530, 100*width/530);
      aggiornaBriscola();
    } else {
      //cursor(ARROW);
      aggiornaBriscola();
      imageMode(CENTER);
      image(retroCarta, width-width/10, height/2, 57*width/530, 100*width/530);
    }
  }
}

void musicaEColore() {
  stroke(255-rc, 255-gc, 255-bc);
  noFill();
  strokeWeight(width/1000);
  square(width-width/5, height-height/7, 20);
  textAlign(LEFT, CENTER);
  text("CAMBIA COLORE", width-width/5+40, height-height/7);
}

void turniEPunti() {
  fill(255-rc, 255-gc, 255-bc);
  textSize(width/55);
  textAlign(RIGHT);
  text("PUNTI: "+puntiCpu, width-width/192, width/29);
  text("PUNTI: "+puntiGiocatore, width-width/192, height-height/27);
  textAlign(CENTER, CENTER);
  if (nCarteRimaste>0) {
    text("CARTE RIMASTE: "+nCarteRimaste, width-width/10, briscola.y+width/9);
  }
  if (aChiTocca==1) {
    fill(255-rc, 255-gc, 255-bc);
    circle(width/90, height-width/90, width/90);
  } else {
    fill(255-rc, 255-gc, 255-bc);
    circle(width/90, width/90, width/90);
  }
}

void aggiornaBriscola() {
  if (briscola.x>width-briscola.alt/2-width/10+briscola.larg/2) {
    briscola.x-=10;
  }
  if (nCarteRimaste>0) {
    translate(briscola.x, briscola.y);
    rotate(-PI/2);
    image(briscola.immagineCarta, 0, 0, briscola.larg, briscola.alt);
    rotate(+PI/2);
    translate(-briscola.x, -briscola.y);
  }
}

void aggiornaPunti() {
  if (chiHaPreso==1) {
    puntiGiocatore=puntiGiocatore+g1.carteInMano[cartaDaAvanzareGiocatore].valore+cpu.carteInMano[cartaDaAvanzareCpu].valore;
  } else {
    puntiCpu=puntiCpu+g1.carteInMano[cartaDaAvanzareGiocatore].valore+cpu.carteInMano[cartaDaAvanzareCpu].valore;
  }
}

void daiCarte() {
  int r;
  do {
    r=(int)random(1, 41);
    constrain(r, 1, 40);
  } while (carteDisponibili[r-1]==false);
  carteDisponibili[r-1]=false;
  mazzo[r-1]=new Carta(r, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  g1.carteInMano[indiceg]=mazzo[r-1];
  g1.carteInMano[indiceg].x=g1.carteInMano[indiceg].larg*(indiceg+1);
  g1.carteInMano[indiceg].y=height-g1.carteInMano[indiceg].alt/2;
  do {
    r=(int)random(1, 41);
    constrain(r, 1, 40);
  } while (carteDisponibili[r-1]==false);
  carteDisponibili[r-1]=false;
  mazzo[r-1]=new Carta(r, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  cpu.carteInMano[indicec]=mazzo[r-1];
  cpu.carteInMano[indicec].x=cpu.carteInMano[indicec].larg*(indicec+1);
  cpu.carteInMano[indicec].y=0;
  indiceg=0;
  indicec=0;
  hannoGiocatoEntrambi=false;
  cartaDaAvanzareCpu=-1;
  cartaDaAvanzareGiocatore=-1;
  haTerminato=false;
  haTerminatodiDareLecarte=true;
  if (nCarteRimaste>0) {
    nCarteRimaste-=2;
  }
}

void daiUltimeCarte() {
  int i, index=0;
  for (i=0; i<carteDisponibili.length; i++) {
    if (carteDisponibili[i]==true) {
      index=i;
      carteDisponibili[i]=false;
      break;
    }
  }
  mazzo[index]=new Carta(i+1, width-width/10, height/2, 57*width/530, 100*width/530, 0);
  Carta penultima=mazzo[index];
  carteDisponibili[index]=false;
  if (chiHaPreso==1) {
    cpu.carteInMano[indicec]=briscola;
    g1.carteInMano[indiceg]=penultima;
  } else {
    g1.carteInMano[indiceg]=briscola;
    cpu.carteInMano[indicec]=penultima;
  }
  g1.carteInMano[indiceg].x=g1.carteInMano[indiceg].larg*(indiceg+1);
  g1.carteInMano[indiceg].y=height-g1.carteInMano[indiceg].alt/2;
  cpu.carteInMano[indicec].x=cpu.carteInMano[indicec].larg*(indicec+1);
  cpu.carteInMano[indicec].y=0;
  indiceg=0;
  indicec=0;
  hannoGiocatoEntrambi=false;
  cartaDaAvanzareCpu=-1;
  cartaDaAvanzareGiocatore=-1;
  haTerminato=false;
  haTerminatodiDareLecarte=true;
  if (nCarteRimaste>0) {
    nCarteRimaste-=2;
  }
}
