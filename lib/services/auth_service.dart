import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_chat/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Stream<auth.User?> get user => _auth.authStateChanges();

  Future<void> signUp(String name, String email, String password) async {
    try {
      final authResult = await  _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(authResult.user != null) {
        final token = await _messaging.getToken();
        usersRef.doc(authResult.user!.uid).set({
          'name': name,
          'email': email,
          'token': token,
        });
      }
    } on FirebaseException catch (e) {
      throw (e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      throw (e.toString());
    }
  }

  Future<void> logout() async {
    Future.wait([
      _auth.signOut(),
    ]);
  }
}
