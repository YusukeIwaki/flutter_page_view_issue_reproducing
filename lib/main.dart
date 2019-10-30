import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: PageViewHome(),
    );
  }
}

class PageViewHome extends StatefulWidget {
  @override
  State createState() => PageViewHomeState();
}

class PageViewHomeState extends State {
  final List<String> pageHistories = [];
  int currentPage;

  PageController _pageController;

  @override
  void initState() {
    super.initState();

    currentPage = 20;
    _pageController =
        PageController(initialPage: currentPage, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 240,
            child: ListView(
              children: pageHistories.reversed.map((String item) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: List.generate(300, (i) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Text(
                    "[${i}ページ]",
                    textAlign: TextAlign.center,
                  ),
                );
              }),
              onPageChanged: (page) {
                setState(() {
                  pageHistories.add("onPageChanged: => ${page}");
                  currentPage = page;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text("<<"),
                onPressed: () {
                  _pageController.animateToPage(0,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeOutQuart,
                  ).then((_) {
                    setState(() {
                      pageHistories.add("animateToPage: completed");
                    });
                  });
                },
              ),
              Expanded(
                child: Text(
                  "[${currentPage}]",
                  textAlign: TextAlign.center,
                ),
              ),
              FlatButton(
                child: Text(">>"),
                onPressed: () {
                  _pageController.animateToPage(299,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeOutQuart,
                  ).then((_) {
                    setState(() {
                      pageHistories.add("animateToPage: completed");
                    });
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
