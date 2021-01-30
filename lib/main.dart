import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_example/store/app_reducer.dart';
import 'package:flutter_redux_example/store/app_state.dart';
import 'package:flutter_redux_example/store/counter/counter_reducer.dart';
import 'package:flutter_redux_example/store/counter/counter_state.dart';
import 'package:flutter_redux_example/store/quotes/quotes_action.dart';
import 'package:flutter_redux_example/store/quotes/quotes_middleware.dart';
import 'package:flutter_redux_example/store/quotes/quotes_state.dart';

import 'package:redux/redux.dart';

import 'store/counter/counter_actions.dart';

void main() {
  final store = new Store<AppState>(
    appReducer,
    initialState: AppState(
      counterState: CounterState(
        value: 0,
        secondValue: 0,
      ),
      quotesState: QuotesState(
        currentQuote: '',
        state: WidgetState.passive,
      ),
    ),
    middleware: [
      fetchQuoteFromApi,
    ],
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoreProvider(
        store: store,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              StoreConnector<AppState, Function>(
                converter: (store) => () => store.dispatch(FetchQuoteAction()),
                builder: (context, callback) => CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await callback();
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  StoreConnector<AppState, int>(
                    converter: (store) => store.state.counterState.value,
                    distinct: true,
                    builder: (context, count) {
                      return Text(
                        'Counter 1 value: $count ',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    },
                  ),
                  Divider(),
                  StoreConnector<AppState, int>(
                    converter: (store) => store.state.counterState.secondValue,
                    distinct: true,
                    builder: (context, count) {
                      return Text(
                        'Counter 2 value: $count',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    },
                  ),
                  Divider(),
                  StoreConnector<AppState, QuotesState>(
                    converter: (store) => store.state.quotesState,
                    distinct: true,
                    onInit: (store) {
                      if (store.state.quotesState.currentQuote.isNotEmpty)
                        return;
                      return store.dispatch(FetchQuoteAction());
                    },
                    builder: (context, state) {
                      if (state.state == WidgetState.passive ||
                          state.state == WidgetState.loading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (state.state == WidgetState.error) {
                        return Text('Error Loading Quote');
                      }

                      return Text(
                        '${state.currentQuote}',
                        style: Theme.of(context).textTheme.headline3,
                      );
                    },
                  ),
                ]),
              )
            ],
          ),
          floatingActionButton: CounterControllers(),
        ),
      ),
    );
  }
}

class CounterControllers extends StatelessWidget {
  const CounterControllers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StoreConnector<AppState, VoidCallback>(
          converter: (store) => () => store.dispatch(CounterActions.Increment),
          builder: (context, callback) => FloatingActionButton(
              child: Icon(Icons.plus_one), onPressed: callback),
        ),
        StoreConnector<AppState, VoidCallback>(
          converter: (store) => () => store.dispatch(CounterActions.Decrement),
          builder: (context, callback) => FloatingActionButton(
              child: Icon(Icons.exposure_minus_1), onPressed: callback),
        ),
        StoreConnector<AppState, VoidCallback>(
          converter: (store) =>
              () => store.dispatch(CounterActions.IncrementSecond),
          builder: (context, callback) => FloatingActionButton(
              child: Icon(Icons.plus_one), onPressed: callback),
        ),
        StoreConnector<AppState, VoidCallback>(
          converter: (store) =>
              () => store.dispatch(CounterActions.DecrementSecond),
          builder: (context, callback) => FloatingActionButton(
              child: Icon(Icons.exposure_minus_1), onPressed: callback),
        ),
        StoreConnector<AppState, VoidCallback>(
          converter: (store) => () => store.dispatch(FetchQuoteAction()),
          builder: (context, callback) => FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: callback,
          ),
        ),
      ],
    );
  }
}
