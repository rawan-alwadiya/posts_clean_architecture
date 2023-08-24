import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_architecture/core/error/failures.dart';
import 'package:posts_clean_architecture/core/messages.dart';
import 'package:posts_clean_architecture/core/strings/failures.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_post_event.dart';
import 'package:posts_clean_architecture/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostState>{
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;

  AddDeleteUpdatePostBloc({required this.addPost,required this.deletePost,required this.updatePost}): super(AddDeletUpdatePostInitial()){
    on<AddDeleteUpdatePostsEvent>((event, emit) async{
      if(event is AddPostEvent){
        emit(LoadingAddDeletUpdatePost());

        final failureOrDoneMessage = await addPost(event.post);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));

      }else if(event is UpdatePostEvent){
        emit(LoadingAddDeletUpdatePost());

        final failureOrDoneMessage = await updatePost(event.post);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));

      }else if(event is DeletePostEvent){
        emit(LoadingAddDeletUpdatePost());

        final failureOrDoneMessage = await deletePost(event.postId);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, message){
    return either.fold(
            (failure) => ErrorAddDeletUpdatePostState(message: _mapFailureMessage(failure)),
            (_) => MessageAddDeletUpdatePost(message: message)
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