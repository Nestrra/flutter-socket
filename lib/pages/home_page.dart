import 'dart:io';

import 'package:band_name/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 3),
    Band(id: '3', name: 'Heroes del silencio', votes: 5),
    Band(id: '4', name: 'Bon Jivi', votes: 7),
    Band(id: '5', name: 'Kraken', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BandName',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        print( ' id: ${band.id} ');
      },
      background: Container(
        padding:const EdgeInsets.only(left: 8),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child:  Text('Eliminar Banda',
            style: TextStyle(color: Colors.white,
              
            
            ),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name!),
        trailing: Text('${band.votes}'),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New band name'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                    child: const Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController.text))
              ],
            );
          });
    }

    showCupertinoDialog(
      context: context,
       builder: (_){
         return   CupertinoAlertDialog(
           title:const Text('New band name'),
           actions: <Widget>[
              CupertinoDialogAction(
               isDefaultAction: true,
               child:const Text('Add'),
               onPressed: ()=>addBandToList(textController.text), ),
                CupertinoDialogAction(
               isDefaultAction: true,
               child:const Text('Dismiss'),
               onPressed: ()=>Navigator.pop(context),
                )
           ],
         );

       }
      
       );
        
  }

  void addBandToList(String name) {
    if (name.length > 1) {
        bands.add(
          Band(id: DateTime.now().toString(), name: name, votes: 0)
        );
        setState(() {
          
        });
    }

    Navigator.pop(context);
  }
}
