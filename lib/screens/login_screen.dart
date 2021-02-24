import 'package:flutter/material.dart';
import 'package:picsStore/content.dart';
import 'package:provider/provider.dart';

import '../models/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _visibilityIcon = Icons.visibility, _hiddenPass = true;

  Map<String, String> _authData = {'email': '', 'password': ''};

  void _passVisibility() => setState(() {
        _hiddenPass = !_hiddenPass;
        if (!_hiddenPass) {
          _visibilityIcon = Icons.visibility_off;
        } else {
          _visibilityIcon = Icons.visibility;
        }
      });

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Invalid'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .logIn(_authData['email'], _authData['password']);
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'LogIn',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
          )
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: padding),
                child: orientation == Orientation.portrait
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/imgs/default.png',
                            height: WidgetsBinding
                                        .instance.window.viewInsets.bottom >
                                    0.0
                                ? 60
                                : MediaQuery.of(context).size.height / 4,
                          ),
                        ],
                      )
                    : SizedBox(child: null),
              ),
              Center(
                child: Container(
                  height: orientation == Orientation.portrait
                      ? 300
                      : double.infinity,
                  width: orientation == Orientation.portrait
                      ? double.infinity
                      : 400,
                  padding: EdgeInsets.symmetric(horizontal: padding * 2),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        //email
                        Container(
                          height: 80.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              )),
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'invalid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 50,
                        ),
                        //password
                        Container(
                          height: 80.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_visibilityIcon),
                                color: Colors.black45,
                                onPressed: _passVisibility,
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            cursorColor: Theme.of(context).primaryColor,
                            obscureText: _hiddenPass,
                            validator: (value) {
                              if (value.isEmpty || value.length <= 5) {
                                return 'invalid password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        Container(
                          height: 45.0,
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              'LogIn',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {
                              _submit();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
