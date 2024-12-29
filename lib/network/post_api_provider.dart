import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce_food_delivery/utils/constants/string_constants.dart';
import 'package:flutter/foundation.dart';

import '../utils/constants/api_urls.dart';
import '../utils/utils.dart';
import 'api_response_handler.dart';

class PostApiProvider {
  Dio dio = Dio();

  Future<dynamic> postApiProviderWithoutBodyCall(String url) async {
    String idToken = ApiUrls.headerToken;
    var responseJson;
    // dynamic header;
    Map<String, String> headers = {
      ApiUrls.headerParamContentType: ApiUrls.headerParamApplicationJSON,
      ApiUrls.headerParamAccept: ApiUrls.headerParamApplicationJSON,
    };
    if (idToken != Str.emptyString) {
      headers[ApiUrls.headerParamAuthorization] =
          "${ApiUrls.headerParamToken} $idToken";
    }
    if (kDebugMode) {
      print("--POST ${ApiUrls.baseURL}$url $headers");
    }
    var isInternetActive = await isInternet();
    if (isInternetActive) {
      try {
        dynamic response;
        try {
          response = await dio.post('${ApiUrls.baseURL}$url',
              options: Options(headers: headers));
          responseJson = ApiResponseHandler().returnResponse(response);
        } on DioException catch (e) {
          response = e.response;
          if (e.toString().contains("${HttpStatus.unauthorized}")) {
            return await postApiProviderWithoutBodyCall(url);
          } else {
            responseJson = ApiResponseHandler().returnResponse(response);
          }
        }

        if (kDebugMode) {
          print("--POST RESPONSE -- ${ApiUrls.baseURL}$url $responseJson");
        }
      } catch (e) {
        print("--POST onError ${ApiUrls.baseURL}$url  $e ");
        return e;
      }
      return responseJson;
    } else {
      return Str.TEXT_INTERNET_CONNECTION_ERROR;
    }
  }
}
