import 'package:dartz/dartz.dart';
import 'package:posts_clean_architecture/core/error/exception.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/network/network_info.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:posts_clean_architecture/features/posts/data/repositories/post_repository.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

typedef Future<Unit> AddOrUpdateOrDeletePost();

class PostRepositoryImplement implements PostRepository{

  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImplement({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
    final PostModel postModel = PostModel(title: post.title, body: post.body);

    return _getMessage((){
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async{
    return _getMessage((){
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    if(await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      }on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body);

    return _getMessage((){
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(AddOrUpdateOrDeletePost addOrUpdateOrDeletePost) async{
    if(await networkInfo.isConnected){
      try{
        await addOrUpdateOrDeletePost();
        return Right(unit);
      } on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }

}