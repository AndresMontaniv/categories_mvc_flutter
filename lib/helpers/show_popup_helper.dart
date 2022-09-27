import 'package:flutter/cupertino.dart';
import 'package:mvc_categories/views/views.dart';

Future<String?> showEditActionDialog({
  required BuildContext context,
  String? value,
}) async {
  final resp = await showCupertinoModalPopup<String>(
    barrierDismissible: false,
    context: context,
    builder: (context) => EditDialog(
      value: value,
    ),
  );
  return resp;
}
