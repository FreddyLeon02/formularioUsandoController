import 'package:database/models/person.dart';

class Group {
  final int id;
  final String name;
  final String code;
  final String state;
  final String logo;
  final String description;
  List<Person> persons;

  Group({
    required this.id,
    required this.name,
    required this.code,
    required this.state,
    required this.logo,
    required this.description,
    required this.persons,
  });
}
