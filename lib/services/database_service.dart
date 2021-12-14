import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/models/user_model.dart';
import 'package:firebase_chat/utilities/constants.dart';

class DatabaseService {

  Future<UserModel> getUser(String userId) async {
    DocumentSnapshot userDoc = await usersRef.doc(userId).get();
    return UserModel.fromDoc(userDoc);
  }

  Future<List<UserModel>> searchUsers(String currentUserId, String name) async {
    QuerySnapshot usersSnap =
        await usersRef.where('name', isGreaterThanOrEqualTo: name).get();
    List<UserModel> users = [];
    for (var doc in usersSnap.docs) {
      UserModel user = UserModel.fromDoc(doc);
      if (user.id != currentUserId) {
        users.add(user);
      }
    }
    return users;
  }

}