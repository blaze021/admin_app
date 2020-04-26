import 'package:admin_app/models/add_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAssetService {

  final String assetName;

  AddAssetService({this.assetName});

  final CollectionReference allAssetCollection = Firestore.instance.collection('allAsset');
  final CollectionReference assetFreeServiceCollection = Firestore.instance.collection('assetFreeService');


  Future<void> updateAssetNameList(String serviceName, String serviceDesc,int packageDuration, int packageAmount) async{
    return await allAssetCollection.document(assetName).collection('assetFreeService').document(serviceName).setData({
      'serviceName': serviceName,
      'serviceDesc': serviceDesc,
      'packageDuration': packageDuration,
      'packageAmount': packageAmount,
    });
  }

  //Delete assetData from the assetCart
  Future<void> deleteServiceFromAsset(String assetName,
      String serviceName) async {
    return await allAssetCollection
        .document(assetName)
        .collection('assetFreeService')
        .document(serviceName)
        .delete();
  }

  Future<void> deleteAssetFreeService() async {
    Firestore.instance
        .collection('allAsset')
        .document(assetName)
        .collection('assetFreeService')
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

  List<AddFreeService> _addFreeServiceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return AddFreeService(
        serviceName: doc.data['serviceName'] ?? '',
        serviceDesc: doc.data['serviceDesc'] ?? '',
        serviceDuration: doc.data['packageDuration'] ?? 0,
        serviceAmount: doc.data['packageAmount'] ?? 0,
      );
    }).toList();
  }

  Stream<List<AddFreeService>> get addedFreeServices {
    return assetFreeServiceCollection.snapshots()
        .map(_addFreeServiceListFromSnapshot);
  }
}
