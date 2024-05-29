import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");
  final String uid;

  DatabaseService({required this.uid});

  Future updateUserData(String sugar, String name, int strength) async {
    try {
      return await brewCollection.doc(uid).set({
        'sugar': sugar,
        'name': name,
        'strength': strength,
      });
    } catch (e) {
      return null;
    }
  }

  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        name: snapshot['name'],
        sugar: snapshot['sugar'],
        strength: snapshot['strength']);
  }


  Stream<UserData?> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
  
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? '',
        sugar: doc.get('sugar') ?? '0',
        strength: doc.get('strength') ?? 0,
      );
    }).toList();
  }
}
