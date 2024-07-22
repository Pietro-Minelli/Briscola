class Giocatore {

  int nCarteInMano;
  Carta carteInMano[]=new Carta[3];
  boolean haGiocatoPerPrimo;
  Carta cartaGiocata;

  Giocatore(Carta c1, Carta c2, Carta c3, int n) {
    nCarteInMano=3;
    carteInMano[0]=c1;
    carteInMano[1]=c2;
    carteInMano[2]=c3;
    if (n==1) {
      for (int i=0; i<nCarteInMano; i++) {
        carteInMano[i].x=carteInMano[i].larg*(i+1);
        carteInMano[i].y=height-carteInMano[i].alt/2;
      }
    } else if (n==2) {
      for (int i=0; i<nCarteInMano; i++) {
        carteInMano[i].x=carteInMano[i].larg*(i+1);
        carteInMano[i].y=0;
      }
    }
    haGiocatoPerPrimo=false;
  }

  void show() {
    for (int i=0; i<nCarteInMano; i++) {
      imageMode(CENTER);
      image(carteInMano[i].immagineCarta, carteInMano[i].x, carteInMano[i].y, carteInMano[i].larg, carteInMano[i].alt);
    }
  }

  void showCpu() {
    for (int i=0; i<nCarteInMano; i++) {
      imageMode(CENTER);
      if (carteInMano[i].retro==true) {
       image(retroCarta, carteInMano[i].x, carteInMano[i].y, carteInMano[i].larg, carteInMano[i].alt);
       } else {
      image(carteInMano[i].immagineCarta, carteInMano[i].x, carteInMano[i].y, carteInMano[i].larg, carteInMano[i].alt);
      } 
    }
  }

  int update() {
    if (mousePressed&&mouseX>=carteInMano[0].x-carteInMano[0].larg/2&&mouseX<=carteInMano[0].x+carteInMano[0].larg/2&&mouseY>=height-carteInMano[0].alt&&carteInMano[0].edisponibile) {
      suonocarta.play();
      return 0;
    } else if (mousePressed&&mouseX>=carteInMano[1].x-carteInMano[1].larg/2&&mouseX<=carteInMano[1].x+carteInMano[1].larg/2&&mouseY>=height-carteInMano[1].alt&&carteInMano[1].edisponibile) {
      suonocarta.play();
      return 1;
    } else if (mousePressed&&mouseX>=carteInMano[2].x-carteInMano[2].larg/2&&mouseX<=carteInMano[2].x+carteInMano[2].larg/2&&mouseY>=height-carteInMano[2].alt&&carteInMano[2].edisponibile) {
      suonocarta.play();
      return 2;
    }
    return -1;
  }

  int updateCpu(Giocatore g1) {
    if (haGiocatoPerPrimo) {     
      return cercaDiDareIlPiuBasso();
    } else {
      if (g1.cartaGiocata.seme==briscola.seme) {
        if (g1.cartaGiocata.numero==3) {
          for (int i=0; i<nCarteInMano; i++) {
            if (carteInMano[i].numero==1&&carteInMano[i].seme==briscola.seme&&carteInMano[i].edisponibile) {
              return i;
            }
          }
        }
        return cercaDiDareIlPiuBasso();
      } else {
        int i=carichinoPiuAltoDiUnSeme();
        if (i!=10) {
          return carichinoPiuAltoDiUnSeme();
        }
        if (g1.cartaGiocata.valore>=10) {
          i=briscolinoConValoreBasso();
          if (i!=10) {
            return i;
          } else {
            i=caricoBriscolaConValoreBasso();
            if (i!=10) {
              return i;
            } else {
              i=scartinoConValoreBasso();
              if (i!=10) {
                return i;
              } else {
                return caricoConValoreBasso();
              }
            }
          }
        } else {
          return cercaDiDareIlPiuBasso();
        }
      }
    }
  }

  int cercaDiDareIlPiuBasso() {
    int i=scartinoConValoreBasso(); 
    if (i!=10) {
      return i;
    } else {
      i=briscolinoConValoreBasso();
      if (i!=10) {
        return i;
      } else {
        i=caricoConValoreBasso();
        if (i!=10) {
          return i;
        } else {
          i=caricoBriscolaConValoreBasso();
          return i;
        }
      }
    }
  }

  int carichinoPiuAltoDiUnSeme() {
    for (int j=0; j<nCarteInMano; j++) {
      if (this.carteInMano[j].valore==11&&this.carteInMano[j].valore>g1.cartaGiocata.valore&&this.carteInMano[j].seme==g1.cartaGiocata.seme&&carteInMano[j].edisponibile) {
        return j;
      }
      if (this.carteInMano[j].valore==10&&this.carteInMano[j].valore>g1.cartaGiocata.valore&&this.carteInMano[j].seme==g1.cartaGiocata.seme&&carteInMano[j].edisponibile) {
        return j;
      }
      if (this.carteInMano[j].valore==4&&this.carteInMano[j].valore>g1.cartaGiocata.valore&&this.carteInMano[j].seme==g1.cartaGiocata.seme&&carteInMano[j].edisponibile) {
        return j;
      }
      if (this.carteInMano[j].valore==3&&this.carteInMano[j].valore>g1.cartaGiocata.valore&&this.carteInMano[j].seme==g1.cartaGiocata.seme&&carteInMano[j].edisponibile) {
        return j;
      }
      if (this.carteInMano[j].valore==2&&this.carteInMano[j].valore>g1.cartaGiocata.valore&&this.carteInMano[j].seme==g1.cartaGiocata.seme) {
        return j;
      }
    }
    return 10;
  }

  int briscolinoConValoreBasso() {  //briscolino dal 2 al re eccetto il tre
    for (int i=2; i<=10; i++) {
      for (int j=0; j<cpu.nCarteInMano; j++) {
        if (i!=3&&cpu.carteInMano[j].numero==i&&cpu.carteInMano[j].seme==briscola.seme&&carteInMano[j].edisponibile) {
          return j;
        }
      }
    }
    return 10;
  }

  int scartinoConValoreBasso() {  //scartino dal 2 al re eccetto il tre
    for (int i=2; i<=10; i++) {
      for (int j=0; j<cpu.nCarteInMano; j++) {
        if (i!=3&&cpu.carteInMano[j].numero==i&&cpu.carteInMano[j].seme!=briscola.seme&&carteInMano[j].edisponibile) {
          return j;
        }
      }
    }
    return 10;
  }

  int caricoConValoreBasso() {
    for (int i=3; i>=1; i--) {
      for (int j=0; j<cpu.nCarteInMano; j++) {
        if (i!=2&&cpu.carteInMano[j].numero==i&&cpu.carteInMano[j].seme!=briscola.seme&&carteInMano[j].edisponibile) {
          return j;
        }
      }
    }
    return 10;
  }

  int caricoBriscolaConValoreBasso() {
    for (int i=3; i>=1; i--) {
      for (int j=0; j<cpu.nCarteInMano; j++) {
        if (i!=2&&cpu.carteInMano[j].numero==i&&cpu.carteInMano[j].seme==briscola.seme&&carteInMano[j].edisponibile) {
          return j;
        }
      }
    }
    return 10;
  }

  void chiHaPreso(int i) {
    if (g1.carteInMano[i].seme==briscola.seme&&cpu.cartaGiocata.seme!=briscola.seme) {
      aChiTocca=1;
      chiHaPreso=1;
    } else if (g1.carteInMano[i].valore>cpu.cartaGiocata.valore&&g1.carteInMano[i].seme==cpu.cartaGiocata.seme) {
      aChiTocca=1;
      chiHaPreso=1;
    } else if (g1.carteInMano[i].numero>cpu.cartaGiocata.numero&&g1.carteInMano[i].seme==cpu.cartaGiocata.seme&&g1.carteInMano[i].numero!=1&&g1.carteInMano[i].numero!=3&&cpu.cartaGiocata.numero!=1&&cpu.cartaGiocata.numero!=3) {
      aChiTocca=1;
      chiHaPreso=1;
    } else {
      aChiTocca=2;
      chiHaPreso=2;
    }
  }

  void chiHaPresoCpu(int i) { // metti equals
    if (cpu.carteInMano[i].seme.equals(briscola.seme)&&g1.cartaGiocata.seme!=briscola.seme) {
      chiHaPreso=2;
      aChiTocca=2;
    } else if (cpu.carteInMano[i].valore>g1.cartaGiocata.valore&&cpu.carteInMano[i].seme==g1.cartaGiocata.seme) {
      chiHaPreso=2;
      aChiTocca=2;
    } else if (cpu.carteInMano[i].numero>g1.cartaGiocata.numero&&cpu.carteInMano[i].seme==g1.cartaGiocata.seme&&cpu.carteInMano[i].numero!=1&&cpu.carteInMano[i].numero!=3&&g1.cartaGiocata.numero!=1&&g1.cartaGiocata.numero!=3) {
      chiHaPreso=2;
      aChiTocca=2;
    } else {
      chiHaPreso=1;
      aChiTocca=1;
    }
  }
}
