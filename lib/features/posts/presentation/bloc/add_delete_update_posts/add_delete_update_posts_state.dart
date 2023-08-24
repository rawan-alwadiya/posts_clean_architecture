import 'package:equatable/equatable.dart';

abstract class AddDeleteUpdatePostState extends Equatable{
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

class AddDeletUpdatePostInitial extends AddDeleteUpdatePostState{}

class LoadingAddDeletUpdatePost extends AddDeleteUpdatePostState{}

class ErrorAddDeletUpdatePostState extends AddDeleteUpdatePostState{
  final String message;

  ErrorAddDeletUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeletUpdatePost extends AddDeleteUpdatePostState{
  final String message;

  MessageAddDeletUpdatePost({required this.message});

  @override
  List<Object> get props => [message];
}

