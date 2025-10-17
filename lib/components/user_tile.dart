import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String? subtitle;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.onTap,
    required this.text,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        padding: EdgeInsets.all(20),
        child: ListTile(
          title: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          leading: CircleAvatar(radius: 40, child: Icon(Icons.person)),

          trailing: Column(children: [ ],),
        ),
      ),
    );
  }
}
