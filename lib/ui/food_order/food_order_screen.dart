import 'package:ecommerce_food_delivery/models/report_model.dart';
import 'package:ecommerce_food_delivery/provider/food_order_provider.dart';
import 'package:ecommerce_food_delivery/utils/constants/number_constants.dart';
import 'package:ecommerce_food_delivery/utils/constants/string_constants.dart';
import 'package:ecommerce_food_delivery/utils/utils.dart';
import 'package:ecommerce_food_delivery/utils/widgets/custom_appbar.dart';
import 'package:ecommerce_food_delivery/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FoodOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FoodOrderProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        height: NumberConstants.d120,
        child: Padding(
          padding: const EdgeInsets.only(
              top: NumberConstants.d40,
              left: NumberConstants.d20,
              right: NumberConstants.d20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Food Delivery",
                style: TextStyle(
                    fontSize: NumberConstants.d16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Consumer<FoodOrderProvider>(
                  builder: (context, foodProvider, child) {
                return Text(
                  'Total Fine: Rs. ${foodProvider.totalFine}',
                  style: const TextStyle(
                      fontSize: NumberConstants.d16,
                      fontWeight: FontWeight.bold),
                );
              }),
            ],
          ),
        ),
      ),
      body: provider.isLoading
          ? Center(child: commonLoader())
          : Padding(
              padding: const EdgeInsets.all(NumberConstants.d8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        height: NumberConstants.d40,
                        labelText: 'Delivery Month',
                        hintText: 'Enter Delivery Month',
                        width: MediaQuery.of(context).size.width *
                            NumberConstants.d0_6,
                        controller: provider.monthController,
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                      ),
                      const SizedBox(
                        width: NumberConstants.d20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.setOrderResponse(null);
                          if (provider.monthController.text.trim().isEmpty) {
                            showSnackBar(
                                context, "Please enter month", Str.isFalse);
                          } else if (int.parse(
                                      provider.monthController.text.trim()) >
                                  NumberConstants.i12 ||
                              int.parse(provider.monthController.text.trim()) ==
                                  NumberConstants.i0) {
                            showSnackBar(context, "Please enter valid month",
                                Str.isFalse);
                          } else {
                            provider.fetchFoodOrders(
                                provider.monthController.text.trim());
                          }
                        },
                        child: const Text('Fetch Data'),
                      ),
                    ],
                  ),
                  provider.responseModel == null
                      ? const Text(Str.textEmptyString)
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: NumberConstants.d5,
                              horizontal: NumberConstants.d5),
                          child: Text(
                            'Employee: ${provider.responseModel!.user.firstName} (${provider.responseModel!.user.empId})',
                            style: const TextStyle(
                                fontSize: NumberConstants.d18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                  provider.responseModel == null
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(child: Text("No data available")))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: provider.responseModel?.reports.length,
                            itemBuilder: (context, index) {
                              final report =
                                  provider.responseModel!.reports[index];
                              return _buildListCard(report, context);
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }

  Widget _buildListCard(Reports report, BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [
            Text(
              report.date,
              style: const TextStyle(
                  fontSize: NumberConstants.d16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (checkIsPendingAvailable(
                report.optIns)) // Check if 'Pending' exists
              const Text(
                'Rs. 100',
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: NumberConstants.d16),
              ),
            // checkIsPendingAvailable(report.optIns) == true ?  Text("Pe") :Text("")
          ],
        ),
        subtitle: Text(report.optIns != null
            ? report.optIns!.entries
                .map((entry) => '${entry.key.toUpperCase()}: ${entry.value}')
                .join('\n')
            : 'No data'),
      ),
    );
  }

  checkIsPendingAvailable(Map<String, String>? optIns) {
    return optIns != null ? optIns.values.contains('Pending') : Str.isFalse;
  }
}
