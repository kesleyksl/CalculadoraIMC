
import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _info = "Informe seus dados";
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _resetField(){
    weightController.text = "";
    heightController.text = "";
    setState(() {

      _info="Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });


  }
void _calculate(){
    setState(() {

      double wheight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = wheight/ (height * height);
      if(imc<18.6){
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      }
      else if(imc < 24.9){
        _info = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      }
      else if(imc<18.6){
        _info = "Levemente Acima do Peso(${imc.toStringAsPrecision(3)})";
      }
      else if(imc<34.9){
        _info = "Obedidade Grau I (${imc.toStringAsPrecision(3)})";
      }
      else if(imc<39.9){
        _info = "Obesidade Grau II(${imc.toStringAsPrecision(3)})";
      }
      else if(imc>=40){
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetField)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
            key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Icon(Icons.person_outline, size: 120, color: Colors.green,),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green)
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: weightController,
              validator: (value){
                if(value.isEmpty || double.parse(value) <= 0){
                  return "Insira seu Peso:";
                }
              },
            ),

            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green)
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),
              controller: heightController,
              validator: (value){
                if(value.isEmpty || double.parse(value) <= 0){
                  return "Informe sua ALtura";
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 25.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      _calculate();
                    }
                  },
                  child: Text("Calcular",
                    style: TextStyle(color:Colors.white, fontSize: 25.0),),
                  color: Colors.green,
                ),
              ),
            ),
            Text(_info,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 25.0),)
          ],
        ),
        ),
      )
    );
  }
}
