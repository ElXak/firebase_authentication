import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future createUser(User user) async {
    try {
      await _userCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await _userCollectionReference.doc(uid).get();
      return User.fromData(userData.data()!);
    } catch (e) {
      return e.toString();
    }
  }
}
