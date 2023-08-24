import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/strings/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/posts/posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState>{
  final GetAllPostsUseCase getAllPostsUseCase;
  PostsBloc({required this.getAllPostsUseCase}): super(PostsInitial()){
    on<PostsEvent>((event, emit) async {
      if(event is GetAllPostEvent){
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPostsUseCase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }else if(event is RefreshPostEvent){
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPostsUseCase();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either){
    return either.fold(
            (failure) =>
              ErrorPostsState(message: _mapFailureMessage(failure)),
            (posts) =>
              LoadedPostsState(posts: posts)
    );
  }


  String _mapFailureMessage(Failure failure){
    switch(failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'Unexpected error, please try again later';
    }
  }
}