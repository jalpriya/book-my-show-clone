import 'package:bookmyshow/Library.dart';
import 'package:bookmyshow/MusicTab.dart';
import 'package:bookmyshow/My.dart';
import 'package:flutter/material.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> with SingleTickerProviderStateMixin {
  late TabController controller;
  static var actionslist = ["My", "Music", "Talk", "Library"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(length: actionslist.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2E3336),
        titleSpacing: 0.0,
        actions: <Widget>[
          new Padding(
            padding: EdgeInsets.only(right: 10.0, bottom: 1.0),
            child: new Icon(Icons.settings),
          )
        ],
        title: TabBar(
            indicatorColor: Colors.transparent,
            isScrollable: true,
            controller: controller,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,
            tabs: actionslist
                .map((tab) =>
            new Text(
              tab,
              style: new TextStyle(fontSize: 18.0),
            ))
                .toList()),
      ),
      body: new TabBarView(
          controller: controller,
          children: [new My(), new MusicTab(), new MusicTab(), new Library()]),
    );
  }
}
