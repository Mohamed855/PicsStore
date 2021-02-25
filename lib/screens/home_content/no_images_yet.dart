import 'package:flutter/material.dart';

import 'package:picsStore/global.dart';

class NoImagesYet extends StatefulWidget {
  final Function modalSheetAddImage;

  NoImagesYet(this.modalSheetAddImage);
  @override
  _NoImagesYetState createState() => _NoImagesYetState();
}

class _NoImagesYetState extends State<NoImagesYet> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: padding * 7.5),
        child: Column(
          children: [
            Image.asset('assets/imgs/default.png'),
            Padding(
              padding: EdgeInsets.only(top: padding),
              child: Text(
                'There is no images yet',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: padding),
              child: Container(
                height: 45.0,
                width: 150.0,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Add Image',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () => widget.modalSheetAddImage(),
                ),
              ),
            ),
          ],
        ),
      );
}
