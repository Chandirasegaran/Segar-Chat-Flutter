// Suggested code may be subject to a license. Learn more: ~LicenseLog:2168929315.
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:segarchat/firebase_options.dart';
import 'package:segarchat/services/alert_services.dart';
import 'package:segarchat/services/auth_service.dart';
import 'package:segarchat/services/media_services.dart';
import 'package:segarchat/services/navigation_service.dart';
import 'package:segarchat/services/storage_service.dart';

// import 'firebase_options.dart'

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<AlertServices>(
    AlertServices(),
  );
  getIt.registerSingleton<MediaServices>(
    MediaServices(),
  );
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
}
