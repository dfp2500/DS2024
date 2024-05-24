import 'dart:io';

import 'package:flutter/material.dart';
import 'fachada.dart';
import 'puertas/puerta.dart';
import 'puertas/GestorDePuertas.dart';

const List<String> listHeroes = <String>[
  'Grupo Pequeno',
  'Grupo Mediano',
  'Grupo Grande'
];

var poderHeroe = '';
var poderPuerta = '';
var atraviesa = '';

Fachada fachada = Fachada();

String currentUser = "Daniel";
List<String> users = ["Daniel", "Miguel", "Ricardo", "Oliver"];

bool puedePasar(String heroe, Puerta puerta) {
  return fachada.atravesar(heroe, puerta);
}

int poderH(String heroe) {
  return fachada.poderHeroe(heroe);
}

int poderP(Puerta puerta) {
  return fachada.poderPuerta(puerta);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Practica 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _heroImagePath = 'assets/EquipoPequeno.png';
  String _doorImagePath = 'assets/PuertaMadera.png';
  final GestorDePuertas _gestorDePuertas = GestorDePuertas([]);

  var heroe = 'Grupo Pequeno';
  Puerta? puerta;
  List<Puerta?> _puertasDelUsuario = [];

  @override
  void initState() {
    super.initState();
    _cargarPuertasIniciales();
  }

  void _cargarPuertasIniciales() async {
    try {
      await _gestorDePuertas.cargarPuertas(currentUser);
      setState(() {
        _puertasDelUsuario = _gestorDePuertas.mispuertas
            .where((puerta) => puerta.usuario == currentUser)
            .toList();
      });
    } catch (e) {
      print("Error loading tasks: $e");
    }
  }

  void _updateHeroImage(String value) {
    setState(() {
      heroe = value;
      if (value == 'Grupo Pequeno') {
        _heroImagePath = 'assets/EquipoPequeno.png';
      } else if (value == 'Grupo Mediano') {
        _heroImagePath = 'assets/EquipoMediano.png';
      } else {
        _heroImagePath = 'assets/EquipoGrande.png';
      }
    });
  }
    void _updateDoorImage(Puerta otraPuerta) {
    puerta = otraPuerta;
    setState(() {
      if (puerta!.material == "Madera" && puerta!.barricada == 0  && puerta!.pinchos == 0) {
        _doorImagePath = 'assets/PuertaMadera.png';
      } else if (puerta!.material == "Madera" && puerta!.barricada! > 0 && puerta!.pinchos! == 0) {
        _doorImagePath = 'assets/PuertaMaderaB.png';
      } else if (puerta!.material == "Madera" && puerta!.barricada! > 0 && puerta!.pinchos! > 0) {
        _doorImagePath = 'assets/PuertaMaderaByP.png';
      } else if (puerta!.material == "Madera" && puerta!.barricada! == 0 && puerta!.pinchos! >= 0) {
        _doorImagePath = 'assets/PuertaMaderaP.png';
      } else if (puerta!.material == "Hierro" && puerta!.barricada == 0  && puerta!.pinchos == 0) {
        _doorImagePath = 'assets/PuertaHierro.png';
      } else if (puerta!.material == "Hierro" && puerta!.barricada != 0  && puerta!.pinchos == 0) {
        _doorImagePath = 'assets/PuertaHierroB.png';
      } else if (puerta!.material == "Hierro" && puerta!.barricada != 0  && puerta!.pinchos != 0) {
        _doorImagePath = 'assets/PuertaHierroByP.png';
      } else {
        _doorImagePath = 'assets/PuertaHierroP.png';
      }
    });
  }


  void _updateDoor(String value) {
    setState(() {
      if (value == 'Crear Puerta') {
        _showCreateOrUpdateDoorDialog(null);
      } else {
        puerta = _puertasDelUsuario.firstWhere((puerta) => puerta?.nombre == value);
        if (puerta != null){
          _updateDoorImage(puerta!);
        }
        _showCreateOrUpdateDoorDialog(puerta);
      }
    });
  }

  void _showCreateOrUpdateDoorDialog(Puerta? puerta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateOrUpdateDoorDialog(
          puerta: puerta,
          onSave: (Puerta nuevaPuerta) async {
            if (puerta == null) {
              await _gestorDePuertas.agregar(nuevaPuerta);
            } else {
              await _gestorDePuertas.modificarComponentes(puerta, nuevaPuerta);
            }
            setState(() {
              _puertasDelUsuario = _gestorDePuertas.mispuertas
                  .where((puerta) => puerta.usuario == currentUser)
                  .toList();
            });
            _updateDoorImage(nuevaPuerta);
          },
          onDelete: (Puerta puertaAEliminar) async {
            await _gestorDePuertas.eliminar(puertaAEliminar);
            setState(() {
              _puertasDelUsuario = _gestorDePuertas.mispuertas
                  .where((puerta) => puerta.usuario == currentUser)
                  .toList();
            });
          },
        );
      },
    );
  }

  void _updateCurrentUser(String value) {
    if (users.contains(value)) {
      setState(() {
        currentUser = value;
        _cargarPuertasIniciales();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> listPuertas = _puertasDelUsuario.map((puerta) => puerta!.nombre!).toList();
    listPuertas.add('Crear Puerta');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: currentUser,
            onChanged: (String? newValue) {
              _updateCurrentUser(newValue!);
            },
            items: users.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButtonExample(
                    lista: listHeroes,
                    onChanged: _updateHeroImage,
                  ),
                  Image.asset(_heroImagePath),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButtonExample(
                    lista: listPuertas,
                    onChanged: _updateDoor,
                  ),
                  Image.asset(_doorImagePath),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            atraviesa,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Poder héroe: $poderHeroe'),
              const SizedBox(width: 20),
              Text('Poder puerta: $poderPuerta'),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (puerta != null && puedePasar(heroe, puerta!)) {
                  atraviesa = 'Atraviesa';
                  poderHeroe = poderH(heroe).toString();
                  poderPuerta = poderP(puerta!).toString();
                } else {
                  atraviesa = 'No atraviesa';
                  poderHeroe = poderH(heroe).toString();
                  poderPuerta = puerta != null ? poderP(puerta!).toString() : 'N/A';
                }
              });
            },
            child: const Text('Intentar atravesar'),
          ),
        ],
      ),
    );
  }
}


class CreateOrUpdateDoorDialog extends StatefulWidget {
  final Puerta? puerta;
  final Function(Puerta) onSave;
  final Function(Puerta) onDelete;

  const CreateOrUpdateDoorDialog({Key? key, this.puerta, required this.onSave, required this.onDelete})
      : super(key: key);

  @override
  _CreateOrUpdateDoorDialogState createState() => _CreateOrUpdateDoorDialogState();
}

class _CreateOrUpdateDoorDialogState extends State<CreateOrUpdateDoorDialog> {
  final TextEditingController _nombreController = TextEditingController();
  String _material = 'Madera';
  final TextEditingController _pinchosController = TextEditingController();
  final TextEditingController _cerraduraController = TextEditingController();
  final TextEditingController _barricadaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.puerta != null) {
      _nombreController.text = widget.puerta!.nombre!;
      _material = widget.puerta!.material!;
      _pinchosController.text = widget.puerta!.pinchos.toString();
      _cerraduraController.text = widget.puerta!.cerradura.toString();
      _barricadaController.text = widget.puerta!.barricada.toString();
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _pinchosController.dispose();
    _cerraduraController.dispose();
    _barricadaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear o actualizar puerta'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            DropdownButton<String>(
              value: _material,
              onChanged: (String? newValue) {
                setState(() {
                  _material = newValue!;
                });
              },
              items: <String>['Madera', 'Hierro']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _pinchosController,
              decoration: const InputDecoration(labelText: 'Pinchos'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cerraduraController,
              decoration: const InputDecoration(labelText: 'Cerradura'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _barricadaController,
              decoration: const InputDecoration(labelText: 'Barricada'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        if (widget.puerta != null)
          TextButton(
            child: const Text('Eliminar'),
            onPressed: () {
              widget.onDelete(widget.puerta!);
              Navigator.of(context).pop();
            },
          ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Guardar'),
          onPressed: () {
            final nuevaPuerta = Puerta(
              nombre: _nombreController.text,
              material: _material,
              pinchos: int.tryParse(_pinchosController.text) ?? 0,
              cerradura: int.tryParse(_cerraduraController.text) ?? 0,
              barricada: int.tryParse(_barricadaController.text) ?? 0,
              usuario: currentUser,
            );
            widget.onSave(nuevaPuerta);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class DropdownButtonExample extends StatelessWidget {
  final List<String> lista;
  final ValueChanged<String> onChanged;

  const DropdownButtonExample(
      {Key? key, required this.lista, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: lista.isNotEmpty ? lista.first : null,
      onChanged: (String? newValue) {
        onChanged(newValue!);
      },
      items: lista.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}