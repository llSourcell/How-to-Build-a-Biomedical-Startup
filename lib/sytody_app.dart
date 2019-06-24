import 'package:flutter/material.dart';
import 'package:fluttr_protorecorder/languages.dart';
import 'package:fluttr_protorecorder/transcriptor.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    print('lol');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SytodyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
    home:new Scaffold(
        backgroundColor: Color(0xff607d8b),
    body: Center(

      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Image.asset(
        'assets/sytody.png',
      ),
      Text(
        "Dr. Source",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Color(0xffffffff), fontWeight: FontWeight.bold, fontSize: 40.0, fontFamily: "Arial"),
      ),


      new Container(
      width: 300.0,

      child:TextFormField(
      decoration: InputDecoration(
      labelText: 'Username'
      ),
      ),

      ),
      new Container(
      width: 300.0,

      child:
      TextFormField(
      decoration: InputDecoration(
      labelText: 'Password'
      ),
      ),

      ),        SizedBox(height: 10),

      ButtonTheme(
      minWidth: 180.0,
      height: 50.0,
      child: RaisedButton(

      child: const Text("Login"), color: Colors.white,
      onPressed: () =>  runApp(new SytodyApp())
      ),
      ),
      SizedBox(height: 10),
      ButtonTheme(
      minWidth: 180.0,
      height: 50.0,

      child: RaisedButton(
      child: const Text("Sign up"), color: Colors.white,
      onPressed: () =>

      print('lol')
      ),
      )
      ])
    )));}


}


class SytodyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SytodyAppState();
}

class SytodyAppState extends State<SytodyApp> {
  Language selectedLang = languages.first;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Row(children: [
            new Image.asset('assets/sytody.png', fit: BoxFit.fitHeight),
            new Text('Doctor Source'),
          ]),
          backgroundColor: Colors.blueGrey,
          actions: [
            new PopupMenuButton<Language>(
              onSelected: _selectLangHandler,
              itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
            )
          ]),
        body: new TranscriptorWidget(lang: selectedLang),
      ));
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
    .map((l) => new CheckedPopupMenuItem<Language>(
    value: l,
    checked: selectedLang == l,
    child: new Text(l.name),
  ))
    .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }
}

