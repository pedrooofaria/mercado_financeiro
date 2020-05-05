import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

//import 'home_page.dart';

const request = "https://google.com";//'https://api.hgbrasil.com/finance?format=json&key=516dbfbe';

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

void main() {
  runApp(MaterialApp(
    home: Teste(),
    debugShowCheckedModeBanner: false,
  ));
}

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {

  double droga = 11.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Teste"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: Text("Cargando...", style: TextStyle(color: Colors.white, fontSize: 30.0),));
            default:
              //droga = snapshot.data["results"]["currencies"]["USD"]["buy"];
              return Container(color: Colors.green,);
              }
        }
      ),
    );
  }
}
