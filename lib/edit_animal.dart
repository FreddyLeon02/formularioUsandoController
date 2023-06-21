import 'package:database/database.dart';
import 'package:database/models/animal.dart';
import 'package:flutter/material.dart';

class EditAnimal extends StatefulWidget {
  final bool edit;
  final Animal animal;

  const EditAnimal(this.edit, {super.key, required this.animal});
  //: assert(edit == true);

  @override
  _EditAnimalState createState() => _EditAnimalState();
}

class _EditAnimalState extends State<EditAnimal> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController typeEditingController = TextEditingController();
  TextEditingController placeEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit == true) {
      nameEditingController.text = widget.animal.name;
      typeEditingController.text = widget.animal.type;
      placeEditingController.text = widget.animal.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.edit ? "Edit Animal" : "Add animal"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlutterLogo(
                    size: 100,
                  ),
                  textFormField(nameEditingController, "Name", "Enter Name",
                      Icons.person, widget.edit ? widget.animal.name : "a"),
                  textFormField(
                      typeEditingController,
                      "Tipo de animal",
                      "Enter animal",
                      Icons.place,
                      widget.edit ? widget.animal.type : "q"),
                  textFormField(placeEditingController, "Lugar", "Enter place",
                      Icons.place, widget.edit ? widget.animal.place : "e"),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      } else if (widget.edit == true) {
                        AnimalDatabaseProvider.db.updateAnimal(Animal(
                            name: nameEditingController.text,
                            type: typeEditingController.text,
                            id: widget.animal.id,
                            place: placeEditingController.text));
                        Navigator.pop(context);
                      } else {
                        await AnimalDatabaseProvider.db.addAnimalToDatabase(
                            Animal(
                                id: 0,
                                name: nameEditingController.text,
                                type: typeEditingController.text,
                                place: placeEditingController.text));
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  textFormField(TextEditingController t, String label, String hint,
      IconData iconData, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
        },
        controller: t,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
            prefixIcon: Icon(iconData),
            hintText: hint,
            labelText: label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
