import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }
    // User object -> string uid
  // Auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  // Sign in anonymously
  Future<UserModel?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  //Sign Oout
  Future signOut() async{
    try {
      return _auth.signOut();
    } catch (e) {
      return null;
    }
  }


  //Register
  Future registerUser(String email, String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid : user!.uid).updateUserData("0", "New Brew Crew", 10000);
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  //Sign In
    Future singInUser(String email, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

}
