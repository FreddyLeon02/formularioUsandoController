import 'dart:async';
import 'dart:io';

import 'package:database/models/animal.dart';
import 'package:database/models/person.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PersonDatabaseProvider {
  PersonDatabaseProvider._();

  static final PersonDatabaseProvider db = PersonDatabaseProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "person.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Person ("
          "id integer primary key AUTOINCREMENT,"
          "name TEXT,"
          "code TEXT,"
          "phone TEXT,"
          "state TEXT"
          ")");
    });
  }

  addPersonToDatabase(Person person) async {
    Database? db = await database;
    var raw = await db!.insert(
      "Person",
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updatePerson(Person person) async {
    final db = await database;
    var response = await db!.update("Person", person.toMap(),
        where: "id = ?", whereArgs: [person.id]);
    return response;
  }

  Future<Person> getPersonWithId(int id) async {
    Database? db = await database;
    var response = await db!.query("Person", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty
        ? Person.fromMap(response.first)
        : Person(id: 0, name: "", phone: "", code: "", state: "");
  }

  Future<List<Person>> getAllPersons() async {
    final db = await database;
    var response = await db!.query("Person");
    List<Person> list = response.map((c) => Person.fromMap(c)).toList();
    return list;
  }

  deletePersonWithId(int id) async {
    final db = await database;
    return db!.delete("Person", where: "id = ?", whereArgs: [id]);
  }

  deleteAllPersons() async {
    final db = await database;
    db!.delete("Person");
  }
}

// ANIMAL

class AnimalDatabaseProvider {
  AnimalDatabaseProvider._();

  static final AnimalDatabaseProvider db = AnimalDatabaseProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "animal.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Animal ("
          "id integer primary key AUTOINCREMENT,"
          "name TEXT,"
          "type TEXT,"
          "place TEXT"
          ")");
    });
  }

  addAnimalToDatabase(Animal animal) async {
    Database? db = await database;
    var raw = await db!.insert(
      "Animal",
      animal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateAnimal(Animal animal) async {
    final db = await database;
    var response = await db!.update("Animal", animal.toMap(),
        where: "id = ?", whereArgs: [animal.id]);
    return response;
  }

  Future<Animal> getAnimalWithId(int id) async {
    Database? db = await database;
    var response = await db!.query("Animal", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty
        ? Animal.fromMap(response.first)
        : Animal(id: 0, name: "", type: "", place: "");
  }

  Future<List<Animal>> getAllAnimal() async {
    final db = await database;
    var response = await db!.query("Animal");
    List<Animal> list = response.map((c) => Animal.fromMap(c)).toList();
    return list;
  }

  deleteAnimalWithId(int id) async {
    final db = await database;
    return db!.delete("Animal", where: "id = ?", whereArgs: [id]);
  }

  deleteAllAnimals() async {
    final db = await database;
    db!.delete("Animal");
  }
}
