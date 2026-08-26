import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/audio_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/purchase_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Start Flutter UI first. Do not block the first frame on local storage,
  // billing, ads, or any other optional service. This prevents a startup
  // failure from leaving the user stuck on the native Flutter splash screen.
  final progressProvider = ProgressProvider();
  final purchaseProvider = PurchaseProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: progressProvider),
        ChangeNotifierProvider.value(value: purchaseProvider),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const BaraemApp(),
    ),
  );

  // Initialize non-critical services after the first frame. Each operation is
  // isolated so a plugin/storage failure cannot prevent the app from opening.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(_initializeServices(progressProvider, purchaseProvider));
  });
}

Future<void> _initializeServices(
  ProgressProvider progressProvider,
  PurchaseProvider purchaseProvider,
) async {
  try {
    await progressProvider.load();
  } catch (error, stackTrace) {
    debugPrint('Baraem: progress initialization failed: $error');
    debugPrintStack(stackTrace: stackTrace);
  }

  purchaseProvider.onPremiumChanged = (isPremium) {
    unawaited(progressProvider.setPremium(isPremium));
  };

  try {
    await purchaseProvider.init();
  } catch (error, stackTrace) {
    debugPrint('Baraem: purchase initialization failed: $error');
    debugPrintStack(stackTrace: stackTrace);
  }
}
