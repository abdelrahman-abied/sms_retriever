import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms_inbox_example/view_model/state/sms_state.dart';
import '../../core/constants.dart';

final totalState = StateProvider<double>((ref) {
  double total = 0.0;
  final messages = ref.watch(smsVM).messages;

  messages.map((element) {
    if (element.body?.contains(currency) ?? false) {
      final body = element.body;
      List<String> textList = body!
          .replaceAll(currency, " ")
          .replaceAll(RegExp(r"\s+\b|\b\s"), " ")
          .split(" ");
      for (int i = 0; i < textList.length; i++) {
        if (regExpPattern.hasMatch(textList[i])) {
          total += double.tryParse(textList[i]) ?? 0.0;
        }
      }
    }
  }).toList();

  return total;
});
