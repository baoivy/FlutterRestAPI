import 'remote_state.dart';
import 'remote_event.dart';
import 'request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteBloc extends Bloc<RemoteEvent, RemoteState> {
  RemoteBloc() : super(LoadingState()) {
      on<LoadEvent>((event, emit) async {
        emit(LoadingState());
        try {
          final joke = await fetch();
          emit(LoadedState(event.index, joke));
        } catch (e) {
          emit(ErrorState(e.toString()));
        }
      });
  }
}





