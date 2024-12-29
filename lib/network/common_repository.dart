import 'package:ecommerce_food_delivery/models/order_response_model.dart';
import 'package:ecommerce_food_delivery/network/api_service.dart';

class CommonRepository {
  Future<OrderResponseModel?> postData(String url) async {
    try {
      // Make API call
      var dataResponse = await apiService.postApiCallingWithoutBody(url);
      if (dataResponse is Map<String, dynamic>) {
        return OrderResponseModel.fromJson(dataResponse);
      } else {
        throw Exception(
            "Unexpected response format: ${dataResponse.runtimeType}");
      }
    } catch (exception) {
      return null;
    }
  }
}

final CommonRepository commonRepository = CommonRepository();
