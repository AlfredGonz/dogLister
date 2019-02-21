import 'package:flutter/material.dart';

import 'package:http/http.dart' show get; // for making http requests
import 'models/dog_model.dart'; // dog model
import 'dart:convert'; // for parsing JSON strings
import 'widgets/card_list.dart'; // CardList widget


class App extends StatefulWidget //widget con estado: StatefullWidget
{
  createState()
  {
    return AppState();
  }
}

class AppState extends State<App>
{
  bool _loaderIsActive =false;
  List<DogModel> images = [];

  void fetchDog() async
  {
    setState(() { //actualiza el estado de un widget de estado
     _loaderIsActive =true; 
    });

    var response = await get('https://dog.ceo/api/breeds/image/random');
    var dogModel =DogModel(json.decode(response.body));

    setState(() {
     _loaderIsActive =false;
     images.add(dogModel); 
    });
  }


  Widget build(context)
  {
    return MaterialApp
    (
      home: Scaffold(
        //body: Container(), //actua como un marcador de posicion en pantalla
        body: Center(child: _loaderIsActive ==true ? CircularProgressIndicator() : CardList(images)),
        floatingActionButton: FloatingActionButton( //boton flotante
          child: Icon(Icons.refresh),
          onPressed: fetchDog,
          backgroundColor: Colors.deepPurpleAccent[700],
        ),
        appBar: AppBar(
          title: Text('Doggos'),
          backgroundColor: Colors.black54,
        ), 
      ),
    );
  }

  
}



