import 'package:flutter/material.dart';

import 'package:PicsStore/content.dart';

var _validEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
    _email = TextEditingController(),
    _pass = TextEditingController(),
    _visibilityIcon = Icons.visibility,
    _hiddenPass = true,
    _emailLblColor,
    _passLblColor,
    _errTxt = 'Fill the form',
    _errColor = themeColor;

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  _passVisibility() => setState(() {
        _hiddenPass = !_hiddenPass;
        if (!_hiddenPass) {
          _visibilityIcon = Icons.visibility_off;
        } else {
          _visibilityIcon = Icons.visibility;
        }
      });

  _next() => setState(() {
        if (_validEmail.hasMatch(_email.text) && _email.text.isNotEmpty) {
          if (_pass.text.length >= 8) {
            Navigator.of(context).pushReplacementNamed('/home');
            _errColor = themeColor;
          } else {
            _errTxt = "Password can't be less than 8 digits";
            _errColor = errorColor;
          }
        } else {
          _errTxt = 'Enter a valid email';
          _errColor = errorColor;
        }
        FocusScope.of(context).requestFocus(new FocusNode());
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Image.asset('assets/imgs/default.png'),
            ),
            Text(
              _errTxt,
              style: TextStyle(
                color: _errColor,
                fontSize: fntSize,
              ),
            ),
            Container(
              child: textField(
                _email,
                'Email',
                autofocus: false,
                lblColor: _emailLblColor,
                prefixIcon: Icon(
                  Icons.alternate_email,
                ),
                keyboardT: TextInputType.emailAddress,
              ),
            ),
            Container(
              child: textField(
                _pass,
                'Password',
                autofocus: false,
                lblColor: _passLblColor,
                maxLength: 20,
                prefixIcon: Icon(
                  Icons.vpn_key,
                ),
                keyboardT: TextInputType.visiblePassword,
                isPass: _hiddenPass,
                maxLines: 1,
                suffixIcon: IconButton(
                  icon: Icon(_visibilityIcon),
                  color: Colors.black45,
                  onPressed: _passVisibility,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed('/signup'),
                child: Text(
                  'Signup now !',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: fntSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _next,
        child: Icon(Icons.login),
        backgroundColor: themeColor,
      ),
    );
  }
}
