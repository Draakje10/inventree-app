import 'package:InvenTree/widget/category_display.dart';
import 'package:InvenTree/widget/location_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_utils/qr_utils.dart';

import 'settings.dart';
import 'api.dart';
import 'preferences.dart';

import 'package:InvenTree/inventree/part.dart';

void main() async {

  // await PrefService.init(prefix: "inventree_");

  WidgetsFlutterBinding.ensureInitialized();

  // Load login details
  InvenTreeUserPreferences().loadLoginDetails();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InvenTree',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'InvenTree'),
    );
  }
}


class ProductList extends StatelessWidget {
  final List<InvenTreePart> _parts;

  ProductList(this._parts);

  Widget _buildPart(BuildContext context, int index) {
    InvenTreePart part;

    if (index < _parts.length) {
      part = _parts[index];
    }

    return Card(
        child: Column(
            children: <Widget>[
              Text('${part.name} - ${part.description}'),
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: _buildPart, itemCount: _parts.length);
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState() : super();

  void _login() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InvenTreeSettingsWidget()));
  }

  void _goHome() {
    // Reset the stack, go to "home"
    Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
  }

  void _showParts() {
    // Construct a top-level category display (initialize with a null category)
    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDisplayWidget(null)));
  }

  void _scanCode() async {
    QrUtils.scanQR.then((String result) {
      print("Scanned: $result");
    });
  }

  void _showStock() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDisplayWidget(null)));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        /*
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Menu",
          onPressed: null,
        )
        */
      ),
      drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                leading: new Image.asset("assets/image/icon.png",
                  fit: BoxFit.scaleDown,
                 ),
                  title: new Text("InvenTree"),
                  onTap: _goHome,
              ),
              new Divider(),
              new ListTile(
                title: new Text("Scan"),
                onTap: _scanCode,
              ),
              new ListTile(
                title: new Text("Parts"),
                onTap: _showParts,
              ),
              new ListTile(
                title: new Text("Stock"),
                onTap: _showStock,
              ),
              new Divider(),
              new ListTile(
                title: new Text("Settings"),
                leading: new Icon(Icons.settings),
                onTap: _login,
              ),
            ],
          )
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'InvenTree',
            ),
          ],
        ),
      ),
    );
  }
}
