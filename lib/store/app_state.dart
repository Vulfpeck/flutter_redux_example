import 'package:flutter/foundation.dart';
import 'package:flutter_redux_example/store/counter/counter_state.dart';
import 'package:flutter_redux_example/store/quotes/quotes_state.dart';

class AppState {
  final CounterState counterState;
  final QuotesState quotesState;

  AppState({
    @required this.counterState,
    @required this.quotesState,
  });
}
