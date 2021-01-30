import 'package:flutter_redux_example/store/quotes/quotes_action.dart';
import 'package:flutter_redux_example/store/quotes/quotes_state.dart';
import 'package:redux/redux.dart';

QuotesState setQuoteReducer(QuotesState state, SetQuoteAction action) {
  return QuotesState(currentQuote: action.quote, state: state.state);
}

QuotesState setQuoteStateReducer(
    QuotesState state, SetQuotesStateAction action) {
  return QuotesState(state: action.state, currentQuote: state.currentQuote);
}

Reducer<QuotesState> quoteReducer = combineReducers<QuotesState>([
  TypedReducer<QuotesState, SetQuoteAction>(setQuoteReducer),
  TypedReducer<QuotesState, SetQuotesStateAction>(setQuoteStateReducer),
]);
