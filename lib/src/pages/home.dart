import 'dart:io';

import 'package:band_names/models/banda.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'metallica', votes: 5),
    Band(id: '1', name: 'queen', votes: 3),
    Band(id: '1', name: 'guns & roses', votes: 7),
    Band(id: '1', name: 'rolling stones', votes: 2),
    Band(id: '1', name: 'pantera', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'nombre de bandas',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i]),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), elevation: 1, onPressed: addnewBand),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        print('direccion : $direction');
        print('id: ${band.id}');
        //TODO: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Quiatar esta madre',
              style: TextStyle(color: Colors.white),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addnewBand() {
    final textControllet = new TextEditingController();

    if (Platform.isAndroid) {
      //Android
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New banda:'),
            content: TextField(
              controller: textControllet,
            ),
            actions: [
              MaterialButton(
                child: Text('add'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textControllet.text),
              )
            ],
          );
        },
      );
    }

//para la version iOS
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('new band name'),
            content: CupertinoTextField(
              controller: textControllet,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('add'),
                onPressed: () => addBandToList(textControllet.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('dismiss'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //agregar
      //print(name);
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
