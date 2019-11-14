import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quik_employer/model/employer.dart';
import 'package:quik_employer/model/job.dart';

final CollectionReference jobCollection = Firestore.instance.collection('jobs');
final CollectionReference employerCollection = Firestore.instance.collection('employers');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
  new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  //add data
  Future<Job> createJob(String position, String salary, String salaryType,
      String description, String empId, String benefit, String requirement) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(jobCollection.document());

      final Job job = new Job(
          ds.documentID, position, salary, salaryType, description, empId, benefit, requirement);
      final Map<String, dynamic> data = job.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Job.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  //can copy
  Stream<QuerySnapshot> getJobList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = jobCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  //update
  Future<dynamic> updateJob(Job job) async {
    final TransactionHandler updateTransacation = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(jobCollection.document(job.id));

      await tx.update(ds.reference, job.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransacation)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  //delete
  Future<dynamic> deleteJob(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(jobCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<Employer> createEmployer(String id, String picture, String name, String email, String phone,
      String address, String about, String rating, String counter) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(employerCollection.document());

      final Employer employer = new Employer(
          id, picture, name, phone, email, address, about, rating, counter);
      final Map<String, dynamic> data = employer.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Employer.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  //can copy
  Stream<QuerySnapshot> getEmployerList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = employerCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  //update
  Future<dynamic> updateEmployer(Employer employer) async {
    final TransactionHandler updateTransacation = (Transaction tx) async {
      final DocumentSnapshot ds =
      await tx.get(employerCollection.document(employer.id));

      await tx.update(ds.reference, employer.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransacation)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  //delete
  Future<dynamic> deleteEmployer(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(employerCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}