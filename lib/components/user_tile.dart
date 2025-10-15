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
          leading: CircleAvatar(
            radius: 40,
            child: ClipOval(
              child: Image.network(
                "https://scontent.flhe5-1.fna.fbcdn.net/v/t39.30808-6/481062146_608007148814827_7931418781936136744_n.jpg?stp=dst-jpg_p526x296_tt6&_nc_cat=109&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=EPW2cax-uGMQ7kNvwGwoHsP&_nc_oc=Adk2Q3t0rNnDwN_ceEPGs8gZ0OPLmxBsvzdbaaxWKyMlRh2V2DtJ3uEgNnT3iJDoChc&_nc_zt=23&_nc_ht=scontent.flhe5-1.fna&_nc_gid=0k4MdjdIc9jDLLCQWht79A&oh=00_AfVVAHn9dtX7kUCfh_8fEXzAXBzl46m6IQhrDvcLIVoN4A&oe=68AE0458",
                fit: BoxFit.fill,
                width: 150,
                height: 150,
              ),
            ),
          ),

          trailing: Column(children: [ ],),
        ),
      ),
    );
  }
}
