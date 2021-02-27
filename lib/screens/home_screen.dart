import 'package:flutter/material.dart';
import 'package:PicsStore/global.dart';
import 'package:PicsStore/screens/home_content/gallery.dart';
import 'package:PicsStore/screens/home_content/image_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// objects

  TextEditingController _imgNameController = TextEditingController(),
      _imgSrcController = TextEditingController(),
      _editNameController = TextEditingController(),
      _editSrcController = TextEditingController();

  // home page

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 150.0,
            centerTitle: true,
            title: Text(
              'Pics Store',
              style: Theme.of(context).textTheme.headline1,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
              onPressed: () => _addImageModalBottomSheet(),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.logout,
                ),
                onPressed: () => _confirmLogoutDialog(),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.image),
                  text: 'Image',
                ),
                Tab(
                  icon: Icon(Icons.auto_awesome_mosaic),
                  text: 'Gallery',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ImageDetails(
                modalSheetAddImage: _addImageModalBottomSheet,
                modalSheetEditImage: _editImageModalBottomSheet,
                confirmDeleteImg: _confirmDeleteDialog,
              ),
              Gallery(
                modalSheetAddImage: _addImageModalBottomSheet,
              ),
            ],
          ),
        ),
      );

  // madal bottom sheet

  void _modalBottomSheet(
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: padding),
                  child: TextField(
                    controller: nameTextController,
                    decoration: InputDecoration(
                      labelText: 'Image Name',
                      contentPadding: EdgeInsets.all(10),
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                      counterText: "",
                    ),
                    minLines: 1,
                    maxLines: 100,
                    autofocus: true,
                    maxLength: 50,
                    cursorColor: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: TextField(
                      controller: srcTextController,
                      decoration: InputDecoration(
                        labelText: 'Image Url',
                        contentPadding: EdgeInsets.all(10),
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        counterText: "",
                      ),
                      minLines: 1,
                      maxLines: 100,
                      cursorColor: Theme.of(context).primaryColor,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: padding),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: addNewImg,
                          child: Padding(
                            padding: EdgeInsets.all(padding / 2),
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

  // add new image function

  void _addNewImg() => setState(() {
        if (_imgSrcController.text.replaceAll(' ', '') != '') {
          if (_imgNameController.text.replaceAll(' ', '') == '') {
            _imgNameController.text = 'image';
          }
          imgUrls.add({
            'name': _imgNameController.text,
            'src': _imgSrcController.text.replaceAll(' ', ''),
          });
          _imgNameController.text = '';
          _imgSrcController.text = '';
          imgIndex = imgUrls.length - 1;
        }
      });

  // add modal bottom sheet button

  void _addImageModalBottomSheet() => _modalBottomSheet(
        context,
        _addNewImg,
        _imgNameController,
        _imgSrcController,
        'Add',
      );

  // edit function

  void _editImg() => setState(() {
        if (_editSrcController.text.replaceAll(' ', '') != '') {
          if (_editNameController.text.replaceAll(' ', '') == '') {
            _editNameController.text = 'image';
          }
          imgUrls[imgIndex]['name'] = _editNameController.text;
          imgUrls[imgIndex]['src'] =
              _editSrcController.text.replaceAll(' ', '');
          Navigator.pop(context);
        }
      });

  // edit modal bottom sheet button

  void _editImageModalBottomSheet() {
    _editNameController.text = imgUrls[imgIndex]['name'];
    _editSrcController.text = imgUrls[imgIndex]['src'];
    _modalBottomSheet(
      context,
      _editImg,
      _editNameController,
      _editSrcController,
      'Save',
    );
  }

  // confirm dialog

  void _confirm(
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

  // delete function

  void _deleteImg() => setState(() {
        if (imgIndex > 0) {
          imgUrls.removeAt(imgIndex);
          imgIndex--;
        } else {
          imgUrls.removeAt(imgIndex);
        }
        Navigator.pop(context);
      });

  // confirm delete dialog

  void _confirmDeleteDialog() => _confirm(
        context,
        confirmFunction: _deleteImg,
        title: 'Delete',
        content: 'Are you sure you want to delete ${imgUrls[imgIndex]['name']}',
        rejectText: 'close',
        confirmText: 'delete',
      );

  // confirm logout dialog

  void _confirmLogoutDialog() => _confirm(
        context,
        confirmFunction: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/login');
        },
        title: 'Logout',
        content: 'Are you sure you want to logout',
        rejectText: 'close',
        confirmText: 'logout',
      );
}
