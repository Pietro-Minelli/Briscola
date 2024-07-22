class Carta {

  PImage immagineCarta;
  int numero;
  String seme;
  float x;
  float y;
  float larg;
  float alt;
  int valore;
  boolean retro;
  boolean edisponibile;

  // Denari
  // Coppe
  // Bastoni
  // Spade

  Carta(int posizione, float xCarta, float yCarta, float l, float h,int n) {
    immagineCarta=loadImage("Carta"+posizione+".png");
    if (posizione<11) {
      seme="Denari";
      numero=posizione;
    } else if (posizione<21) {
      seme="Coppe";
      numero=posizione-10;
    } else if (posizione<31) {
      seme="Bastoni";
      numero=posizione-20;
    } else {
      seme="Spade";
      numero=posizione-30;
    }
    x=xCarta;
    y=yCarta;
    larg=l;
    alt=h;
    switch(numero) {
    case 1:
      valore=11;
      break;
    case 3:
      valore=10;
      break;
    case 8:
      valore=2;
      break;
    case 9:
      valore=3;
      break;
    case 10:
      valore=4;
      break;
    default:
      valore=0;
      break;
    }
    if(n==1){
      retro=false;
    }else{
      retro=true;
    }
    edisponibile=true;
  }
}
