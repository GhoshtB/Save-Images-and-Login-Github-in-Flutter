import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_favourite_cmbntn/bloc/repos_bloc.dart';
import 'package:flutter_app_favourite_cmbntn/data/api.dart';
import 'package:flutter_app_favourite_cmbntn/model/repos_data.dart';
import 'package:flutter_app_favourite_cmbntn/model/userData.dart';
import 'package:flutter_app_favourite_cmbntn/utils/constants.dart';

class GithubLogin extends StatefulWidget {
  @override
  State createState() {
    return GithubLoginState();
  }
}

class GithubLoginState extends State<GithubLogin> {
  TextEditingController controller = TextEditingController();

  var api=Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Github"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "User Name",
                style: TextStyle(fontSize: 19),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                autofocus: true,
                controller: controller,
                style: TextStyle(color: Colors.blueAccent),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        )),
                    prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(end: 16.0),
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.blueAccent,
                        )),
                    hintText: "Enter User Name",
                    hintStyle: TextStyle(color: Colors.black26)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                var data = await loginWithGithubUserName(controller.text);
                if (data != null && data.url.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsListPage(data: data)));
                }else{

                }
              },
              elevation: 3,
              color: Colors.red,
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserDetailsListPage extends StatefulWidget {
  UserDetailsListPage({this.data, Key key}) : super(key: key);
  UserData data;

  @override
  State createState() {
    return UserDetailsListPageState();
  }
}

class UserDetailsListPageState extends State<UserDetailsListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getReposData(widget.data.repos_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Repositories"),),
      body: Column(
        children: <Widget>[
          Flexible(
              child: StreamBuilder(
                builder: (context, AsyncSnapshot<List<ReposData>> snapshot) {
                  if (snapshot.hasData) {
                   return ListView.builder(
                      itemBuilder: (context, index) {
                        return showItems(snapshot.data[index]);
                      },
                      itemCount: snapshot.data.length,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                stream: bloc.repoSubject,
              ))
        ],
      ),
    );
  }

  Widget showItems(ReposData data) {
return Padding(padding: EdgeInsets.all(5),
  child: Card(
    elevation: 3,
    child: Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(3),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(data.name??"",style: titlestyle,),
            Text(data.owner.login??"",style: othertyle,)
          ],),),
        SizedBox(height: 10,),
        Text(data.description??"",style: othertyle),
        SizedBox(height: 10,),
        Padding(padding: EdgeInsets.all(5),child: Text(data.url,style: childtyle,),),
        Padding(padding: EdgeInsets.all(5),
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(data.created_at??"",style: othertyle,),
              Text(data.updated_at??"",style: othertyle,)
            ],),)
      ],
    ),
  ),);
  }
}
