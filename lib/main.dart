import 'package:flutter/material.dart';
import 'package:hn_app/src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return new Future.delayed(const Duration(seconds: 1));
        },
        child: new ListView(
          children: _articles.map(_buildItem).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: new Text(
          article.text,
          style: TextStyle(fontSize: 24.0),
        ),
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("${article.commentsCount} comments"),
              new IconButton(
                icon: new Icon(Icons.launch),
                color: Colors.blue[300],
                onPressed: () async {
                  final fakeurl = "http://${article.domain}";
                  if (await canLaunch(fakeurl)) {
                    launch(fakeurl);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
