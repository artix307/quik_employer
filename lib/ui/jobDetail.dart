import 'package:flutter/material.dart';
import 'package:quik_employer/model/job.dart';
import 'package:quik_employer/service/firebaseFirestoreService.dart';

class JobDetail extends StatefulWidget {
  //const JobDetail(Job job, {Key key}) : super(key: key);

  final Job job;

  JobDetail(this.job);

  @override
  _JobDetail createState() => _JobDetail();
}

class _JobDetail extends State<JobDetail> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    final title = 'Job Details';

    Widget bigCircle = new Container(
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
          color: Colors.orangeAccent,
          image: new DecorationImage(
              image: new AssetImage('assets/images/profile.jpg')
          ),
          shape: BoxShape.circle,
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.orangeAccent,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.job.position,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                  Icons.attach_money
                              ),
                            ),
                            Text(
                              ''
                                  + widget.job.salary
                                  + ' Per '
                                  + widget.job.salaryType,
                              style: TextStyle(
                                  fontSize: 20.00
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                  Icons.account_balance
                              ),
                            ),
                            Container(
                              child: Text(
                                'Watsons',
                                style: TextStyle(
                                    fontSize: 20.0
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bigCircle
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment(-1.0, 0.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            color: Colors.orangeAccent,
            //color: Colors.orangeAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Job Description',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    widget.job.description,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment(-1.0, 0.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            color: Colors.orangeAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Job Requirement',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    widget.job.job_requirement,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}