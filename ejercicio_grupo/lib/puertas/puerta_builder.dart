import 'puerta.dart';

abstract class PuertaBuilder {
  late Puerta puerta;

  void setPinchos();

  void setCerradura();

  void setBarricada();

  void setNombre(String nombre){
    puerta.nombre = nombre;
  }

  void setUsuario(String usuario){
    puerta.usuario = usuario;
  }

  Puerta build();
}