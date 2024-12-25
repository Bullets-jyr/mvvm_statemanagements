import 'package:flutter/material.dart';

class NavigationService {
  // 이 글로벌 키는 전체 애플리케이션에 사용될 것입니다.
  late GlobalKey<NavigatorState> navigatorKey;

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  // 이를 탐색하려면 사용자가 탐색할 수 있도록 여기에 기능을 추가해야합니다.
  // 여기서는 컨텍스트를 제공하지
  navigate(Widget widget) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  navigateReplace(Widget widget) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  // Future<void> showDialog(BuildContext? context, Widget widget) async {
  //   await showAdaptiveDialog(context: context ?? navigatorKey.currentContext!, builder: (BuildContext context) => widget);
  // }

  Future<void> showDialog(Widget widget) async {
    await showAdaptiveDialog(
      barrierDismissible: true,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => widget,
    );
  }

  void showSnackBar(String message) {
    final context = navigatorKey.currentContext!;
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    final snackBarWidget = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      snackBarWidget,
    );
  }
}
