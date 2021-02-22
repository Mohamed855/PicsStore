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
TextEditingController imgNameController = TextEditingController(),
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
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
                          vertical: padding, horizontal: 150.0),
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

void confirmDelete(BuildContext ctx, Function confirmDelete) => showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('delete'),
        content: Text(
          'Are you sure you want to delete ${imgUrls[imgIndex]['name']}',
        ),
        actions: [
          FlatButton(
            child: Text('close'),
            onPressed: () => Navigator.pop(ctx),
          ),
          FlatButton(
            child: Text('delete'),
            onPressed: confirmDelete,
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
