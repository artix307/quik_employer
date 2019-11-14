import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quik_employer/model/employer.dart';
import 'package:quik_employer/model/job.dart';
import 'package:quik_employer/service/authentication.dart';
import 'package:quik_employer/service/firebaseFirestoreService.dart';


import 'package:quik_employer/ui/addJob.dart';
import 'package:quik_employer/ui/jobDetail.dart';


class JobList extends StatefulWidget {
  JobList(this.auth, this.userId, this.logoutCallback);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Job> items;
  List<Employer> itemEmp;

  FirebaseFirestoreService db = new FirebaseFirestoreService();

  StreamSubscription<QuerySnapshot> jobSub;
  StreamSubscription<QuerySnapshot> empSub;

  @override
  void initState() {
    super.initState();
    items = new List();

    jobSub?.cancel();
    jobSub = db.getJobList().listen((QuerySnapshot snapshot) {
      final List<Job> jobs = snapshot.documents
          .map((documentSnapshot) => Job.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = jobs;
      });
    });

    itemEmp = new List();

    empSub?.cancel();
    empSub = db.getEmployerList().listen((QuerySnapshot snapshot) {
      final List<Employer> emps = snapshot.documents
          .map((documentSnapshot) => Employer.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.itemEmp = emps;
      });
    });

  }

  @override
  void dispose() {
    jobSub?.cancel();
    super.dispose();
  }

  void _NavigationToDetail(BuildContext context, Job job) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => JobDetail(job)),
    );
  }

  void _NavigateToAdd(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddJob(widget.auth, widget.userId, widget.logoutCallback)),
    );
  }

  List<Job> filter = new List();

  @override
  Widget build(BuildContext context) {
    final title = 'Posted Job';

    for(int i = 0; i < items.length; i++){
      if(items[i].empId == widget.userId){
        if(filter.isEmpty){
          filter.add(items[i]);
        }
        else{
          int c = 0;
          for(int x = 0; x < filter.length; x++){
            if(items[i].id == filter[x].id){
              c++;
            }
          }
          if(c == 0){
            filter.add(items[i]);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: filter != null
        ? ListView.builder(
      itemCount: filter.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Divider(height: 6.0),
            ListTile(
              title: Text('${filter[index].position}'),
              subtitle: Text('RM '+'${filter[index].salary}' + ' per ' + '${filter[index].salaryType}'),
              leading: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    color: Colors.orangeAccent,
                    image: new DecorationImage(
                        image: new NetworkImage(
                            'https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0019/2920/brand.gif?itok=-WG4-Sgc'
                        )
                    ),
                    shape: BoxShape.circle,
                  )),
              onTap: () => _NavigationToDetail(context, filter[index]),
            )
          ],
        );
      },
    )
      : Text(' Job list is empty'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _NavigateToAdd(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
