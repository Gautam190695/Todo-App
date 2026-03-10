
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signIn(String email, String password) async {
    final res = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return res.user;
  }

  Future<User?> signUp(String email, String password) async {
    final res = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return res.user;
  }

  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCred = await _auth.signInWithCredential(credential);
    return userCred.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
