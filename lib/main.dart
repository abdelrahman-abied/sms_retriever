import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms_inbox_example/injection_container.dart';
import 'package:permission_handler/permission_handler.dart';
import '../view/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var permission = await Permission.sms;
  if (!permission.isGranted) {
    await [Permission.sms].request();
  }
  final container = ProviderContainer(
    overrides: permissionProvider.overrideWithValue((ref) => permission),
  );
  runApp(
    const UncontrolledProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
