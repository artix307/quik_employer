import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quik_employer/model/employer.dart';
import 'package:quik_employer/service/authentication.dart';
import 'package:quik_employer/service/firebaseFirestoreService.dart';

class AddJob extends StatefulWidget{
  AddJob(this.auth, this.userId, this.logoutCallback);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<AddJob>{
  FirebaseFirestoreService db = new FirebaseFirestoreService();
  List<Employer> itemEmp;
  StreamSubscription<QuerySnapshot> empSub;

  @override
  void initState() {
    super.initState();


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


//  String salary = '100';
//  String salaryType = 'Hour';
//  String description = 'Testing discripsi';
//  String empId = '12345';
//  String benefit = 'nothing';
//  String requirement = 'degree';

  final position = TextEditingController();
  final salary = TextEditingController();
  final salaryType = TextEditingController();
  final description = TextEditingController();
  final requirement = TextEditingController();
  final benefit = TextEditingController();
  String empId;

  Employer data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    for (int i=0;i<itemEmp.length;i++){
      if(itemEmp[i].emp_id==widget.userId){
        data=itemEmp[i];
      }

    }

    return Scaffold(
      appBar: AppBar(title: Text('Add New Job'),),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: position ,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              controller: salary,
            ),
            TextFormField(
              controller: salaryType,
            ),
            TextFormField(
              controller: description,
            ),
            TextFormField(
              controller: requirement,
            ),
            TextFormField(
              controller: benefit,
            ),
            RaisedButton(
              onPressed: () {
                empId = data.emp_id;
                db.createJob(
                    position.text.toString(),
                    salary.text.toString(),
                    salaryType.text.toString(),
                    description.text.toString(),
                    empId,
                    benefit.text.toString(),
                    requirement.text.toString()
                )
                .then((_){Navigator.pop(context);});
              },
              child: Text('Add Job'),
            ),
          ],
        ),
      ),
    );
  }
}