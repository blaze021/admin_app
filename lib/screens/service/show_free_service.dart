import 'package:admin_app/services/add_asset_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowFreeService extends StatefulWidget {
  final String assetName;

  ShowFreeService({this.assetName});

  @override
  _ShowFreeServiceState createState() => _ShowFreeServiceState();
}

class _ShowFreeServiceState extends State<ShowFreeService> {

  @override
  void initState() {
  AddAssetService(assetName: widget.assetName).deleteAssetFreeService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: Container(
        padding: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  Firestore.instance.collection('normalService').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: new Text('Loading...'));
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return SelectListTile(assetName: widget.assetName,serviceName: document['serviceName'],serviceDesc: document['serviceDesc'],packageAmount: document.data['packageAmount'],packageDuration: document.data['packageDuration'],);
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SelectListTile extends StatefulWidget {

  final assetName,serviceName,serviceDesc;
  final int packageDuration,packageAmount;

  SelectListTile({this.assetName,this.serviceName,this.packageAmount,this.packageDuration,this.serviceDesc});

  @override
  _SelectListTileState createState() => _SelectListTileState();
}

class _SelectListTileState extends State<SelectListTile> {

  bool isServiceChecked = false;

  /*
  @override
  void initState() {
    setState(() async{
      await AddAssetService(assetName: widget.assetName).deleteAssetFreeService();
    });
    super.initState();
  }
   */

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(color: Colors.red[100],
              child: ListTile(
                leading: Text(widget.serviceName),
                title: Column(
                  children: <Widget>[
                    Text(widget.packageDuration.toString()),
                    Text(widget.packageAmount.toString()),
                  ],
                ),
                subtitle: Text(widget.serviceDesc),
                trailing: Checkbox(value: isServiceChecked, onChanged: (bool value) async {
                  setState(() {
                    isServiceChecked = value;
                  });
                  print(isServiceChecked);
                  print(widget.serviceName);
                  if(isServiceChecked == true)
                    await AddAssetService(assetName: widget.assetName).updateAssetNameList(widget.serviceName, widget.serviceDesc, widget.packageDuration,widget.packageAmount);
                  else
                    await AddAssetService(assetName: widget.assetName).deleteServiceFromAsset(widget.assetName, widget.serviceName);
                }),
              ),),
          ),
          SizedBox(height: 6,)
        ],
      ),
    );
  }
}
