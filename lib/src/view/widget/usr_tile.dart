import 'package:flutter/material.dart';
import '../../controller/controller.dart';
import '../../model/model.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.user,
    required this.controller,
  }) : super(key: key);

  final User user;
  final UserController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        enableFeedback: true,
        key: ValueKey(user.id),
        title: Text(user.name,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        subtitle: InkWell(
          onTap: () => controller.openEmail(user.email),
          child: Text(
            user.email,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
        ),
        trailing: IconButton(
            onPressed: () => controller.openPhone(user.phone),
            icon: const Icon(Icons.call_outlined)),
      ),
    );
  }
}
