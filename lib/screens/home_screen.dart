import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picsStore/content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // add new image function // modal bottom sheet button

  void addNewImg() => setState(() {
        if (imgSrcController.text.replaceAll(' ', '') != '') {
          if (imgNameController.text.replaceAll(' ', '') == '') {
            imgNameController.text = 'image';
          }
          imgUrls.add({
            'name': imgNameController.text,
            'src': imgSrcController.text.replaceAll(' ', ''),
          });
          imgNameController.text = '';
          imgSrcController.text = '';
          imgIndex = imgUrls.length - 1;
        }
      });

  // delete function // delete button

  void deleteImg() => setState(() {
        if (imgIndex > 0) {
          imgUrls.removeAt(imgIndex);
          imgIndex--;
        } else {
          imgUrls.removeAt(imgIndex);
        }
        Navigator.pop(context);
      });

  // edit function // edit button

  void editImg() => setState(() {
        if (editSrcController.text.replaceAll(' ', '') != '') {
          if (editNameController.text.replaceAll(' ', '') == '') {
            editNameController.text = 'image';
          }
          imgUrls[imgIndex]['name'] = editNameController.text;
          imgUrls[imgIndex]['src'] = editSrcController.text.replaceAll(' ', '');
          Navigator.pop(context);
        }
      });

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
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.add_a_photo_outlined,
              ),
              onPressed: () => madalBottomSheet(
                context,
                addNewImg,
                imgNameController,
                imgSrcController,
                'Add',
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.logout,
                ),
                onPressed: () => confirm(
                  context,
                  confirmFunction: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  title: 'Logout',
                  content: 'Are you sure you want to logout',
                  rejectText: 'close',
                  confirmText: 'logout',
                ),
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
              imgUrls.length > 0 // content if there is images
                  ? Container(
                      color: Theme.of(context).canvasColor, // background color
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: padding / 2,
                            ),
                            child: imgUrls.length !=
                                    0 // load if there is images
                                ? FadeInImage(
                                    image: NetworkImage(
                                      imgUrls[imgIndex]['src'],
                                    ),
                                    // default image if there is any error - no internet connection
                                    placeholder: AssetImage(
                                      'assets/imgs/default.png',
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  )
                                // default image if there is no images yet
                                : Image.asset(
                                    'assets/imgs/default.png',
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                          ),
                          // image name text field
                          Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(horizontal: padding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  imgUrls.length != 0
                                      ? imgUrls[imgIndex]['name']
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline2,
                                ),

                                // image src text field
                                Stack(
                                  children: [
                                    Container(
                                      height: 100.0,
                                      width: double.infinity,
                                      color: Colors.white,
                                      padding: EdgeInsets.all(padding),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          imgUrls.length != 0
                                              ? imgUrls[imgIndex]['src']
                                              : '',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5.0,
                                      bottom: 5.0,
                                      child: Container(
                                        color: Theme.of(context).canvasColor,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.copy,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                text: imgUrls[imgIndex]
                                                    ['src']));
                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text("Copied to Clipboard"),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // control buttons
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // previous image button
                                floatingActionButton(
                                  herotag: "previous",
                                  icon: Icon(Icons.arrow_left),
                                  onPressed: () => setState(() {
                                    imgIndex > 0
                                        ? imgIndex--
                                        : imgIndex = imgUrls.length - 1;
                                  }),
                                ),
                                // delete image button
                                floatingActionButton(
                                  herotag: "delete",
                                  icon: Icon(Icons.delete, size: 20.0),
                                  backgroundColor: Colors.red,
                                  onPressed: () => confirm(
                                    context,
                                    confirmFunction: deleteImg,
                                    title: 'Delete',
                                    content:
                                        'Are you sure you want to delete ${imgUrls[imgIndex]['name']}',
                                    rejectText: 'close',
                                    confirmText: 'delete',
                                  ),
                                ),
                                // edit image button
                                floatingActionButton(
                                    herotag: "edit",
                                    icon: Icon(Icons.edit, size: 20.0),
                                    backgroundColor: Colors.green,
                                    onPressed: () {
                                      editNameController.text =
                                          imgUrls[imgIndex]['name'];
                                      editSrcController.text =
                                          imgUrls[imgIndex]['src'];
                                      madalBottomSheet(
                                        context,
                                        editImg,
                                        editNameController,
                                        editSrcController,
                                        'Save',
                                      );
                                    }),
                                // next image button
                                floatingActionButton(
                                  herotag: "next",
                                  icon: Icon(Icons.arrow_right),
                                  onPressed: () => setState(() {
                                    imgIndex == imgUrls.length - 1
                                        ? imgIndex = 0
                                        : imgIndex++;
                                  }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: padding * 7.5),
                      child: Column(
                        children: [
                          Image.asset('assets/imgs/default.png'),
                          Padding(
                            padding: EdgeInsets.only(top: padding),
                            child: Text(
                              'There is no images yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 22.0,
                              ),
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
                                onPressed: () => madalBottomSheet(
                                  context,
                                  addNewImg,
                                  imgNameController,
                                  imgSrcController,
                                  'Add',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Column(
                children: [
                  imgUrls.length > 0 // content if there is images
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: imgUrls.length,
                            padding: EdgeInsets.symmetric(
                              vertical: padding,
                              horizontal: padding / 2,
                            ),
                            itemBuilder: (_, idx) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  imgIndex = idx;
                                  DefaultTabController.of(context).animateTo(0);
                                });
                              },
                              child: Card(
                                elevation: 12.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                ),
                                margin: EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: EdgeInsets.all(padding),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              imgUrls[idx]['name'],
                                              style: TextStyle(
                                                color: themeColor,
                                                fontSize: 20.0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            GestureDetector(
                                                child: Text(
                                                  imgUrls[idx]['src'],
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                onLongPress: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: imgUrls[idx]
                                                              ['src']));
                                                  Scaffold.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          "Copied to Clipboard"),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    FadeInImage(
                                      image: NetworkImage(imgUrls[idx]['src']),
                                      placeholder:
                                          AssetImage('assets/imgs/default.png'),
                                      height: 100.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      // content if there is no images yet
                      : Padding(
                          padding: EdgeInsets.only(top: padding * 7.5),
                          child: Column(
                            children: [
                              Image.asset('assets/imgs/default.png'),
                              Padding(
                                padding: EdgeInsets.only(top: padding),
                                child: Text(
                                  'There is no images yet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 22.0,
                                  ),
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
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    onPressed: () => madalBottomSheet(
                                      context,
                                      addNewImg,
                                      imgNameController,
                                      imgSrcController,
                                      'Add',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      );
}
