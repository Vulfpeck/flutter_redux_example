import 'package:flutter_redux_example/store/quotes/quotes_state.dart';

class SetQuoteAction {
  final String quote;

  SetQuoteAction(this.quote);
}

class SetQuotesStateAction {
  final WidgetState state;

  SetQuotesStateAction(this.state);
}

class FetchQuoteAction {}
