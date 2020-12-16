
import 'dart:convert' show json, utf8;
import 'dart:io';
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter_app_favourite_cmbntn/utils/constants.dart';
import 'package:flutter_app_favourite_cmbntn/utils/utility.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_favourite_cmbntn/model/userData.dart';
import 'repo.dart';
import 'package:flutter_app_favourite_cmbntn/model/repos_data.dart';

class Api {
  static final HttpClient _httpClient = HttpClient();
  static final String _url = "api.github.com";

  static Future<List<Repo>> getTrendingRepositories() async {
    final lastWeek = DateTime.now().subtract(Duration(days: 7));
    final formattedDate = formatDate(lastWeek, [yyyy, '-', mm, '-', dd]);

    final uri = Uri.https(_url, '/search/repositories', {
      'q': 'created:>$formattedDate',
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List();
    }

    return Repo.mapJSONStringToList(jsonResponse['items']);
  }

  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.OK) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }

  static Future<List<Repo>> getRepositoriesWithSearchQuery(String query) async {
    final uri = Uri.https(_url, '/search/repositories', {
      'q': query,
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List();
    }

    return Repo.mapJSONStringToList(jsonResponse['items']);
  }

  http.Client client= http.Client();

  Future<List<ReposData>> getRepositoryData(String url) async{

    var response=await http.get(url,headers: {'Authorization': 'Bearer ' + prsnlAcsTken});
    /*page=${firstKey}&per_page=${keyword}*/
    print(url);

    List data=json.decode(response.body);
    List<ReposData> datas=[];
    print(response.body);
    if(response.statusCode==200){
//      print(ReposData.fromJson(data));
      /*  data.map((e) =>
       datas.add(ReposData.fromJson(e)));*/
      return data.map((e) => ReposData.fromJson(e)).toList();
    }else{
      throw Exception('Failed to load post');
    }

  }

}

Future<UserData> loginWithGithubUserName(String userName) async{
  var url= "https://api.github.com/users/$userName";
  // final authorizationEndpoint =
  // Uri.parse('https://api.github.com/authorizations');
  // var client = await oauth2.clientCredentialsGrant(
  //     authorizationEndpoint, GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET);
  Api api= Api();
  // var response =
  // await client.read('https://example.com/api/some_resource.json');

  var https =await http.Client().get(url,headers: {'Authorization': 'Bearer ' + prsnlAcsTken});

  var response = json.decode(https.body);
  UserData data = UserData.fromJson(response);
  print("object$response  $url");
  return data;
}
