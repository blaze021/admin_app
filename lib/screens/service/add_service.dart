import 'package:admin_app/Animation/FadeAnimation.dart';
import 'package:admin_app/screens/home/home.dart';
import 'package:admin_app/services/add_service_database.dart';
import 'package:admin_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

enum ServiceType { normalService, premiumService }

class _AddServiceState extends State<AddService> {
  ServiceType _serviceType = ServiceType.normalService;

  String serviceType;

  String serviceName, serviceDesc;
  int packageDuration, packageAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.075,
              left: MediaQuery.of(context).size.width * 0.035,
              right: MediaQuery.of(context).size.width * 0.035,
              child: Material(
                elevation: 10,
                type: MaterialType.card,
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(23),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.96,
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.068,
                              MediaQuery.of(context).size.width * 0.06,
                              0.0,
                              MediaQuery.of(context).size.width * 0.02),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Serive Type:',
                                style: TextStyle(
                                    fontFamily: 'Birdhouse', fontSize: 20),
                              )),
                        ),
                        RadioListTile<ServiceType>(
                          title: const Text('Normal Service'),
                          value: ServiceType.normalService,
                          groupValue: _serviceType,
                          onChanged: (ServiceType value) async {
                            setState(() {
                              _serviceType = value;
                              print(_serviceType);
                              String service = _serviceType.toString();
                              print(service);
                              serviceType = service;
                            });
                          },
                        ),
                        RadioListTile<ServiceType>(
                          title: const Text('Premium Service'),
                          value: ServiceType.premiumService,
                          groupValue: _serviceType,
                          onChanged: (ServiceType value) {
                            setState(() {
                              _serviceType = value;
                              print(_serviceType);
                              String service = _serviceType.toString();
                              print(service);
                              serviceType = service;
                            });
                          },
                        ),
                        FadeAnimation(
                          1.7,
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    )
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: Form(
                                      child: TextFormField(
                                        decoration:
                                            textInputDecoration.copyWith(
                                          hintText: 'Service Name:',
                                          labelText: 'Service Name:',
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'Enter the service name'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => serviceName = val);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: Form(
                                      child: TextFormField(
                                        decoration:
                                            textInputDecoration.copyWith(
                                          hintText: 'Service description:',
                                          labelText: 'Service description:',
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'Enter the service description'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => serviceDesc = val);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: Form(
                                      child: TextFormField(
                                        decoration:
                                            textInputDecoration.copyWith(
                                          hintText: 'Package Duration:',
                                          labelText: 'Package Duration:',
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'Enter the Package Duration:'
                                            : null,
                                        onChanged: (val) {
                                          setState(() =>
                                              packageDuration = int.parse(val));
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: Form(
                                      child: TextFormField(
                                        decoration:
                                            textInputDecoration.copyWith(
                                          hintText: 'Package Amount:',
                                          labelText: 'Package Amount:',
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? 'Enter the Package Amount'
                                            : null,
                                        onChanged: (val) {
                                          setState(() =>
                                              packageAmount = int.parse(val));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          color: Colors.pink[400],
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                ' Add Service ',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onPressed: () async {
                            if (serviceName != null) {
                              try {
                                // await DatabaseService(uid: itemID)
                                //            .updateOrder(
                                //        itemID,
                                //        assetName,
                                //        assetDesc,
                                //        assetType,
                                //        assetMfd,
                                //        _uploadedFileURL);
                                print(serviceType);
                                await AddServiceDatabase(categoryServiceName: serviceName).updateCategoryService(serviceType,serviceName, serviceDesc, packageDuration, packageAmount);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              } on PlatformException catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Sorry...'),
                                        content:
                                            Text('Unsupported exception: $e'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            } else {
                              SnackBar mySnackBar = SnackBar(
                                content: Row(
                                  children: <Widget>[
                                    Icon(Icons.error),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        'Enter all the details then add a service '),
                                  ],
                                ),
                              );
                              Scaffold.of(context).showSnackBar(mySnackBar);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
