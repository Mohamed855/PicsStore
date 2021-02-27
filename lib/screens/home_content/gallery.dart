import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:PicsStore/global.dart';
import 'package:PicsStore/screens/home_content/no_images_yet.dart';

class Gallery extends StatefulWidget {
  final Function modalSheetAddImage;

  const Gallery({this.modalSheetAddImage});
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) => Column(
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
                          borderRadius: BorderRadius.circular(borderRadius),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      imgUrls[idx]['name'],
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
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
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        onLongPress: () {
                                          Clipboard.setData(ClipboardData(
                                              text: imgUrls[idx]['src']));
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text("Copied to Clipboard"),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            FadeInImage(
                              image: NetworkImage(imgUrls[idx]['src']),
                              placeholder: AssetImage(
                                  'assets/imgs/image_not_loaded.jpg'),
                              height: 100.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              // content if there is no images yet
              : NoImagesYet(widget.modalSheetAddImage),
        ],
      );
}
