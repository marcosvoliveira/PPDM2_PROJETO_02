  import 'package:flutter/material.dart';

  void main() {
    runApp(MaterialApp(
      home: Home(),
    ));
  }

  class Home extends StatefulWidget {
    @override
    _HomeState createState() => _HomeState();
  }

  class _HomeState extends State<Home> {
    TextEditingController pesoController = TextEditingController();
    TextEditingController alturaController = TextEditingController();

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String _infoText = "Informe seus dados!";

    void _limpaCampos() {
      pesoController.text = "";
      alturaController.text = "";
      setState(() {
        _infoText = "Informe seus dados!";
        _formKey = GlobalKey<FormState>();
      });
    }

    void _calcularIMC() {
      setState(() {
        double peso = double.parse(pesoController.text);
        double altura = double.parse(alturaController.text) / 100;
        double imc = peso / (altura * altura);
        if (imc < 18.6) {
          _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 18.6 && imc < 24.9) {
          _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 24.9 && imc < 29.9) {
          _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 29.9 && imc < 34.9) {
          _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 34.9 && imc < 39.9) {
          _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 40) {
          _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Cálculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.grey,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _limpaCampos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.grey,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Pesox (kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  controller: pesoController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  controller: alturaController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Texto vazio!";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calcularIMC();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
