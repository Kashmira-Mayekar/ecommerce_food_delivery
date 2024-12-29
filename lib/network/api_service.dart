import 'package:ecommerce_food_delivery/network/post_api_provider.dart';

class ApiService {
  Future<dynamic> postApiCallingWithoutBody(String apiUrl) async {
    return await PostApiProvider().postApiProviderWithoutBodyCall(apiUrl);
  }
}

final ApiService apiService = ApiService();
