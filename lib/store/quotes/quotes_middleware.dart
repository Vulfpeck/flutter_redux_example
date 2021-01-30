import 'dart:convert';

import 'package:flutter_redux_example/store/quotes/quotes_action.dart';
import 'package:flutter_redux_example/store/quotes/quotes_state.dart';

import '../app_state.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

fetchQuoteFromApi(Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is FetchQuoteAction) {
    store.dispatch(SetQuotesStateAction(WidgetState.loading));
    try {
      final response =
          await http.get('https://breaking-bad-quotes.herokuapp.com/v1/quotes');
      if (response.statusCode != 200) {
        return store.dispatch(SetQuotesStateAction(WidgetState.error));
      }

      store.dispatch(SetQuoteAction(jsonDecode(response.body)[0]['quote']));
      store.dispatch(SetQuotesStateAction(WidgetState.data));
    } catch (e) {
      store.dispatch(SetQuotesStateAction(WidgetState.error));
    }
  }
}
