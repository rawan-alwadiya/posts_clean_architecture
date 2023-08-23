import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Post post) async{
    return await repository.updatePost(post);
  }
}