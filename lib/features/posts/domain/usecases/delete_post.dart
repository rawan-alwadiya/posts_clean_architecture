import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase({required this.repository});

  Future<Either<Failure , Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}