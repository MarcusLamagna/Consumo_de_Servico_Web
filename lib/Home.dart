import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Criando um controlador de Cep
  TextEditingController _controllerCep = TextEditingController();

  //Capturar o resultado direto no app
  String _resultado = "Resultado";

  //Metodo responsável para recuperar os dados via API
  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;

    response = await http.get(Uri.parse(url));
    print("resposta: " + response.body);
    //Decodificar um objeto em json
    Map<dynamic, dynamic> retorno = json.decode(response.body);
    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    //String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${cep}, ${logradouro}, ${bairro}, ${localidade}";
    });

    print(
        "Resposta cep: ${cep} logradouro: ${logradouro} bairro: ${bairro} localidade: ${localidade}");

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
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: "Digite o cep: exemplo: 05566030"),
              style: TextStyle(fontSize: 20),
              controller: _controllerCep,
            ),
            ElevatedButton(
                onPressed: _recuperarCep, child: Text("Clique aqui")),
            Text(_resultado)
          ],
        ),
      ),
    );
  }
}
