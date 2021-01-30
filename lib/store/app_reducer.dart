import 'package:flutter_redux_example/store/app_state.dart';
import 'package:flutter_redux_example/store/counter/counter_reducer.dart';
import 'package:flutter_redux_example/store/quotes/quotes_reducer.dart';

AppState appReducer(AppState state, action) => AppState(
      counterState: counterReducer(state.counterState, action),
      quotesState: quoteReducer(state.quotesState, action),
    );
