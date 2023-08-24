import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable{
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostEvent extends PostsEvent{}

class RefreshPostEvent extends PostsEvent{}