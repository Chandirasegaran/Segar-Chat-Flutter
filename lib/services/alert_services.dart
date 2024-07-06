import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:segarchat/services/navigation_service.dart';

class AlertServices {
  final GetIt _getIt = GetIt.instance;
// Suggested code may be subject to a license. Learn more: ~LicenseLog:470189566.
  late NavigationService _navigationService;

  AlertServices() {
    _navigationService = _getIt.get<NavigationService>();
  }

  void showTost({required String text, IconData icon = Icons.info}) {
    try {
      DelightToastBar(
          autoDismiss: true,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return ToastCard(
              leading: Icon(
                icon,
                size: 28,
              ),
              title: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            );
          }).show(_navigationService.navigatorKey!.currentContext!);
    } catch (e) {
      print(e);
    }
  }
}
