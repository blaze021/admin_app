import 'package:admin_app/Animation/FadeAnimation.dart';
import 'package:admin_app/screens/authenticate/sign_in.dart';
import 'package:admin_app/services/auth.dart';
import 'package:admin_app/shared/constants.dart';
import 'package:admin_app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/reg_back_new.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            width: 80,
                            height: 200,
                            child: FadeAnimation(
                                1,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/light-1.png'))),
                                )),
                          ),
                          Positioned(
                            left: 140,
                            width: 80,
                            height: 160,
                            child: FadeAnimation(
                                1.3,
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/light-2.png'))),
                                )),
                          ),
                          Positioned(
                            child: FadeAnimation(
                                1.6,
                                Container(
                                  margin: EdgeInsets.only(top: 200),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 60,
                                        fontFamily: 'Pijamas',
                                      ),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(
                              1.8,
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
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
                                        key: _formKey,
                                        child: TextFormField(
                                          decoration:
                                              textInputDecoration.copyWith(
                                                  hintText: 'email',
                                                  labelText: 'Email',
                                                  labelStyle:
                                                      TextStyle(fontSize: 20)),
                                          validator: (val) => val.isEmpty
                                              ? 'Enter an email'
                                              : null,
                                          onChanged: (val) {
                                            setState(() => email = val);
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Form(
                                        child: TextFormField(
                                          obscureText: true,
                                          decoration:
                                              textInputDecoration.copyWith(
                                                  hintText: 'password',
                                                  labelText: 'Password'),
                                          validator: (val) => val.length < 6
                                              ? 'Enter a password 6+ chars long'
                                              : null,
                                          onChanged: (val) {
                                            setState(() => password = val);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            height: 35,
                          ),
                          FadeAnimation(
                              1.9,
                              Container(
                                height: 50,
                                child: Center(
                                  child: RaisedButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 70, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      color: Colors.pink[400],
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  email, password);
                                          FirebaseUser user = await FirebaseAuth
                                              .instance
                                              .currentUser();
                                          user.sendEmailVerification();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignIn()));
                                          if (result == null) {
                                            setState(() {
                                              loading = false;
                                              error =
                                                  'Please supply a valid email';
                                            });
                                          }
                                        }
                                      }),
                                ),
                              )),
                          SizedBox(
                            height: 35,
                          ),
                          FadeAnimation(
                            1.5,
                            GestureDetector(
                              onTap: () async {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignIn()));
                              },
                              child: Text("Already Signed Up?",
                                  style: TextStyle(
                                    fontFamily: 'Pijamas',
                                    fontSize: 30,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
