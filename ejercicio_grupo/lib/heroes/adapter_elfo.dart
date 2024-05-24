import 'elfo.dart';
import 'heroe.dart';

class AdapterElfo implements Heroe {
  Elfo elfo;

  AdapterElfo(this.elfo);

  @override
  int poder() {
    return (elfo.espiritualidad() * elfo.mana()) ~/ 2;
  }
}
