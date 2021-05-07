import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/post.dart';
import '../models/user.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> _postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await _usersCollectionReference.doc(uid).get();
      return User.fromData(userData.data()!);
    } catch (e) {
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      QuerySnapshot<Map<String, dynamic>> postsDocumentSnapshot =
          await _postsCollectionReference.get();
      if (postsDocumentSnapshot.docs.isNotEmpty) {
        return postsDocumentSnapshot.docs
            .map((snapshot) => Post.fromMap(snapshot.data()))
            .where((mappedItem) => mappedItem?.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }
}
