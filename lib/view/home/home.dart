import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms_inbox_example/view/home/widget/items.dart';
import '../../view_model/state/sms_state.dart';
import '../../view_model/state/total_state.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _searchController = TextEditingController();
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        ref.read(smsVM).getAllMessages();
      },
    );
    _searchController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final smsRef = ref.watch(smsVM);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
        actions: [
          IconButton(
              onPressed: () {
                _searchController.clear();
                ref.read(smsVM).getAllMessages();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: (value) {
                if (value.isEmpty) ref.read(smsVM).getAllMessages();
                ref.read(smsVM).searchMessages(value);
              },
              decoration: InputDecoration(
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          ref.read(smsVM).getAllMessages();

                          _searchController.clear();
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      )
                    : null,
              ),
            ),
            Expanded(
              child: smsRef.messages.isEmpty
                  ? const Center(
                      child: Text("No Messages"),
                    )
                  : ListView.builder(
                      itemCount: smsRef.messages.length,
                      itemBuilder: (context, index) {
                        final message = smsRef.messages[index];
                        return Items(message);
                      },
                    ),
            ),
          ],
        ),
      ),
      // resizeToAvoidBottomInset: true,

      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: kToolbarHeight - 10,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final total = ref.watch(totalState);

                  return Text(
                    "AED ${total.toStringAsFixed(3)}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
