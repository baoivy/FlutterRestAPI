//This class will store index
import 'package:restapitest/post.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteState extends Equatable {}

class LoadingState extends RemoteState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends RemoteState {
  final int index;
  final List<description> postData;
  LoadedState(this.index, this.postData);

  @override
  List<Object?> get props => [index, postData];
}

class ErrorState extends RemoteState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
