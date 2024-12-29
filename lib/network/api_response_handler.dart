import 'dart:io';

import 'package:dio/dio.dart';


class ApiResponseHandler {
  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.created:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.accepted:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.alreadyReported:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.found:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.badRequest:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.unauthorized:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.forbidden:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.notFound:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.notAcceptable:
        var responseJson = response.data;
        return responseJson;
      case HttpStatus.internalServerError:
      case HttpStatus.badGateway:
        var responseJson = response.data;

        return responseJson;
    }
  }
}
