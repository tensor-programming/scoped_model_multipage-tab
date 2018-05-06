import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:scoped_multi_example/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoped Model MultiPage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class DisplayPage extends StatelessWidget {
  static final String route = "Display-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Display Page'),
          actions: <Widget>[
            RaisedButton(
              child: Text('Back Home'),
              onPressed: () {
                Navigator
                    .of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            )
          ],
        ),
        body: Container(
          child: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => Column(
                children: model.items
                    .map((item) => ListTile(
                          title: Text(item.name),
                          onLongPress: () {
                            model.deleteItem(item);
                          },
                        ))
                    .toList()),
          ),
        ));
  }
}
