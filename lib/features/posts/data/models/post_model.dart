import 'package:flutter/foundation.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

class PostModel extends Post{
   const PostModel({required int id, required String title, required String body}):
        super(id: id , title: title, body: body);


   factory PostModel.fromjson(Map<String,dynamic> json){
     return PostModel(id: json['id'], title: json['title'], body: json['body']);
   }

   Map<String, dynamic> toJson(){
     return {
       'id':id,
       'title':title,
       'body':body
     };
   }
}