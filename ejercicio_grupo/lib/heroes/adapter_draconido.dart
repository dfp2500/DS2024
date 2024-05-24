import 'draconido.dart';
import 'heroe.dart';

class AdapterDraconido implements Heroe {
  Draconido draconido;

  AdapterDraconido(this.draconido);

  @override
  int poder() {
    return draconido.poderDeRaza() * 3;
  }
}