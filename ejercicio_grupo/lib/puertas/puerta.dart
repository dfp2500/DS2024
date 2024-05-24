class Puerta {
  int? id;
  String? nombre;
  String? material;
  int? pinchos;
  int? cerradura;
  int? barricada;
  String? usuario;

  Puerta({this.id, this.nombre, this.material, this.cerradura, this.pinchos, this.barricada, this.usuario});

  int capacidadDefensiva() {
    return pinchos! + cerradura! + barricada!;
  }

  factory Puerta.fromJson(Map<String, dynamic> json) {
    return Puerta(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      material: json['material'] as String?,
      cerradura: json['cerradura'] as int?,
      pinchos: json['pinchos'] as int?,
      barricada: json['barricada'] as int?,
      usuario: json['usuario'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'material': material,
      'cerradura': cerradura,
      'pinchos': pinchos,
      'barricada': barricada,
      'usuario': usuario
    };
  }

  @override
  String toString() {
    return '$nombre: Material->$material Cerradura->$cerradura Pinchos->$pinchos Barricada->$barricada (Usuario: $usuario)';
  }
}