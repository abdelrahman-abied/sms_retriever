import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import '../data/remote/sms_service.dart';

class SmsViewModel with ChangeNotifier {
  final SmsQuery smsQuery;
  List<SmsMessage> _messages = [];
  SmsViewModel(this.smsQuery);

  getAllMessages() async {
    _messages = await SmsService(smsQuery).getAllMessages();
    notifyListeners();
  }

  searchMessages(String searchKey) {
    if (_messages.isEmpty) getAllMessages();
    _messages = _messages.where((message) {
      return message.sender
              ?.trim()
              .toLowerCase()
              .contains(searchKey.trim().toLowerCase()) ??
          false;
    }).toList();
    notifyListeners();
  }

  List<SmsMessage> get messages => _messages;
}
