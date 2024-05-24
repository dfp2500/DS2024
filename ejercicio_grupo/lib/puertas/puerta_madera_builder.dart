import 'puerta_builder.dart';
import 'puerta.dart';

class PuertaMaderaBuilder extends PuertaBuilder {
  PuertaMaderaBuilder() : super() {
    reset(); 
  }

  void reset() {
    puerta = Puerta();
    puerta.id = null;
    puerta.material = "Madera";
  }

  @override
  void setPinchos() {
    puerta.pinchos = 100;
  }

  @override
  void setCerradura() {
    puerta.cerradura = 50;
  }

  @override
  void setBarricada() {
    puerta.barricada = 150;
  }

  @override
  Puerta build() {
    Puerta puerta = this.puerta;
    reset();
    return puerta;
  }
}