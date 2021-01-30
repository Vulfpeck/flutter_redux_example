import 'package:flutter_redux_example/store/counter/counter_actions.dart';
import 'package:flutter_redux_example/store/counter/counter_state.dart';

CounterState counterReducer(CounterState state, dynamic action) {
  switch (action) {
    case CounterActions.Increment:
      return CounterState(
        value: state.value + 1,
        secondValue: state.secondValue,
      );
    case CounterActions.Decrement:
      return CounterState(
        value: state.value - 1,
        secondValue: state.secondValue,
      );
    case CounterActions.IncrementSecond:
      return CounterState(
        value: state.value,
        secondValue: state.secondValue + 1,
      );
    case CounterActions.DecrementSecond:
      return CounterState(
        value: state.value,
        secondValue: state.secondValue - 1,
      );
  }

  return state;
}
