import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';

void main() {
  runApp(new MaterialApp(home: new MyWidget()));
}

class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => new MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  String joke = '';

  Future<void> getJoke() async {
    var response = await http.get(
        Uri.parse("https://api.chucknorris.io/jokes/random"),
        headers: {"Accept": "application/json"});

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      joke = dataConvertedToJSON['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 172, 9, 126)),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Text('$joke',
                      style:
                          new TextStyle(color: Colors.black, fontSize: 20.0)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      child: Text('No'),
                      onPressed: getJoke,
                      color: Colors.red,
                    ),
                    Container(),
                    RaisedButton(
                      child: Text('Yes'),
                      onPressed: getJoke,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getJoke();
  }
}
