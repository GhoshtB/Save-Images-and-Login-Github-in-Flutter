
import 'package:flutter/material.dart';
import 'package:flutter_app_favourite_cmbntn/db/db_helper.dart';
import 'package:flutter_app_favourite_cmbntn/model/photo.dart';
import 'package:flutter_app_favourite_cmbntn/utils/utility.dart';

class FavouritesPage extends StatefulWidget{

  @override
  State createState() {
    return FavouritesPageState();
  }
}

class FavouritesPageState extends State<FavouritesPage> {
  
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
   setState(() {
     favimageList =  [];
   });
    dbHelper = DBHelper();
    refreshImages();
  }

  void refreshImages() {
    dbHelper.getPhotos().then((value) {
      setState(() {
        favimageList.clear();
        favimageList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Favourites"),),
      body: showFavouritesPage(),
    );
  }

  showFavouritesPage()=>Padding(padding: EdgeInsets.all(5)
      ,child: GridView.builder( gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  2),
        itemBuilder: (context,index) {
          return showItemWidget(favimageList[index]);
        },itemCount: favimageList.length,));

  Widget showItemWidget(Photo e) =>
      Column(
        children: <Widget>[
          IconButton(icon:e.isSaved? Icon(Icons.favorite_border):Icon(Icons.favorite), onPressed: (){

            setState(() {
              if(e.isSaved){
                e.isSaved=false;
              }else{
                e.isSaved=true;
              }
              Photo employe=Photo(photo_name: e.photo_name,saved: e.isSaved?1:0);
              dbHelper.update(employe);
            });
          }),
          Container(padding: EdgeInsets.all(5),
            width: 240,height: 120,
            child: Utility.imageFrombase64String(e.photo_name),)
        ],);
}