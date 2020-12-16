
import 'package:flutter/material.dart';
import 'package:flutter_app_favourite_cmbntn/db/db_helper.dart';
import 'package:flutter_app_favourite_cmbntn/model/fav_photo.dart';
import 'package:flutter_app_favourite_cmbntn/model/photo.dart';
import 'package:flutter_app_favourite_cmbntn/utils/utility.dart';
//  cb0e6540a8b1c8d58e1b28cbf663212da55675bf
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
   // setState(() {
     favimageList =  [];
   // });
    dbHelper = DBHelper();

    refreshImages();
  }

  void refreshImages() async{
   await dbHelper.getfavPhotos().then((value) {
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
      ,child: ListView.builder(/* gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  2),*/
        itemBuilder: (context,index) {
          return showItemWidget(favimageList[index]);
        },itemCount: favimageList.length,));

  Widget showItemWidget(FavPhoto e) =>
      Padding(padding: EdgeInsets.all(3),
      child: Card(elevation: 3,
      child: Column(
        children: <Widget>[
          Container(padding: EdgeInsets.all(5),
            width: 340,height: 220,
            child: Stack(
              children: <Widget>[
                IconButton(icon:e.isSaved? Icon(Icons.favorite_border):Icon(Icons.favorite), onPressed: (){

                  /*setState(() {
              if(e.isSaved){
                e.isSaved=false;
              }else{
                e.isSaved=true;
              }
              Photo employe=Photo(photo_name: e.photo_name,saved: e.isSaved?1:0);
              dbHelper.update(employe);
            });*/
                }),
                Positioned(top: 10,right:10,child: Utility.imageFrombase64String(e.topphoto_name),),
                Positioned(bottom: 10,left:10,child: Utility.imageFrombase64String(e.btmphoto_name),),
              ],
            ),)
        ],),),);
}

class MyRandomWardDrovePage extends StatefulWidget{

  @override
  State createState() {
    return MyRandomWardDrovePageState();
  }
}

class MyRandomWardDrovePageState extends State<MyRandomWardDrovePage> {

  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
   // setState(() {
     randomimageList =  [];
   // });
    dbHelper = DBHelper();
    refreshImages();
  }

  void refreshImages() async{
   await dbHelper.getRandomPhotos().then((value) {
      setState(() {
        randomimageList.clear();
        randomimageList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Random Warddrove"),),
      body: showFavouritesPage(),
    );
  }

  showFavouritesPage()=>Padding(padding: EdgeInsets.all(5)
      ,child: ListView.builder( /*gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  2),*/
        itemBuilder: (context,index) {
          return showItemWidget(randomimageList[index]);
        },itemCount: randomimageList.length,));

  Widget showItemWidget(FavPhoto e) =>
      Padding(padding: EdgeInsets.all(5),
      child: Card(elevation: 3,
      child: Column(
        children: <Widget>[
          IconButton(icon:/*e.isSaved?*/ Icon(Icons.favorite_border)/*:Icon(Icons.favorite)*/, onPressed: (){

            /*setState(() {
              if(e.isSaved){
                e.isSaved=false;
              }else{
                e.isSaved=true;
              }
              Photo employe=Photo(photo_name: e.photo_name,saved: e.isSaved?1:0);
              dbHelper.update(employe);
            });*/
          }),
          Container(padding: EdgeInsets.all(5),
            width: 340,height: 220,
            child: Stack(
              children: <Widget>[
                Positioned(top: 10,right:10,child: Utility.imageFrombase64String(e.topphoto_name),),
                Positioned(bottom: 10,left:10,child: Utility.imageFrombase64String(e.btmphoto_name),),
              ],
            ),)
        ],),),);
}