// import packages

import 'package:flutter/material.dart';
import 'package:PicsStore/gallery.dart';
import 'package:PicsStore/content.dart';

// home page class

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

// home page state

class _HomeState extends State<Home> {
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
            actions: [
              FlatButton(
                onPressed: () => madalBottomSheet(
                  context,
                  addNewImg,
                  imgNameController,
                  imgSrcController,
                  'Add',
                ),
                child: Icon(
                  Icons.add_box_rounded,
                  color: Colors.white,
                  size: 30.0,
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
                  icon: Icon(Icons.select_all_sharp),
                  text: 'Gallery',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Theme.of(context).backgroundColor, // background color
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: padding),
                      child: imgUrls.length != 0 // load if there is images
                          ? FadeInImage(
                              image: NetworkImage(
                                imgUrls[imgIndex]['src'],
                              ),
                              // default image if there is any error - no internet connection
                              placeholder: AssetImage(
                                'assets/imgs/default.png',
                              ),
                              height: 300.0,
                            )
                          // default image if there is no images yet
                          : Image.asset(
                              'assets/imgs/default.png',
                              height: 300.0,
                            ),
                    ),
                    // image name text field
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: TextField(
                        controller: TextEditingController(
                          text: imgUrls.length != 0
                              ? imgUrls[imgIndex]['name']
                              : '',
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'image name',
                        ),
                      ),
                    ),
                    // image src text field
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: TextField(
                        controller: TextEditingController(
                          text: imgUrls.length != 0
                              ? imgUrls[imgIndex]['src']
                              : '',
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'image url',
                        ),
                      ),
                    ),
                    // control buttons
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: padding * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // previous image button
                          floatingActionButton(
                            herotag: "previous",
                            icon: Icon(Icons.arrow_left),
                            onPressed: () => setState(() {
                              imgUrls.length > 0
                                  ? imgIndex > 0
                                      ? imgIndex--
                                      : imgIndex = imgUrls.length - 1
                                  : imgIndex = 0;
                            }),
                          ),
                          // delete image button
                          floatingActionButton(
                            herotag: "delete",
                            icon: Icon(Icons.delete, size: 20.0),
                            backgroundColor: Colors.red,
                            onPressed: () => imgUrls.length > 0 // delete image
                                ? confirmDelete(context, deleteImg)
                                // do nothing if there is no images
                                : imgIndex = 0,
                          ),
                          // edit image button
                          floatingActionButton(
                              herotag: "edit",
                              icon: Icon(Icons.edit, size: 20.0),
                              backgroundColor: Colors.green,
                              onPressed: () {
                                if (imgUrls.length > 0) {
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
                                }
                              }),
                          // next image button
                          floatingActionButton(
                            herotag: "next",
                            icon: Icon(Icons.arrow_right),
                            onPressed: () => setState(() {
                              imgUrls.length > 0
                                  ? imgIndex == imgUrls.length - 1
                                      ? imgIndex = 0
                                      : imgIndex++
                                  : imgIndex = 0;
                            }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Gallery(),
            ],
          ),
        ),
      );
}
