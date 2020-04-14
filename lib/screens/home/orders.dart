import 'package:admin_app/models/add_asset.dart';
import 'package:admin_app/screens/order/order_grid.dart';
import 'package:admin_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: MultiProvider(
       providers: [
         StreamProvider<List<AddOrder>>.value(value: DatabaseService().addedOrderDetails),
       ],
        child: Center(
          child: SizedBox(
            width: (MediaQuery.of(context).size.width) * 0.95,
            height: (MediaQuery.of(context).size.height) * 0.95,
            child: OrderGrid(),
          ),
        ),
      ),
    );
  }
}
