import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../locator.dart';
import '../models/user.dart' as userModel;
import 'firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  late userModel.User _currentUser;

  userModel.User get currentUser => _currentUser;

  Future? loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }

  Future? signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String role,
  }) async {
    try {
      UserCredential? authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create a new user profile on firestore
      _currentUser = userModel.User(
        id: authResult.user!.uid,
        email: email,
        fullName: fullName,
        userRole: role,
      );

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      if (e is PlatformException) return e.message;

      return e.toString();
    }
  }

  Future<bool> isUserLoggedIn() async {
    User? user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(User? user) async {
    if (user != null) {
      var getResult = await _firestoreService.getUser(user.uid);

      if (getResult is userModel.User) {
        _currentUser = getResult;
      }
    }
  }
}
