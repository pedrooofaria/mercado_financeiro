import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?format=json&key=516dbfbe';

//images
const backGround = "images/financialmarket.jpeg";

const iconMF1 = "images/economics1.png";
const iconMF2 = "images/capital-markets-business-financial1.png";

const flagBrazil = "images/flag-brasil1.png";
const flagUSA = "images/flag-usa1.png";
const flagFrance = "images/flag-france1.png";
const flagJapan = "images/flag-japan1.png";
const flagEurope = "images/flag-europe1.png";
const flagArgentina = "images/flag-argentina1.png";
const flagUKingdom = "images/flag-united-kingdom1.png";

const coinBitcoin = "images/coin-bitcoin1.png";
const coinDolar = "images/coin-dolar1.png";
const coinEuro = "images/coin-euro1.png";
const coinPound = "images/coin-libra1.png";
const coinPeso = "images/coin-peso1.png";

const iconBank = "images/banco1.png";

//strings
const b_Dolar = " DOLAR";
const b_Euro = " EURO";
const b_Peso = " PESO";
const b_Pound = " LIBRA";

const b_CoinBase = " COINBASE";
const b_Xdex = " XDEX";
const b_Foxbit = " FOXBIT";
const b_MBitcoin = " MERCADO BIT";

const b_Brazil = " IBOVESPA";
const b_USA = " NASDAQ";
const b_France = " CAC";
const b_Japan = " NIKKEI";

//tamanho fonte
const TAM = 18.0;

// Funcao mudar cor
Color corB(double result, String icon) {
  Color c1;

  if(icon == "bolsa"){
    if(result < 0){
      c1 = const Color(0xFFD50000);
      return c1;
    }
    else if(result > 0){
      c1 = const Color(0xFF00C853);
      return c1;
    } else {
      c1 = Color(0xFFFFFFFF);
      return c1;
    }
  } else {
    c1 = Color(0xFFFFFFFF);
    return c1;
  }

}

// Funcão mudar icone
// ignore: missing_return
Widget iconB(double result, String aux) {

  if(result < 0 && (aux == "bolsa")) {
    return Icon(Icons.arrow_drop_down, color: Color(0xFFD50000), size: 30.0);
  }
  else if(result > 0 && (aux == "bolsa")){
    return Icon(Icons.arrow_drop_up, color: Color(0xFF00C853), size: 30.0);
  } else if(aux == "bitcoinR" || aux == "bitcoinD"){
    return Image.asset(coinBitcoin);
  } else if(aux == "dolar"){
    return Image.asset(coinDolar);
  } else if(aux == "euro"){
    return Image.asset(coinEuro);
  } else if(aux == "libra"){
    return Image.asset(coinPound);
  } else if(aux == "peso"){
    return Image.asset(coinPeso);
  } else {
    return Icon(Icons.error_outline,color: Colors.white, size: 30.0);
  }

}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _resetFields(){
    setState(() {
      buildHead();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(iconMF1),
        title: Text(
          "\$   Mercado Financeiro   \$",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white,),
            onPressed: _resetFields,
          ),
        ],
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            backGround,
            fit: BoxFit.fill,
            height: 1000.0,
          ),
          buildHead()
        ],
      ),
    );
  }
}

Widget buildHead() {
  // Variaveis para retorno da API
  double dolar;
  double euro;
  double libra;
  double peso;

  double coinbase;
  double xdex;
  double foxbit;
  double mbitcoin;

  double ibovespa;
  double nasdaq;
  double cac;
  double nikkei;

  return FutureBuilder(
    future: getData(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        default:
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error ao carregar Dados!!!",
                style:
                TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
            euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
            libra = snapshot.data["results"]["currencies"]["GBP"]["buy"];
            peso = snapshot.data["results"]["currencies"]["ARS"]["buy"];

            coinbase = snapshot.data["results"]["bitcoin"]["coinbase"]["last"];
            mbitcoin = snapshot.data["results"]["bitcoin"]["mercadobitcoin"]["last"];

            ibovespa = snapshot.data["results"]["stocks"]["IBOVESPA"]["variation"];
            nasdaq = snapshot.data["results"]["stocks"]["NASDAQ"]["variation"];
            cac = snapshot.data["results"]["stocks"]["CAC"]["variation"];
            nikkei = snapshot.data["results"]["stocks"]["NIKKEI"]["variation"];

            return buildBody(dolar, euro, libra, peso, coinbase, mbitcoin, ibovespa, nasdaq, cac, nikkei);

          }
      }
    },
  );
}

Widget buildBody(double dolar, double euro, double libra, double peso,
                 double coinbase, double mbitcoin,
                 double ibovespa, double nasdaq, double cac, double nikkei) {

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 15.0),
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(00, 00, 66, 0.75), borderRadius: BorderRadius.circular(12)),
          child: Text(
            "COTAÇÃO MOEDAS",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 9.0),
            buildBox1(flagUSA,b_Dolar, dolar, "dolar"),
            SizedBox(width: 18.0),
            buildBox1(flagEurope, b_Euro, euro, "euro"),
          ],
        ),
        SizedBox(height: 9.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 9.0),
            buildBox1(flagUKingdom, b_Pound, libra, "libra"),
            SizedBox(width: 18.0),
            buildBox1(flagArgentina, b_Peso, peso, "peso"),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(00, 00, 66, 0.75), borderRadius: BorderRadius.circular(12)),
          child: Text(
            "COTAÇÃO BITCOIN",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 9.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 9.0),
            buildBox1(iconBank, b_CoinBase, coinbase, "bitcoinD"),
            SizedBox(width: 18.0),
            buildBox1(iconBank,b_MBitcoin, mbitcoin, "bitcoinR"),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(00, 00, 66, 0.75), borderRadius: BorderRadius.circular(12)),
          child: Text(
            "BOLSAS DE VALORES",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 9.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 9.0),
            buildBox1(flagBrazil,b_Brazil, ibovespa, "bolsa"),
            SizedBox(width: 18.0),
            buildBox1(flagUSA, b_USA, nasdaq, "bolsa"),
          ],
        ),
        SizedBox(height: 9.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 9.0),
            buildBox1(flagFrance, b_France, cac, "bolsa"),
            SizedBox(width: 18.0),
            buildBox1(flagJapan, b_Japan, nikkei, "bolsa"),
          ],
        ),
      ],
    ),
  );
}

Widget buildBox1(String flag, String name, double result, String icon) {
  return Container(
    width: 163.0,
    height: 84.0,
    decoration: BoxDecoration(color: Color.fromRGBO(25, 25, 112, 0.75), borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(" "),
              Image.asset(flag),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: TAM, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        buildBox2(result, icon),
      ],
    ),
  );
}

Widget buildBox2(double result, String icon) {

  String valor = result.toStringAsFixed(2);

  return Container(
    width: 90.0,
    height: 45.0,
    decoration: BoxDecoration(
      border: Border.all(width: 3.0, color: corB(result, icon)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("  "),
        iconB(result, icon),
        sinal(icon),
        Text(
          valor,
          style: TextStyle(color: Colors.white, fontSize: TAM),
          textAlign: TextAlign.center,
        ),
        porcento(icon),
      ],
    ),
  );
}

Widget sinal(String sinal){
  if(sinal == "dolar"){
    return Text(
      " USD \$",
      style: TextStyle(color: Colors.white, fontSize: TAM),
      textAlign: TextAlign.center,
    );
  } else if(sinal == "euro"){
    return Text(
      " EUR €",
      style: TextStyle(color: Colors.white, fontSize: TAM),
      textAlign: TextAlign.center,
    );
  } else if(sinal == "libra"){
    return Text(
      " GRB £",
      style: TextStyle(color: Colors.white, fontSize: TAM),
      textAlign: TextAlign.center,
    );
  } else if(sinal == "peso"){
    return Text(
      " ARS \$",
      style: TextStyle(color: Colors.white, fontSize: TAM),
      textAlign: TextAlign.center,
    );
  } else if(sinal == "bitcoinD") {
    return Text(
      " D\$",
      style: TextStyle(color: Colors.white, fontSize: TAM),
      textAlign: TextAlign.center,
    );
  } else if(sinal == "bitcoinR") {
    return Text(
      " R\$",
      style: TextStyle(color: Colors.white, fontSize: TAM),
      textAlign: TextAlign.center,
    );
  } else if(sinal == "bolsa") {
    return Text(" ");
  }
}

Widget porcento(String bolsa){
  if(bolsa == "bolsa"){
    return Text(
      " %",
      style: TextStyle(color: Colors.white, fontSize: TAM),
      textAlign: TextAlign.center,
    );
  } else {
    return Text(" ");
  }
}