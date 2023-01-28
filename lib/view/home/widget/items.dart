import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:intl/intl.dart';

import '../../../core/constants.dart';

class Items extends StatefulWidget {
  final SmsMessage smsMessage;
  Items(this.smsMessage, {Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.smsMessage.sender ?? ""),
            if (widget.smsMessage.date != null)
              Text(DateFormat('dd/MM/yyyy').format(widget.smsMessage.date!)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "AED ${widget.smsMessage.body != null ? total(widget.smsMessage.body!).toStringAsFixed(3) : 0.0}"),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black, padding: EdgeInsets.zero),
              child: const Text("Click to show"),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ],
        ),
        if (isExpanded)
          Container(
            color: Colors.white,
            child: Text(widget.smsMessage.body ?? ""),
          ),
      ]),
    );
  }

  double total(String messageody) {
    double total = 0.0;
    List<String> textList = messageody
        .replaceAll(currency, " ")
        .replaceAll(RegExp(r"\s+\b|\b\s"), " ")
        .split(" ");
    for (int i = 0; i < textList.length; i++) {
      if (regExpPattern.hasMatch(textList[i])) {
        total += double.tryParse(textList[i]) ?? 0.0;
      }
    }
    return total;
  }
}
