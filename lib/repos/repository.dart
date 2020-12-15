
import 'package:flutter_app_favourite_cmbntn/model/repos_data.dart';
import 'package:flutter_app_favourite_cmbntn/data/api.dart';

class Repository{

  Api provider= Api();

  Future<List<ReposData>> repositoryData(String url )=>provider.getRepositoryData(url);
}