import 'dart:async';
import 'remote_state.dart';
import 'remote_event.dart';
import 'request.dart';

class RemoteBloc {
  final eventController = StreamController<RemoteEvent>();
  final stateController = StreamController<RemoteState>.broadcast();

  StreamSink<RemoteEvent> get eventSink => eventController.sink;
  Stream<RemoteState> get stateStream => stateController.stream;
  RemoteState get initialState => RemoteState(0, []);

  RemoteBloc() {
    eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(RemoteEvent event) {
    final index = event.index;
    fetch().then((dataFromServer) {
      final state = RemoteState(index, dataFromServer);
      stateController.add(state);
    });
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}
