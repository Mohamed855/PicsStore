// import packages

import 'package:flutter/material.dart';

// global variables

int imgIndex = 0;
double padding = 20.0, borderRadius = 8.0, fntSize = 18.0;
Color themeColor = Colors.indigo,
    errorColor = Colors.red,
    txtFieldColor = Colors.black54;

// objects

GlobalKey<ScaffoldState> scaffoldKey;
RegExp validName = RegExp(r'[0-9.!#$%&*"+-/=?^_`@<>,";:\[\$\(\)\]{|}~]'),
    validEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
TextEditingController loginEmail = TextEditingController(),
    loginPass = TextEditingController(),
    signupFName = TextEditingController(),
    signupLName = TextEditingController(),
    signupUsrName = TextEditingController(),
    signupEmail = TextEditingController(),
    signupPass = TextEditingController(),
    signupPhoneNum = TextEditingController(),
    imgNameController = TextEditingController(),
    imgSrcController = TextEditingController(),
    editNameController = TextEditingController(),
    editSrcController = TextEditingController();

// store list

List imgUrls = [];

// floating action buttons (previous - delete - edit - next - gallery)

Widget floatingActionButton({
  String herotag,
  Function onPressed,
  Icon icon,
  Color backgroundColor,
}) =>
    FloatingActionButton(
      heroTag: herotag,
      onPressed: onPressed,
      child: icon,
      backgroundColor: backgroundColor,
    );

// madal bottom sheet

void madalBottomSheet(
  BuildContext ctx,
  Function addNewImg,
  TextEditingController nameTextController,
  TextEditingController srcTextController,
  String btnText,
) =>
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      isScrollControlled: true,
      context: ctx,
      builder: (_) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: padding,
            right: padding,
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              textField(
                nameTextController,
                'Image Name',
                maxLines: 100,
                autofocus: true,
                maxLength: 50,
              ),
              SingleChildScrollView(
                child: textField(
                  srcTextController,
                  'Image Url',
                  maxLines: 100,
                  autofocus: false,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: padding,
                      ),
                      child: RaisedButton(
                        color: themeColor,
                        textColor: Colors.white,
                        onPressed: addNewImg,
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            btnText,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

// text fields in modal bottom sheet

Widget textField(
  TextEditingController controller,
  String labelText, {
  bool autofocus,
  int maxLength,
  int maxLines,
  Color lblColor,
  bool enabeled = true,
  Icon prefixIcon,
  IconButton suffixIcon,
  TextInputType keyboardT = TextInputType.text,
  String prefixText = '',
  bool isPass = false,
  Function onChange,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.all(10),
          labelStyle: txtLblStyle(lblColor),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          counterText: "",
        ),
        autofocus: autofocus,
        minLines: 1,
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: enabeled,
        style: txtLblStyle(txtFieldColor),
        keyboardType: keyboardT,
        cursorColor: themeColor,
        obscureText: isPass,
        onChanged: onChange,
      ),
    );

// delete dialog (confirm)

void confirm(
  BuildContext ctx, {
  Function confirmFunction,
  String title,
  String content,
  String rejectText,
  String confirmText,
}) =>
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(
          content,
        ),
        actions: [
          FlatButton(
            child: Text(rejectText),
            onPressed: () => Navigator.pop(ctx),
          ),
          FlatButton(
            child: Text(confirmText),
            onPressed: confirmFunction,
          ),
        ],
      ),
    );

TextStyle txtLblStyle(color) {
  return TextStyle(
    color: color,
    fontSize: fntSize,
    letterSpacing: 1.2,
  );
}

FlatButton flatButton(bgColor, Function action, Text btnName) {
  return FlatButton(
    color: bgColor,
    onPressed: action,
    child: btnName,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
  );
}
