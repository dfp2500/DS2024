import 'puerta_builder.dart';
import 'puerta.dart';

class PuertaHierroBuilder extends PuertaBuilder {
  PuertaHierroBuilder() : super() {
    reset(); 
  }

  void reset() {
    puerta = Puerta();
    puerta.id = null;
    puerta.material = "Hierro";
  }

  @override
  void setPinchos() {
    puerta.pinchos = 200;
  }

  @override
  void setCerradura() {
    puerta.cerradura = 100;
  }

  @override
  void setBarricada() {
    puerta.barricada = 300;
  }

  @override
  Puerta build() {
    Puerta puerta = this.puerta;
    reset();
    return puerta;
  }
}