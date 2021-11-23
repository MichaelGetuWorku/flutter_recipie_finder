// generic type T
abstract class Result<T> {}

class Success<T> extends Result<T> {
  //hold a value when the response is successful. This could hold JSON data, for example
  final T value;
  Success(this.value);
}

class Error<T> extends Result<T> {
  //hold an exception. This will model errors that occur during an HTTP call, like using the wrong credentials or trying to fetch data without authorization.
  final Exception exception;
  Error(this.exception);
}
