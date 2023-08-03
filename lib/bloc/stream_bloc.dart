import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../repositry/api/streamapi.dart';
import '../repositry/modelclass/Streammodel.dart';

part 'stream_event.dart';
part 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  late List<Streammodel> streammodel;
  Streamapi streamapi=Streamapi();
  StreamBloc() : super(StreamInitial()) {

    on<StreamEvent>((event, emit)async {
      emit(StreamLoading());
      try{

        streammodel = await streamapi.getstreammodel();
        emit(StreamLoaded());
      } catch(e){
        print(e);
        emit(StreamError());}
    });

  }
}
