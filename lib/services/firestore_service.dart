import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/post.dart';
import '../models/user.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> _postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  final StreamController<List<Post?>> _postsController =
      StreamController<List<Post?>>.broadcast();

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
            .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem?.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    // Register the handler for the posts data change
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        List<Post?> posts = postsSnapshot.docs
            .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
            .where((mappedItem) => mappedItem?.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    return _postsController.stream;
  }

  Future deletePost(String id) async {
    await _postsCollectionReference.doc(id).delete();
  }

  Future updatePost(Post post) async {
    try {
      await _postsCollectionReference.doc(post.id).update(post.toMap());
    } catch (e) {
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }
}
