import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void hideKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}

Future<bool> isInternet() async {
  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      bool hasConnection =
          await Connectivity().checkConnectivity() != ConnectivityResult.none;
      return hasConnection;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

showSnackBar(BuildContext context, String message,
    [bool? value = true]) {
  Color color =
  value == true ? Colors.green : Colors.red;
  final snackBar = SnackBar(
    margin: const EdgeInsets.all(20),
    shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        side: BorderSide(color: color, width: 1)),
    content: Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
              child: Icon(
                value == true
                    ? Icons.check
                    : Icons.close,
                color: Colors.white,
                size: 15,
              )),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
  );

  ///If mounted then only showing snackBar
  if (context.mounted) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

Widget commonLoader({double? radius, Color? color}) {
  return CupertinoActivityIndicator(
      radius: radius ?? 20.0, color: color ?? Colors.yellow.shade700);
}

Map<String, dynamic> staticResponse404() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['statusCode'] = 404;
  data['data'] = [];
  data['message'] = "No data found";
  data['success'] = true;
  return data;
}
