import 'puerta_director.dart';
import 'puerta.dart';
import 'puerta_hierro_builder.dart';
import 'puerta_madera_builder.dart';

class FachadaPuerta {
  late PuertaDirector director;
  late PuertaHierroBuilder hierro;
  late PuertaMaderaBuilder madera;

  FachadaPuerta() {
    director = PuertaDirector();
    madera = PuertaMaderaBuilder();
    hierro = PuertaHierroBuilder();
  }

  int defensaPuerta(Puerta puerta) {
    return puerta.capacidadDefensiva();
  }
  
  Puerta createPuerta(String material, String nombre, bool cerradura, bool pinchos, bool barricada, String usuario) {
    return director.createPuerta(material == "madera" ? madera : hierro, nombre, cerradura, pinchos, barricada, usuario);
  }
}