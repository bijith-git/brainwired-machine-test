import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../controller/controller.dart';
import '../widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> test() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Screen",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<UserController>(
        init: UserController(),
        initState: (_) {},
        builder: (controller) {
          return Skeletonizer(
              enabled: controller.isLoading,
              child: RefreshIndicator(
                onRefresh: () => controller.getUserAPICAll(),
                child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    itemCount: controller.userList.length,
                    itemBuilder: (_, i) {
                      var user = controller.userList[i];
                      return UserTile(user: user, controller: controller);
                    }),
              ));
        },
      ),
    );
  }
}
