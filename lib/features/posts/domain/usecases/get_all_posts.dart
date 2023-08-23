import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

class GetAllPostsUseCase{
  final PostRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure , List<Post>>> call() async{
    return await repository.getAllPosts();
  }
}