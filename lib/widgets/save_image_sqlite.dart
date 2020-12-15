import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_favourite_cmbntn/db/db_helper.dart';
import 'package:flutter_app_favourite_cmbntn/model/photo.dart';
import 'package:flutter_app_favourite_cmbntn/utils/utility.dart';
import 'package:flutter_app_favourite_cmbntn/widgets/favourites_page.dart';
import 'package:flutter_app_favourite_cmbntn/widgets/search_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app_favourite_cmbntn/widgets/github_login.dart';
import '../main.dart';
import 'home.dart';

class SaveImageDemoSQLite extends StatefulWidget {
  //
  SaveImageDemoSQLite() : super();

  final String title = "Flutter Save Image";

  @override
  _SaveImageDemoSQLiteState createState() => _SaveImageDemoSQLiteState();
}

class _SaveImageDemoSQLiteState extends State<SaveImageDemoSQLite> {
  Future<File> imageFile;
  Image image;
  DBHelper dbHelper;
  List<Photo> images;
  List<Photo> topimages;
  List<Photo> bottomimages;
  File _image;
  int index = 0;

  @override
  void initState() {
    super.initState();
    images = [];
    topimages = [];
    bottomimages = [];
    favimageList = [];
    dbHelper = DBHelper();
    refreshImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
        ],
      ),
      body: showAllPhotos(),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Favourites"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavouritesPage()));
                },
              ),
              ListTile(
                title: Text("Photos"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyPhotoPage()));
                },
              ),
              ListTile(
                title: Text("Search"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchList()));
                },
              ),
              ListTile(
                title: Text("Login With Github"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GithubLogin()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refreshImages() {
    dbHelper.getPhotos().then((value) {
      setState(() {
        images.clear();
        topimages.clear();
        bottomimages.clear();
        images.addAll(value);
        // favimageList.clear();
        images.forEach((element) {
          if (element.wear == "top Wear") {
            topimages.add(element);
          } else if (element.wear == "bottom Wear") {
            bottomimages.add(element);
          }
          // if(element.isSaved){
          //   favimageList.add(element);
          // }
        });
      });
    });
  }

  Widget gridView() => Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Top Wear", style: TextStyle(fontSize: 20)),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _showPicker(context, 0);
                    },
                  )
                ]),
          ),
          Flexible(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return showItemWidget(topimages[index]);
            },
            itemCount: topimages.length,
            scrollDirection: Axis.horizontal,
          )),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Bottom Wear",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _showPicker(context, 1);
                    },
                  )
                ]),
          ),
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return showItemWidget(bottomimages[index]);
              },
              itemCount: bottomimages.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ));

  pickImageFromGallery(index) async {
    var img = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((imgFile) async {
      String imgString = Utility.base64String(await imgFile.readAsBytes());
      setState(() {
        print("_image$imgString");
        var photo = Photo(
            photo_name: imgString,
            saved: 0,
            wear: index == 0 ? "top Wear" : "bottom Wear");
        images.add(photo);
        if (index == 0) {
          topimages.add(photo);
        } else {
          bottomimages.add(photo);
        }
        dbHelper.save(photo);
      });
    });
    setState(() {
      _image = img;
      print("imgString$_image");
    });
  }

  Future _imgFromCamera(index) async {
    File img = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 30)
        .then((value) async {
      String imgString = Utility.base64String(await value.readAsBytes());
      setState(() {
        var photo = Photo(
            photo_name: imgString,
            saved: 0,
            wear: index == 0 ? "top Wear" : "bottom Wear");
        images.add(photo);
        dbHelper.save(photo);
        if (index == 0) {
          topimages.add(photo);
        } else {
          bottomimages.add(photo);
        }
      });
    });
  }

  void _showPicker(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        pickImageFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(index);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showSelectionWardDrove(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return SimpleDialog(
            elevation: 3,
            title: Text(
              "Select OutFit Combination : ",
              style: TextStyle(fontSize: 18),
            ),
            children: <Widget>[
              Container(
                height: 300.0,
                width: 300.0,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                          width: 100,
                          height: 100,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                topimages[index].selection = true;
                              });
                            },
                            child: Stack(
                              children: <Widget>[
                                Utility.imageFrombase64String(
                                    topimages[index].photo_name),
                                topimages[index].selection
                                    ? Icon(
                                        Icons.check_box,
                                      )
                                    : Icon(
                                        Icons.ac_unit,
                                      )
                              ],
                            ),
                          ));
                    },
                    itemCount: topimages.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Container(
                height: 300.0,
                width: 300.0,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        height: 100,
                        child: GestureDetector(
                          child: Stack(
                            children: <Widget>[
                              Utility.imageFrombase64String(
                                  bottomimages[index].photo_name),
                              bottomimages[index].selection
                                  ? Icon(
                                      Icons.check_box,
                                    )
                                  : Icon(
                                      Icons.ac_unit,
                                    )
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              bottomimages[index].selection = true;
                            });
                          },
                        ),
                      );
                    },
                    itemCount: bottomimages.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget showItemWidget(Photo e) => Padding(
        padding: EdgeInsets.all(5),
        child: Stack(
          children: <Widget>[
            Card(
              elevation: 3,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: e.isSaved
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          onPressed: () {
                            Photo employe = Photo(
                                photo_name: e.photo_name,
                                saved: e.isSaved ? 0 : 1);
                            setState(() {
                              if (e.isSaved) {
                                favimageList.add(employe);
                                e.isSaved = false;
                              } else {
                                favimageList.remove(employe);
                                e.isSaved = true;
                              }
                              // dbHelper.delete(images.indexOf(employe));
                              // dbHelper.update(employe);
                            });
                          })
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (e.selection) {
                          e.selection = false;
                        } else {
                          e.selection = true;
                        }
                      });
                    },
                    child: Container(
                        /*padding: EdgeInsets.all(5),*/
                        width: 140,
                        height: 140,
                        child: Utility.imageFrombase64String(e.photo_name)),
                  )
                ],
              ),
            ),
            e.selection
                ? Icon(
                    Icons.check_box,
                    color: Colors.amberAccent,
                    size: 50,
                  )
                : Icon(null)
          ],
        ),
      );

  showAllPhotos() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(),
            )
          ],
        ),
      );
}
