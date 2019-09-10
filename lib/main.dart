import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest",
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
    debugShowCheckedModeBanner: false,
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SIFormState(); 
}

class SIFormState extends State<SIForm> {

  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Naira', 'Cedes', 'Pounds', "Riyal"];
  final _minimumPadding = 10.0;
  String _currentItemSelected = "Naira";
  TextEditingController principleController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  String displayResult = '';

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child : Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget> [
            _getImage(),
            Container(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principleController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter the Principle amount";
                  }
                  if (value.runtimeType == String) {
                          return 'Enter numbers only.';
                      }
                },
                decoration: InputDecoration(
                  labelText: "Principle",
                  hintText: "Example 1200",
                  labelStyle: textStyle,
                  errorStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please Enter the Rate of Interest value";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Rate of Interest",
                  hintText: "Just another number",
                  labelStyle: textStyle,
                  errorStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            
            Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (String value) {
                        if (value.isEmpty){
                          return "Please Enter the Term value";
                        }
                      },
                      decoration: InputDecoration(
                      labelText: "Term",
                      labelStyle: textStyle,
                      hintText: "Just another number",
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                  Container(margin: EdgeInsets.all(20.0)),
                    Expanded(
                          child: DropdownButton<String>(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String> (
                                value: value,
                                child: Text(value),
                              );
                              }).toList(),

                            value: _currentItemSelected,

                            onChanged: (String newValueSelected) {
                              _onDropDownItemSelected(newValueSelected);
                            },
                            
                          ),
                      ),
                    
                ],
              ),
            
            Padding(
              padding:  EdgeInsets.only(top: _minimumPadding * 2, bottom: _minimumPadding * 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text('Calculate', textScaleFactor: 1.5,),
                      elevation: 5.0,
                      onPressed: () {
                        setState(() {
                         if (_formKey.currentState.validate()) {
                           this.displayResult = _calculateSimpleInterest(); 
                         }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Reset', textScaleFactor: 1.5,),
                      elevation: 5.0,
                      onPressed: () {
                        setState(() {
                         _reset(); 
                        });
                      },
                    ),
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(this.displayResult, style: textStyle),
            ),
          ],
      )),
    ));
  }// end of the build method

  Widget _getImage() {
    AssetImage assetImage = AssetImage('images/car.jpg');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(child: image, padding: EdgeInsets.all(_minimumPadding * 5));
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;  //set new value as main dropdown item
    });
  }

  String _calculateSimpleInterest() {
    double principle = double.parse(principleController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double simpleInterest = (principle * roi * term) / 100;
    String result = "After $term years, your investment will be worth $simpleInterest ${this._currentItemSelected}";
    return result;
  }

  void _reset() {
    principleController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
