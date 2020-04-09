import 'package:admin_app/Animation/FadeAnimation.dart';
import 'package:admin_app/screens/authenticate/register.dart';
import 'package:admin_app/screens/home/home.dart';
import 'package:admin_app/services/auth.dart';
import 'package:admin_app/shared/constants.dart';
import 'package:admin_app/shared/loading.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;


  // text field state
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : Scaffold(
      resizeToAvoidBottomInset:
      false, // to avoid ugly overflow of typing area.
      backgroundColor: Colors.white,
      body: Builder(builder :(context) {
        return SingleChildScrollView(
          child: SafeArea(
            top: false,
            bottom: true,
            left: true,
            right: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 250,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: -40,
                        height: 250,
                        width: width,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                      AssetImage('assets/background.png'),
                                      fit: BoxFit.fill)),
                            )),
                      ),
                      Positioned(
                        top: -20,
                        right: -10,
                        height: 248,
                        width: width + 20,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/background_log.png'),
                                      fit: BoxFit.fill)),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          1.5,
                          Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                      SizedBox(
                        height: 15,
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
                      FadeAnimation(
                          1.7,
                          Center(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Color.fromRGBO(196, 135, 198, 1)),
                              ))),
                      SizedBox(
                        height: 30,
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
                                    'Sign In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if(_formKey.currentState.validate()){
                                     // setState(() => loading = true);
                                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                      if(result == null) {
                                        SnackBar mySnackBar = SnackBar(
                                          content:
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.error),
                                              SizedBox(width: 10,),
                                              Text('Verify your email or Check credentials'),
                                            ],
                                          ),
                                        );
                                        Scaffold.of(context).showSnackBar(mySnackBar);
                                        setState(() {
                                          loading = false;
                                          error = 'Could not sign in with those credentials';
                                        });
                                      }
                                      else{
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Home()));
                                      }
                                    }
                                  }),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          Center(
                              child: GestureDetector(
                                  onTap: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Register()));
                                  },
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(
                                        color:
                                        Color.fromRGBO(49, 39, 79, .6)),
                                  )))),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

}
