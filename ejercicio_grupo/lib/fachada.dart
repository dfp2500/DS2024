import 'puertas/puerta.dart';

import 'puertas/fachada_puerta.dart';
import 'heroes/fachada_heroe.dart';

class Fachada {
  FachadaHeroe fheroe = FachadaHeroe();
  FachadaPuerta fpuerta = FachadaPuerta();

  bool atravesar(String h, Puerta puerta) {
    bool resultado = false;
    if (h == 'Grupo Pequeno') {
      resultado = fheroe.poderEquipoPequeno() > fpuerta.defensaPuerta(puerta);
    } 
    else if (h == 'Grupo Mediano') {
      resultado = fheroe.poderEquipoMediano() > fpuerta.defensaPuerta(puerta);
    } 
    else if (h == 'Grupo Grande') {
      resultado = fheroe.poderEquipoGrande() > fpuerta.defensaPuerta(puerta);
    }

    return resultado;
  }

  int poderHeroe(String h){
    int poder=0;
    if (h =='Grupo Pequeno'){
      poder = fheroe.poderEquipoPequeno();
    }
    else if (h =='Grupo Mediano'){
      poder = fheroe.poderEquipoMediano();
    }
    else if (h =='Grupo Grande'){
      poder = fheroe.poderEquipoGrande();
    }

    return poder;
  }

  int poderPuerta(Puerta puerta){
    int poder=0;

    poder = fpuerta.defensaPuerta(puerta);

    return poder;
  }

  Puerta createPuerta(String material, String nombre, bool cerradura, bool pinchos, bool barricada, String usuario) {
    return fpuerta.createPuerta(material, nombre, cerradura, pinchos, barricada, usuario);
  }

}
