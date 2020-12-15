
import 'package:flutter_app_favourite_cmbntn/repos/repository.dart';
import 'package:flutter_app_favourite_cmbntn/model/repos_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

class Repos_bloc{

  BehaviorSubject<List<ReposData>> _repoSubject= BehaviorSubject();
  Repository repository =Repository();

  getReposData(String url) async{

    List<ReposData> data =await repository.repositoryData(url);
    _repoSubject.sink.add(data);

  }

  BehaviorSubject<List<ReposData>> get repoSubject=>_repoSubject.stream;

}

final bloc = Repos_bloc();