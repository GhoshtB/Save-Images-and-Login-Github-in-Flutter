
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_app_favourite_cmbntn/model/fav_photo.dart';
import 'package:flutter_app_favourite_cmbntn/model/github_loginrequest.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_favourite_cmbntn/model/photo.dart';

class Utility {



  static Image imageFrombase64String(String bytes){
    return Image.memory(
      base64Decode(bytes),
      fit: BoxFit.cover,
      gaplessPlayback: true,
      scale: 1.0,
      cacheHeight: 150,
      cacheWidth: 150,
      filterQuality: FilterQuality.low,
    );
  }

  static Uint8List dataFrombase64String(String bytes){

    return base64Decode(bytes);
  }

  static String base64String(Uint8List source){

    return base64Encode(source);
  }

}

  List<FavPhoto> favimageList;
  List<FavPhoto> randomimageList;

 Future<FirebaseUser> loginWithGitHub(String code) async {
//ACCESS TOKEN REQUEST
final response = await http.post(
"https://github.com/login/oauth/access_token",
headers: {
"Content-Type": "application/json",
"Accept": "application/json"
},
body: jsonEncode(GitHubLoginRequest(
clientId: GITHUB_CLIENT_ID,
clientSecret: GITHUB_CLIENT_SECRET,
code: code,
)),
);

GitHubLoginResponse loginResponse =
GitHubLoginResponse.fromJson(json.decode(response.body));

//FIREBASE STUFF
final AuthCredential credential = GithubAuthProvider.getCredential(
  token: loginResponse.accessToken,
);

final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)) as FirebaseUser;
return user;
}
const GITHUB_CLIENT_ID='e4df89baef7b96aee84f';

const GITHUB_CLIENT_SECRET="1e475ae8131400ed31ae0da760367f58f11f9c75";