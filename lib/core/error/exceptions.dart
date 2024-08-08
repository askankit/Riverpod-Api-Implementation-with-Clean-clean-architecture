part of '../network/http_service.dart';

class AuthenticationException implements Exception {
  String? message;

  AuthenticationException(String? _message) {
    message = _message;
  }
}
class InactivatedException implements Exception {
  String? message;

  InactivatedException(String? _message) {
    message = _message;
  }
}
class SomeWentWrongException implements Exception {
  String? message;

  SomeWentWrongException(String? _message) {
    message = _message;
  }
}

class SubscriptionException implements Exception {
  String? message;

  SubscriptionException(String? _message) {
    message = _message;
  }
}
// Connecting timed out [0ms]

class ConnectingTimedOut implements Exception {
  String? message;

  ConnectingTimedOut(String? _message) {
    message = _message;
  }
}

abstract class RepoResponseStatus {
  static const int error = 500;
  static const int status =1;
  static const int success = 200;
  static const int authentication = 401;
  // static const int subscriptionExpire = 0;
  static const int someWentWrong = 400;
  static const int notFoundException = 404;
}


