import 'package:flutter/material.dart';
import 'package:funfix/services/auth/auth_service.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

const int yourZegoAppID = 123456789; // replace with real app ID
const String yourZegoAppSign = "your_real_app_sign"; // replace with real sign

class AppBarWithCall extends StatelessWidget implements PreferredSizeWidget {
  final String receiverEmail;
  final String receiverID;

  const AppBarWithCall({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  void _startCall(BuildContext context, bool isVideo) {
    final user = AuthService().getCurrentUser()!;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoUIKitPrebuiltCall(
          appID: yourZegoAppID,
          appSign: yourZegoAppSign,
          userID: user.uid,
          userName: user.email ?? "User",
          callID: receiverID,
          config: isVideo
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(receiverEmail),
      actions: [
        IconButton(
          icon: const Icon(Icons.call),
          onPressed: () => _startCall(context, false),
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () => _startCall(context, true),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
