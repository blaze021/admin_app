import 'dart:io';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future filePicker(BuildContext buildContext) async{
    try{
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
        setState(() {
          _image = image;
          fileName = Path.basename(_image.path);
        });
      });

    print(fileName);
    _uploadFile(_image, fileName);
    }on PlatformException catch (e) {
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
          }
      );
    }
  }



  Future<void> _uploadFile(File image,String filename) async{
    StorageReference storageReference;
    storageReference =
        FirebaseStorage.instance.ref().child("assetFiles/$filename");
    final StorageUploadTask uploadTask = storageReference.putFile(image);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    setState(() {
      _uploadedFileURL = url;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Container(
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
                  Center(child: Text('Selected File')),
                  _image != null
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                          child: Image.file(_image,height: 150,width: 80),
                        )
                      : Container(height: 150,color: Colors.blue,),
                  _image == null
                      ? RaisedButton(
                          child: Text('Choose File'),
                          onPressed: () async {
                           filePicker(context);
                          },
                          color: Colors.cyan,
                        )
                      : Container(),
                  /*
                  _image != null
                      ? RaisedButton(
                    child: Text('Clear Selection'),
                    onPressed: clearSelection,
                  )
                      : Container(),
                  */
                  Center(child: Text('Uploaded Image')),
                  _uploadedFileURL != null
                      ? Image.network(
                          _uploadedFileURL,
                          height: 150,
                        )
                      : Container(),
                ],
              ),
            ),
          )),
    );
  }
}
