import 'package:equatable/equatable.dart';

abstract class AddDeleteUpdatePostState extends Equatable{
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

class AddDeletUpdatePostInitial extends AddDeleteUpdatePostState{}

class LoadingAddDeletUpdatePostState extends AddDeleteUpdatePostState{}

class ErrorAddDeletUpdatePostState extends AddDeleteUpdatePostState{
  final String message;

  ErrorAddDeletUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePost extends AddDeleteUpdatePostState{
  final String message;

  MessageAddDeleteUpdatePost({required this.message});

  @override
  List<Object> get props => [message];
}

