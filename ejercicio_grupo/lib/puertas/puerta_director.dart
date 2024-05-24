import 'puerta_builder.dart';
import 'puerta.dart';

class PuertaDirector {
  Puerta createPuerta(PuertaBuilder puertaBuilder, String nombre, bool cerradura, bool pinchos, bool barricada, String usuario) {
    puertaBuilder.setNombre(nombre);
    cerradura ? puertaBuilder.setCerradura() : null;
    pinchos ? puertaBuilder.setPinchos() : null;
    barricada ? puertaBuilder.setBarricada() : null;
    puertaBuilder.setUsuario(usuario);
    return puertaBuilder.build();
  }
}