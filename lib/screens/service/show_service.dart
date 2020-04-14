import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowService extends StatefulWidget {
  @override
  _ShowServiceState createState() => _ShowServiceState();
}

class _ShowServiceState extends State<ShowService> {
  final controller = PageController(initialPage: 1, viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('normalService').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: new Text('Loading...'));
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Material(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red[120],
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: ListTile(
                              title: new Text(document['serviceName']),
                              subtitle: new Column(
                                children: <Widget>[
                                  Text(document['serviceType']),
                                  Text(document['serviceDesc']),
                                  Text(document['packageDuration'].toString()),
                                  Text(document['packageAmount'].toString()),
                                ],
                              )),
                        ),
                      );
                    }).toList(),
                  );
              }
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('premiumService').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: new Text('Loading...'));
                default:
                  return new ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return Material(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red[120],
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: ListTile(
                              title: new Text(document['serviceName']),
                              subtitle: new Column(
                                children: <Widget>[
                                  Text(document['serviceType']),
                                  Text(document['serviceDesc']),
                                  Text(document['packageDuration']
                                      .toString()),
                                  Text(
                                      document['packageAmount'].toString()),
                                ],
                              )),
                        ),
                      );
                    }).toList(),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
