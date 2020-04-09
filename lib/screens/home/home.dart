import 'package:admin_app/screens/home/add_order.dart';
import 'package:admin_app/screens/home/admin_profile.dart';
import 'package:admin_app/screens/home/orders.dart';
import 'package:admin_app/screens/home/remove_order.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: Container(
          width: (MediaQuery
              .of(context)
              .size
              .width) * 0.9,
          height: (MediaQuery
              .of(context)
              .size
              .height) * 0.9,
          color: Colors.deepPurple,
          child: Center(
            child: GridView.count(crossAxisCount: 2,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>AdminProfile()));
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: (MediaQuery.of(context).size.width) * 0.4,
                      height: (MediaQuery.of(context).size.width) * 0.4,
                      color: Colors.white,
                      child: Center(child: Text('Admin Profile',style: TextStyle(fontFamily: 'Birdhouse'),)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Orders()));
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      width: (MediaQuery.of(context).size.width) * 0.4,
                      height: (MediaQuery.of(context).size.width) * 0.4,
                      color: Colors.white,
                      child: Center(child: Text('Orders ',style: TextStyle(fontFamily: 'Birdhouse'),)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddOrder()));
                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      width: (MediaQuery.of(context).size.width) * 0.4,
                      height: (MediaQuery.of(context).size.width) * 0.4,
                      color: Colors.white,
                      child: Center(child: Text('Admin add order',style: TextStyle(fontFamily: 'Birdhouse'),)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RemoveOrder()));
                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      width: (MediaQuery.of(context).size.width) * 0.4,
                      height: (MediaQuery.of(context).size.width) * 0.4,
                      color: Colors.white,
                      child: Center(child: Text('Admin remove order',style: TextStyle(fontFamily: 'Birdhouse'),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
