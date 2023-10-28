import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Metodo responsável para recuperar o cep via API
  _recuperarCep() async {
    String url = "https://viacep.com.br/ws/05566030/json";
    http.Response response;

    response = await http.get(Uri.parse(url));
    //Decodificar um objeto em json
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    print(
        "Resposta logradouro: ${logradouro} complemento: ${complemento} bairro: ${bairro} localidade: ${localidade}");

    //print("resposta: " + response.body);
    //print("resposta: " + response.statusCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            ElevatedButton(onPressed: _recuperarCep, child: Text("Clique aqui"))
          ],
        ),
      ),
    );
  }
}
