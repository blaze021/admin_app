import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderGrid extends StatefulWidget {
  @override
  _OrderGridState createState() => _OrderGridState();
}

class _OrderGridState extends State<OrderGrid> {
  String assetName, assetType, assetMfd, itemID, assetDesc, uploadedFileURL;

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
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Container(
                  color: Colors.yellow,
                  width:MediaQuery.of(context).size.width*0.95,
                  height: MediaQuery.of(context).size.height*0.95,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width:MediaQuery.of(context).size.width/3,
                          height: MediaQuery.of(context).size.width/3,
                          child: Image.network(document['uploadedFileURL'])),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: <Widget>[
                            Text(document['assetMfd']),
                            SizedBox(height:2),
                            Text(document['assetName']),
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text(document['itemID'])
                      ),

                    ],
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
