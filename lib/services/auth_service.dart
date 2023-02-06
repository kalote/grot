import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google sign in
  signInWithGoogle() async {
    // begin interactive sign in
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create new credentials
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // finally, sign user in
    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}
