import 'package:ecommerce_food_delivery/models/order_response_model.dart';
import 'package:ecommerce_food_delivery/network/common_repository.dart';
import 'package:ecommerce_food_delivery/utils/constants/number_constants.dart';
import 'package:ecommerce_food_delivery/utils/constants/string_constants.dart';
import 'package:flutter/material.dart';

class FoodOrderProvider with ChangeNotifier {
  // Object
  OrderResponseModel? _responseModel;

  OrderResponseModel? get responseModel => _responseModel;
  TextEditingController monthController = TextEditingController();

  // bool
  bool _isLoading = Str.isFalse;

  bool get isLoading => _isLoading;

  // String
  String _errorMessage = Str.textEmptyString;

  String get errorMessage => _errorMessage;

  // Double
  double _totalFine = NumberConstants.d0;

  double get totalFine => _totalFine;

  setOrderResponse(OrderResponseModel? response){
    _totalFine = NumberConstants.d0;
    _responseModel = response;
    notifyListeners();
  }

  Future<void> fetchFoodOrders(String month) async {
    _isLoading = Str.isTrue;
    _errorMessage = Str.textEmptyString;
    notifyListeners();
    try {
      await commonRepository
          .postData("customer/report?month=$month")
          .then((response) async => {
                if (response != null)
                  {
                    setOrderResponse(response),
                    _totalFine = calculateFine(),
                    _isLoading = Str.isFalse,
                  }
                else
                  {
                    _isLoading = Str.isFalse,
                    print("Failed to fetch data."),
                  },
                notifyListeners(),
              })
          .onError((error, stackTrace) => {});
    } catch (error) {
      _isLoading = Str.isFalse;

      // Handle exceptions
      _errorMessage = 'Failed to fetch data. Error: $error';
    } finally {
      _isLoading = Str.isFalse;
      notifyListeners();
    }
  }

  double calculateFine() {
    if (responseModel == null) return NumberConstants.d0;

    double fine = NumberConstants.d0;
    for (var report in responseModel!.reports) {
      if (report.optIns != null) {
        fine += report.optIns!.values
                .where((status) => status == 'Pending')
                .length *
            NumberConstants.i100;
      }
    }
    return fine;
  }
}
