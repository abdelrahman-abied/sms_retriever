import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection_container.dart';
import '../sms_view_model.dart';

final smsVM = ChangeNotifierProvider((ref) {
  final smsQuery = ref.watch(smsQueryProvider);
  return SmsViewModel(smsQuery);
});
