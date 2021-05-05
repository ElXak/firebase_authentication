import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future? loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future? signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return authResult.user != null;
    } catch (e) {
      return e.toString();
    }
  }
}
