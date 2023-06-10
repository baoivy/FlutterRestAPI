import 'package:equatable/equatable.dart';

abstract class RemoteEvent extends Equatable {
  const RemoteEvent();
}

class LoadEvent extends RemoteEvent {
  int index;
  
  LoadEvent(this.index);
  @override
  List<Object> get props => [index];
}