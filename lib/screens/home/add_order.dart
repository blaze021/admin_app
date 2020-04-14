import 'dart:io';

import 'package:admin_app/Animation/FadeAnimation.dart';
import 'package:admin_app/screens/home/home.dart';
import 'package:admin_app/services/database.dart';
import 'package:admin_app/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddOrder extends StatefulWidget {
  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  String fileType = '';
  File _image;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  Future<File> imageFromFuture;
  String _uploadedFileURL = '';

  Future filePicker(BuildContext buildContext) async {
    try {
      await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
        setState(() {
          _image = image;
          fileName = Path.basename(_image.path);
        });
      });

      print(fileName);
      _uploadFile(_image, fileName);
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
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
  }

  final _formKey = GlobalKey<FormState>();
  String error = '';
  String itemID, assetName, assetDesc, assetMfd, assetType;

  Future<void> _uploadFile(File image, String filename) async {
    if (itemID != null) {
      StorageReference storageReference;
      storageReference =
          FirebaseStorage.instance.ref().child("assetFiles/$itemID");
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      final String url = (await downloadUrl.ref.getDownloadURL());
      print("URL is $url");

      setState(() {
        _uploadedFileURL = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context){
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05, 0, 0, 10),
                      child: Text(
                        'Add Assets Here',
                        style: TextStyle(fontSize: 30, fontFamily: 'Birdhouse'),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    FadeAnimation(
                        1.7,
                        Container(
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
                                        bottom:
                                        BorderSide(color: Colors.grey[200]))),
                                child: Form(
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                      hintText: 'Item ID:',
                                      labelText: 'Item id:',
                                    ),
                                    validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() => itemID = val);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Form(
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Asset Name',
                                        labelText: 'Asset Name'),
                                    validator: (val) => val == null
                                        ? 'Must enter the asset name'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => assetName = val);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Form(
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Asset Description',
                                        labelText: 'Asset description'),
                                    validator: (val) => val == null
                                        ? 'Must enter the description'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => assetDesc = val);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Form(
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Asset Type',
                                        labelText: 'Asset Type'),
                                    validator: (val) => val == null
                                        ? 'Must enter the asset type'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => assetType = val);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Form(
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Asset Manufacturing Year',
                                        labelText: 'MM/YYYY'),
                                    validator: (val) => val == null
                                        ? 'Must enter the manufacturing date'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => assetMfd = val);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 4,
                          10,
                          MediaQuery.of(context).size.width / 4,
                          10),
                      child: Center(
                        child: FadeAnimation(
                          1.8,
                          RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50), // Text(' Pick Image ')
                              ),
                              color: Colors.pink[400],
                              child: Text(
                                ' Pick Image ',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (itemID != null) {
                                  filePicker(context);
                                }
                                else{
                                  SnackBar mySnackBar = SnackBar(
                                    content:
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        SizedBox(width: 10,),
                                        Text('Enter all details first'),
                                      ],
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(mySnackBar);
                                }
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05, 10, 0, 10),
                      child: FadeAnimation(
                        1.8,
                        Row(
                          children: <Widget>[
                            Text(
                              'Preview',
                              style: TextStyle(
                                  fontFamily: 'Birdhouse', fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _image != null
                        ? FadeAnimation(
                      1.9,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          child: Image.file(_image, height: 150, width: 80),
                        ),
                      ),
                    )
                        : FadeAnimation(
                      1.9,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Container(
                          height: MediaQuery.of(context).size.width / 2,
                          width: MediaQuery.of(context).size.width / 2,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width / 4,
                          30,
                          MediaQuery.of(context).size.width / 4,
                          10),
                      child: Center(
                        child: FadeAnimation(
                          1.9,
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
                                    ' Add Asset ',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              onPressed: () async {
                                if (itemID != null) {
                                  try {
                                    await DatabaseService(uid: itemID)
                                        .updateOrder(
                                        itemID,
                                        assetName,
                                        assetDesc,
                                        assetType,
                                        assetMfd,
                                        _uploadedFileURL);
                                    Navigator.pushReplacement(
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
                                            'Enter all the details then Pick image'),
                                      ],
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(mySnackBar);
                                }
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ));
      },)
    );
  }
}
