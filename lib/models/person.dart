class Person {
  final int id;
  final String name;
  final String code;
  final String phone;
  final String state;

  Person({
    required this.id,
    required this.name,
    required this.phone,
    required this.code,
    required this.state,
  });

  factory Person.fromMap(Map<String, dynamic> json) => new Person(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        code: json["phone"],
        state: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
      };
}
