import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'package:scoped_multi_example/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.route: (BuildContext context) => HomePage(),
    DisplayPage.route: (BuildContext context) => DisplayPage(),
  };

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: MaterialApp(
          title: 'Scoped Model MultiPage Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
          routes: routes,
        )

        // home: DefaultTabController(
        //   length: 2,
        //   child: ScopedModel<AppModel>(
        //     model: AppModel(),
        //     child: Scaffold(
        //       appBar: AppBar(
        //         title: Text('Scoped Model Demo'),
        //         bottom: TabBar(
        //           tabs: <Widget>[
        //             Tab(
        //               icon: Icon(Icons.home),
        //               text: 'Home Page',
        //             ),
        //             Tab(
        //               icon: Icon(Icons.screen_rotation),
        //               text: 'Display',
        //             )
        //           ],
        //         ),
        //       ),
        //       body: TabBarView(
        //         children: <Widget>[
        //           HomePage(),
        //           DisplayPage(),
        //         ],
        //       ),
        //     ),
        //   ),
        // )
        );
  }
}

class HomePage extends StatefulWidget {
  static final String route = "Home-Page";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: controller,
            ),
          ),
          ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => RaisedButton(
                  child: Text('Add Item'),
                  onPressed: () {
                    Item item = Item(controller.text);
                    model.addItem(item);
                    setState(() => controller.text = '');
                  },
                ),
          ),
          RaisedButton(
            child: Text('Display Page'),
            onPressed: () {
              Navigator
                  .of(context)
                  .push(MaterialPageRoute(builder: (context) => DisplayPage()));
            },
          )
        ],
      )),
    );
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
