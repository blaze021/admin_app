import 'package:admin_app/screens/authenticate/authenticate.dart';
import 'package:admin_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: Swapper(),
    );
  }
}
class Swapper extends StatelessWidget{
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    if(user!=null){
      if(user.isEmailVerified){
        return Home();
      }
      else{
        return Authenticate();
      }
    }

    else{
      return Authenticate();
    }

  }
}

