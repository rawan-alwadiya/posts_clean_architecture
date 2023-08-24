import 'package:equatable/equatable.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

abstract class AddDeleteUpdatePostsEvent extends Equatable{
  const AddDeleteUpdatePostsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostsEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdatePostsEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdatePostsEvent {
  final int postId;

  DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}