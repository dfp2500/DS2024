import 'elfo.dart';
import 'humano.dart';
import 'adapter_elfo.dart';
import 'adapter_draconido.dart';
import 'draconido.dart';

class FachadaHeroe {
  late Humano jose;
  late AdapterElfo marcille;
  late AdapterDraconido shenron;

  FachadaHeroe() {
    jose = Humano();
    marcille = AdapterElfo(Elfo());
    shenron = AdapterDraconido(Draconido());
  }

  int poderEquipoPequeno() {
    return jose.poder();
  }

  int poderEquipoMediano() {
    return jose.poder() + marcille.poder();
  }

  int poderEquipoGrande() {
    return jose.poder() + marcille.poder() + shenron.poder();
  }
}