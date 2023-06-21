import 'package:flutter/material.dart';
import 'package:database/connection.dart'; // Asumiendo que el archivo se llama "connection.dart"

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Connection crud = Connection();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('CRUD Example'),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: crud
              .getAll(), // Asumiendo que getAll() devuelve una lista de mapas
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['name']),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No data found.'),
              );
            }
          },
        ),
      ),
    );
  }
}
