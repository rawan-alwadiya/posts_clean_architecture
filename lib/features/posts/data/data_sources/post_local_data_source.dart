import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/exception.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const CACHED_POSTS = 'CACHED_POSTS';

class PostLocalDataSourceImplements implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImplements({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels.map<Map<String, dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if(jsonString != null){
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel =
      decodeJsonData.map<PostModel>((jsonPostModel) => PostModel.fromjson(jsonPostModel)).toList();
      return Future.value(jsonToPostModel);
    }else {
      throw EmptyCacheException();
    }
  }
}