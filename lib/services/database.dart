import 'package:admin_app/models/add_asset.dart';
import 'package:admin_app/models/user.dart';
import 'package:admin_app/models/user_reg_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference addOrderCollection = Firestore.instance.collection('addOrder');
  final CollectionReference userRegDetailCollection = Firestore.instance.collection('userRegDetails');
  final CollectionReference userHealthInfoCollection = Firestore.instance.collection('userHealthInfo');

  Future<void> updateUserData(String name, int mobNo, String email, int age, String sex, String dOB, String address, String assetMake, String assetType, String healthInfo) async {
    return await userRegDetailCollection.document(uid).setData({
      'name': name,
      'mobNo': mobNo,
      'email':email,
      'age':age,
      'sex':sex,
      'DOB':dOB,
      'address':address,
      'assetMake':assetMake,
      'assetType':assetType,
      'healthInfo':healthInfo,
    });
  }

  Future<void> updateUserHealthInfo(int height, int weight, String cySize, String runSize) async {
    return await userHealthInfoCollection.document(uid).setData({
      'height': height,
      'weight': weight,
      'cySize': cySize,
      'runSize': runSize,
    });
  }

  Future<void> updateOrder(String itemId,String assetName,String assetDesc,String assetType,String assetMfd,String uploadedFileURL) async {
    return await addOrderCollection.document(uid).setData({
      'itemID':itemId,
      'assetName':assetName,
      'assetDesc':assetDesc,
      'assetType':assetType,
      'assetMfd':assetMfd,
      'uploadedFileURL':uploadedFileURL,
    });
  }


  // brew list from snapshot
  List<AddOrder> _addOderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return AddOrder(
        itemId: doc.data['itemID'] ?? '',
        assetName: doc.data['assetName'] ?? '',
        assetDesc: doc.data['assetDesc'] ?? '',
        assetType: doc.data['assetType'] ?? 'None',
        assetMfd: doc.data['assetMfd'] ?? 'MM/YYYY',
        uploadedFileURL: doc.data['uploadedFileURL'] ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwallhere.com%2Fen%2Fwallpaper%2F231302&psig=AOvVaw2JnW3Wb0Qa5iTw8JUf9u_Z&ust=1586509677764000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIDq2KL_2ugCFQAAAAAdAAAAABAI',
      );
    }).toList();
  }

  List<UserRegDetails> _userRegDetailsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return UserRegDetails(
        name: doc.data['name'] ?? '',
        mobNo: doc.data['mobNo'] ?? 0,
        email: doc.data['email'] ?? '',
        age: doc.data['age'] ?? 0,
        sex: doc.data['sex'] ?? '',
        dOB: doc.data['DOB'] ?? 'DD/MM/YYYY',
        address: doc.data['address'] ?? '',
        assetMake: doc.data['assetMake'] ?? '',
        assetType: doc.data['assetType'] ?? '',
        healthInfo: doc.data['healthInfo'] ?? '',
      );
    }).toList();
  }

  List<UserHealthInfo> _userHealthInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return UserHealthInfo(
        height: doc.data['height'] ?? 0,
        weight: doc.data['weight'] ?? 0,
        cySize: doc.data['cySize'] ?? '',
        runSize: doc.data['runSize'] ?? '',
      );
    }).toList();
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid:snapshot.data['uid'],
    );
  }

// get userRegistrationDetails stream
  Stream<List<UserRegDetails>> get userRegistrationDetails {
    return userRegDetailCollection.snapshots()
        .map(_userRegDetailsListFromSnapshot);
  }

  // get userRegistrationDetails stream
  Stream<List<UserHealthInfo>> get userHealthInfoDetails {
    return userHealthInfoCollection.snapshots()
        .map(_userHealthInfoListFromSnapshot);
  }

  // get user doc stream
  Stream<User> get userUID {
    return userRegDetailCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

   // get addedOrderDetails stream
  Stream<List<AddOrder>> get addedOrderDetails {
    return addOrderCollection.snapshots()
        .map(_addOderListFromSnapshot);
  }

}