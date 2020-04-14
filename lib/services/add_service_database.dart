import 'package:admin_app/models/service_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddServiceDatabase{
  final String categoryServiceName;
  AddServiceDatabase({ this.categoryServiceName });

  final CollectionReference normalServiceCollection = Firestore.instance.collection('normalService');
  final CollectionReference premiumServiceCollection = Firestore.instance.collection('premiumService');

  Future<void> updateCategoryService(String serviceType,String serviceName, String serviceDesc,int packageDuration, int packageAmount) async {
    if(serviceType == 'ServiceType.normalService'){
      return await normalServiceCollection.document(categoryServiceName).setData({
        'serviceType':serviceType,
        'serviceName': serviceName,
        'serviceDesc': serviceDesc,
        'packageDuration': packageDuration,
        'packageAmount': packageAmount,
      });
    }
    else{
      return await premiumServiceCollection.document(categoryServiceName).setData({
        'serviceType':serviceType,
        'serviceName': serviceName,
        'serviceDesc': serviceDesc,
        'packageDuration': packageDuration,
        'packageAmount': packageAmount,
      });
    }
  }

  List<ServiceModule> _addCategoryServiceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return ServiceModule(
        serviceType: doc.data['serviceType'] ?? '',
        serviceName: doc.data['serviceName'] ?? '',
        serviceDesc: doc.data['serviceDesc'] ?? '',
        packageDuration: doc.data['packageDuration'] ?? 0,
        packageAmount: doc.data['packageAmount'] ?? 0,
      );
    }).toList();
  }

  Stream<List<ServiceModule>> get addedPremiumServices {
    return premiumServiceCollection.snapshots()
        .map(_addCategoryServiceListFromSnapshot);
  }

  Stream<List<ServiceModule>> get addedNormalServices {
    return normalServiceCollection.snapshots()
        .map(_addCategoryServiceListFromSnapshot);
  }
}