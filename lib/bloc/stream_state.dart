part of 'stream_bloc.dart';

@immutable
abstract class StreamState {}

class StreamInitial extends StreamState {}
class StreamLoading extends StreamState {}
class StreamLoaded extends StreamState {}
class StreamError extends StreamState{}

