class QuotesState {
  final WidgetState state;
  final String currentQuote;

  QuotesState({
    this.state: WidgetState.passive,
    this.currentQuote: '',
  });
}

enum WidgetState {
  passive,
  loading,
  error,
  data,
}
