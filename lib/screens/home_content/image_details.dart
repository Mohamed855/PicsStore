import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:PicsStore/global.dart';
import 'package:PicsStore/screens/home_content/no_images_yet.dart';

class ImageDetails extends StatefulWidget {
  final Function modalSheetAddImage;
  final Function modalSheetEditImage;
  final Function confirmDeleteImg;

  ImageDetails({
    this.modalSheetAddImage,
    this.modalSheetEditImage,
    this.confirmDeleteImg,
  });

  @override
  _ImageDetailsState createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
// floating action buttons (previous - delete - edit - next - gallery)

  Widget _floatingActionButton({
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

  @override
  Widget build(BuildContext context) =>
      imgUrls.length > 0 // content if there is images
          ? Container(
              color: Theme.of(context).canvasColor, // background color
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding / 2,
                    ),
                    child: FadeInImage(
                      image: NetworkImage(
                        imgUrls[imgIndex]['src'],
                      ),
                      // default image if there is any error - no internet connection
                      placeholder: AssetImage(
                        'assets/imgs/image_not_loaded.jpg',
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                  // image name
                  Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          imgUrls[imgIndex]['name'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // image src
                        Stack(
                          children: [
                            Container(
                              height: 100.0,
                              width: double.infinity,
                              color: Colors.white,
                              padding: EdgeInsets.all(padding),
                              child: SingleChildScrollView(
                                child: Text(
                                  imgUrls[imgIndex]['src'],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText2,
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
                                        text: imgUrls[imgIndex]['src']));
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Copied to Clipboard"),
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
                        _floatingActionButton(
                          herotag: "previous",
                          icon: Icon(Icons.arrow_left),
                          onPressed: () => setState(() {
                            imgIndex > 0
                                ? imgIndex--
                                : imgIndex = imgUrls.length - 1;
                          }),
                        ),
                        // delete image button
                        _floatingActionButton(
                          herotag: "delete",
                          icon: Icon(Icons.delete, size: 20.0),
                          backgroundColor: Colors.red,
                          onPressed: () => widget.confirmDeleteImg(),
                        ),
                        // edit image button
                        _floatingActionButton(
                          herotag: "edit",
                          icon: Icon(Icons.edit, size: 20.0),
                          backgroundColor: Colors.green,
                          onPressed: () => widget.modalSheetEditImage(),
                        ),
                        // next image button
                        _floatingActionButton(
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
          : NoImagesYet(widget.modalSheetAddImage);
}
