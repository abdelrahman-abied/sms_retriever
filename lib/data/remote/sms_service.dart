import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

// List<SmsMessage> messages = await query.getAllSms;
class SmsService {
  final smsQuery;
  SmsService(this.smsQuery);

  Future<List<SmsMessage>> getAllMessages() async {
    try {
      final List<SmsMessage> messages = await smsQuery.getAllSms;
      if (messages.isNotEmpty) {
        return messages;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
