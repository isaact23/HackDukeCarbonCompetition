import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:carbon_competition/carbon_calc.dart';

import '../device_uuid.dart';
import '../user_class.dart';

class DatabaseService {

  // 'FINAL'
  static String uid;

  // collection reference
  static final CollectionReference user_data = Firestore.instance.collection('user_data');
  static final CollectionReference carbon_use_data = Firestore.instance.collection('carbon_use_data');

  static Future updateUserData(User user) async {
    if (uid == null) {
      uid = await getDeviceUuid();
    }

    if (await checkIfDocExists(uid, 'user_data')) {
      print("exists");
    } else {
      print("no");
    }

    return await user_data.document(uid).setData({
      'user_heat_avg': user.user_heat_avg,
      'user_mpg': user.user_mpg
    });
  }
}

Future<bool> checkIfDocExists(String docId, String collection_name) async {
  try {
    // Get reference to Firestore collection
    var collectionRef = Firestore.instance.collection(collection_name);

    var doc = await collectionRef.document(docId).get();
    return doc.exists;
  } catch (e) {
    return false;
  }
}