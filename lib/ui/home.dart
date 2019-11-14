import 'package:flutter/material.dart';
import 'package:quik_employer/service/authentication.dart';
import 'package:quik_employer/ui/myJob.dart';
import 'package:quik_employer/ui/profile.dart';

class Home extends StatefulWidget {
  Home({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          // The BuildContext must be from one of the Scaffold's children.
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              bottomNavigationBar: Container(
                child: Material(
                  color: Colors.white30,
                  child: new TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.card_travel),
                        text: 'Job',
                      ),
                      Tab(icon: Icon(Icons.list),
                          text: 'Request'),
                      Tab(icon: Icon(Icons.face),
                          text: 'Profile'),
                    ],
                    labelColor: Colors.deepOrangeAccent,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.all(5.0),
                    indicatorColor: Colors.deepOrangeAccent,
                  ),
                ),
              ),
              body: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  JobList(widget.auth, widget.userId, widget.logoutCallback),
                  Icon(Icons.map),
                  Profile(widget.auth, widget.userId, widget.logoutCallback),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
