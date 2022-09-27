import 'dart:convert';

class Categoria {
  Categoria({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  Categoria copyWith({
    int? id,
    String? name,
  }) =>
      Categoria(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
