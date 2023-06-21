class Animal {
  final int id;
  final String name;
  final String type;
  final String place;

  Animal({
    required this.id,
    required this.name,
    required this.type,
    required this.place,
  });

  factory Animal.fromMap(Map<String, dynamic> json) => Animal(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        place: json["place"],
      );

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "type": type, "place": place};
}
