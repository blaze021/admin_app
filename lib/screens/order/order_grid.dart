import 'dart:ui';

import 'package:admin_app/screens/service/show_free_service.dart';
import 'package:admin_app/screens/service/show_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderGrid extends StatefulWidget {
  @override
  _OrderGridState createState() => _OrderGridState();
}

class _OrderGridState extends State<OrderGrid> {
  //String assetName, assetType, assetMfd, itemID, assetDesc, uploadedFileURL;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('addOrder').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: new Text('Loading...'));
          default:
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: new GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: snapshot.data.documents.map((
                    DocumentSnapshot document) {
                  return GridAssetTile(assetName: document['assetName'],
                    assetId: document['itemID'],
                    uploadedURL: document['uploadedFileURL'],
                    assetMfd: document['assetMfd'],);
                }).toList(),

              ),
            );
        }
      },
    );
  }
}

class GridAssetTile extends StatefulWidget {

  final String assetMfd, uploadedURL, assetName, assetId;

  GridAssetTile(
      {this.assetName, this.assetId, this.uploadedURL, this.assetMfd});

  @override
  _GridAssetTileState createState() => _GridAssetTileState();
}

class _GridAssetTileState extends State<GridAssetTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowFreeService(assetName: widget.assetName,)));
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            color: Colors.white,
            child: Stack(children: <Widget>[
              Center(child: Image.network(widget.uploadedURL)),
              Positioned(top:1,
                  left:2,
                  right: 2,
                  child: Text(widget.assetId)),
              Positioned(right: 1,bottom: 3,child: Text(widget.assetName)),
              Positioned(right:1,bottom:1,child:Text(widget.assetMfd)),
            ],),
          ),
        ),
      ),
    );
  }
}
