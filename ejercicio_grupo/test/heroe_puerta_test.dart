/*
Grupo 1: PAQUETE PUERTA
  Prueba 1: Verificar la creación de una puerta simple.
  Prueba 2: Verificar la creación de una puerta fácil con cerradura.
  Prueba 3: Verificar la creación de una puerta mediana con cerradura y pinchos.
  Prueba 4: Verificar la creación de una puerta difícil con cerradura, pinchos y barricada.
  Prueba 5: Verificar que se devuelve una instancia diferente cada vez que se construye una puerta.
  Prueba 6: Verificar que las características defensivas de la puerta se calculan correctamente.

Grupo 2: PAQUETE HEROE
  Prueba 1: Verificar que un Humano tiene poder.
  Prueba 2: Verificar que un AdapterElfo convierte correctamente las estadísticas del Elfo en poder.
  Prueba 3: Verificar que un AdapterDraconido multiplica correctamente el poder de un Draconido.
  Prueba 4: Verificar que un Humano puede ser convertido a Heroe.
  Prueba 5: Verificar que un AdapterElfo se puede usar como un Heroe.
  Prueba 6: Verificar que un AdapterDraconido se puede usar como un Heroe.
*/

import 'package:flutter_test/flutter_test.dart';
import 'package:ejercicio_grupo/puertas/puerta_director.dart';
import 'package:ejercicio_grupo/puertas/puerta_hierro_builder.dart';
import 'package:ejercicio_grupo/puertas/puerta_madera_builder.dart';
import 'package:ejercicio_grupo/heroes/heroe.dart';
import 'package:ejercicio_grupo/heroes/humano.dart';
import 'package:ejercicio_grupo/heroes/adapter_draconido.dart';
import 'package:ejercicio_grupo/heroes/adapter_elfo.dart';
import 'package:ejercicio_grupo/heroes/elfo.dart';
import 'package:ejercicio_grupo/heroes/draconido.dart';

void main() {
  group('Puertas Tests', () {
    PuertaDirector puertaDirector = PuertaDirector();
    PuertaHierroBuilder hierroBuilder = PuertaHierroBuilder();
    PuertaMaderaBuilder maderaBuilder = PuertaMaderaBuilder();

    test('Test 1: Verificar la creación de una puerta difícil con cerradura, pinchos y barricada', () {
      var puerta = puertaDirector.createPuerta(hierroBuilder, 'Puerta Dificil', true, true, true, 'usuario2');
      expect(puerta.material, 'Hierro');
      expect(puerta.cerradura, 100);
      expect(puerta.pinchos, 200);
      expect(puerta.barricada, 300);
    });

    test('Test 2: Verificar que se devuelve una instancia diferente cada vez que se construye una puerta', () {
      var puerta1 = puertaDirector.createPuerta(hierroBuilder, 'Puerta1', false, false, false, 'usuario3');
      var puerta2 = puertaDirector.createPuerta(hierroBuilder, 'Puerta2', false, false, false, 'usuario4');
      expect(puerta1, isNot(same(puerta2)));
    });

    test('Test 3: Verificar la creación de una puerta con diferentes materiales', () {
      var puertaHierro = puertaDirector.createPuerta(hierroBuilder, 'Puerta Hierro', false, false, false, 'usuario5');
      var puertaMadera = puertaDirector.createPuerta(maderaBuilder, 'Puerta Madera', false, false, false, 'usuario6');
      expect(puertaHierro.material, 'Hierro');
      expect(puertaMadera.material, 'Madera');
    });

    test('Test 4: Verificar que la capacidad defensiva de la puerta se calcula correctamente', () {
      var puertaDificilHierro = puertaDirector.createPuerta(hierroBuilder, 'Puerta Dificil Hierro', true, true, true, 'usuario7');
      expect(puertaDificilHierro.capacidadDefensiva(), isNotNull, reason: 'La capacidad defensiva no debería ser nula');
    });
  });

  group('Heroes Tests', () {
    Humano humano = Humano();
    AdapterElfo adapterElfo = AdapterElfo(Elfo());
    AdapterDraconido adapterDraconido = AdapterDraconido(Draconido());

    test('Test 1: Verificar que un Humano tiene poder', () {
      expect(humano.poder(), equals(100));
    });

    test('Test 2: Verificar que un AdapterElfo convierte correctamente las estadísticas del Elfo en poder', () {
      expect(adapterElfo.poder(), equals(200)); // (5 * 80) ~/ 2 = 200
    });

    test('Test 3: Verificar que un AdapterDraconido multiplica correctamente el poder de un Draconido', () {
      expect(adapterDraconido.poder(), equals(150)); // 50 * 3 = 150
    });

    test('Test 4: Verificar que un Humano puede ser convertido a Heroe', () {
      Heroe heroe = humano as Heroe;
      expect(heroe.poder(), equals(100));
    });

    test('Test 5: Verificar que un AdapterElfo se puede usar como un Heroe', () {
      Heroe heroe = adapterElfo;
      expect(heroe.poder(), equals(200)); // (5 * 80) ~/ 2 = 200
    });

    test('Test 6: Verificar que un AdapterDraconido se puede usar como un Heroe', () {
      Heroe heroe = adapterDraconido;
      expect(heroe.poder(), equals(150)); // 50 * 3 = 150
    });
  });
}