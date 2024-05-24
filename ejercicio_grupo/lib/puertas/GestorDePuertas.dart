import 'dart:convert';
import 'package:http/http.dart' as http;
import 'puerta.dart';

class GestorDePuertas {
  List<Puerta> mispuertas = [];
  final String apiUrl = "http://localhost:3000/puertas";

  GestorDePuertas(this.mispuertas);


  Future<void> cargarPuertas(String usuario) async {
    final response = await http.get(Uri.parse('$apiUrl?usuario=$usuario'));
    if (response.statusCode == 200) {
      List<dynamic> puertasJson = json.decode(response.body);

      mispuertas.clear();
      mispuertas.addAll(puertasJson.map((json) => Puerta.fromJson(json)).toList());
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> agregar(Puerta puerta) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(puerta.toJson()),
    );
    if (response.statusCode == 201) {
      mispuertas.add(Puerta.fromJson(json.decode(response.body)));
    } else {
      throw Exception('Failed to add task: ${response.body}');
    }
  }

  Future<void> eliminar(Puerta puerta) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/${puerta.id}'),
    );
    if (response.statusCode == 200) {
      mispuertas.removeWhere((t) => t.id == puerta.id);
    } else {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> modificarComponentes(Puerta antigua, Puerta nueva) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/${antigua.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nombre': nueva.nombre,
        'material': nueva.material,
        'cerradura': nueva.cerradura,
        'pinchos': nueva.pinchos,
        'barricada': nueva.barricada,
      }),
    );

    if (response.statusCode == 200) {
      antigua.nombre = nueva.nombre;
      antigua.material = nueva.material;
      antigua.cerradura = nueva.cerradura;
      antigua.pinchos = nueva.pinchos;
      antigua.barricada = nueva.barricada;
    } else {
      throw Exception('Failed to update task');
    }
  }
}