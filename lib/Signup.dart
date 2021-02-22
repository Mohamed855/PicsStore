import 'package:flutter/material.dart';

import 'package:PicsStore/content.dart';

var _validName = RegExp(r'[0-9.!#$%&*"+-/=?^_`@<>,";:\[\$\(\)\]{|}~]'),
    _validEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
    _fName = TextEditingController(),
    _lName = TextEditingController(),
    _usrName = TextEditingController(),
    _email = TextEditingController(),
    _pass = TextEditingController(),
    _phoneNum = TextEditingController(),
    _autoUsrName = 'username',
    _visibilityIcon = Icons.visibility,
    _hiddenPass = true,
    _fNameLblColor,
    _lNameLblColor,
    _emailLblColor,
    _passLblColor,
    _phoneNumLblColor,
    _errTxt = 'Fill the form',
    _errColor = themeColor;

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  void _changeUsrName(fName) => setState(() {
        if (_fName.text == '' && _lName.text == '') {
          return _autoUsrName = 'username';
        } else {
          return _autoUsrName = _fName.text.toLowerCase().replaceAll(' ', '') +
              _lName.text.toLowerCase().replaceAll(' ', '');
        }
      });

  _passVisibility() => setState(() {
        _hiddenPass = !_hiddenPass;
        if (!_hiddenPass) {
          _visibilityIcon = Icons.visibility_off;
        } else {
          _visibilityIcon = Icons.visibility;
        }
      });

  _next() => setState(() {
        if (!_fName.text.contains(_validName) &&
            !_lName.text.contains(_validName) &&
            _fName.text.length > 1 &&
            _lName.text.length > 1) {
          if (_validEmail.hasMatch(_email.text) && _email.text.isNotEmpty) {
            if (_pass.text.length >= 8) {
              if (_phoneNum.text.length == 10) {
                Navigator.of(context).pushReplacementNamed('/home');
                _errColor = themeColor;
              } else {
                _errTxt = 'Phone number must be 10 digits';
                _errColor = errorColor;
              }
            } else {
              _errTxt = "Password can't be less than 8 digits";
              _errColor = errorColor;
            }
          } else {
            _errTxt = 'Enter a valid email';
            _errColor = errorColor;
          }
        } else {
          _errTxt = 'Please enter a real name';
          _errColor = errorColor;
        }
        FocusScope.of(context).requestFocus(new FocusNode());
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: padding,
              right: padding,
              top: 50.0,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 166,
                      child: textField(
                        _fName,
                        'First Name',
                        autofocus: false,
                        lblColor: _fNameLblColor,
                        maxLength: 20,
                        onChange: _changeUsrName,
                      ),
                    ),
                    Container(
                      width: 166,
                      child: textField(
                        _lName,
                        'Last Name',
                        autofocus: false,
                        lblColor: _lNameLblColor,
                        maxLength: 20,
                        onChange: _changeUsrName,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: textField(
                    _usrName,
                    _autoUsrName,
                    autofocus: false,
                    lblColor: txtFieldColor.withOpacity(0.3),
                    prefixIcon: Icon(
                      Icons.person,
                      color: txtFieldColor.withOpacity(0.2),
                    ),
                    enabeled: false,
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
                Container(
                  child: textField(
                    _phoneNum,
                    'Phone Number',
                    autofocus: false,
                    lblColor: _phoneNumLblColor,
                    maxLength: 10,
                    maxLines: 1,
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    keyboardT: TextInputType.number,
                    prefixText: '+20 ',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: padding),
                  child: InkWell(
                    onTap: () =>
                        Navigator.of(context).pushReplacementNamed('/login'),
                    child: Text(
                      'have an account, Login now !',
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _next,
          child: Icon(Icons.login),
          backgroundColor: themeColor,
        ),
      );
}
