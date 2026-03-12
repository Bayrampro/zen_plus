import 'package:flutter/material.dart';

import 'screens/meditations_screen.dart';
import 'screens/paywall_screen.dart';
import 'services/subscription_prefs_service.dart';

void main() {
  runApp(const ZenPulseApp());
}

class ZenPulseApp extends StatefulWidget {
  const ZenPulseApp({super.key});

  @override
  State<ZenPulseApp> createState() => _ZenPulseAppState();
}

class _ZenPulseAppState extends State<ZenPulseApp> {
  final SubscriptionPrefsService _subscriptionPrefsService =
      const SubscriptionPrefsService();

  bool? isSubscribed;
  bool hasDismissedInitialPaywall = false;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _loadSubscriptionState();
  }

  Future<void> _loadSubscriptionState() async {
    final value = await _subscriptionPrefsService.loadIsSubscribed();
    if (!mounted) {
      return;
    }
    setState(() {
      isSubscribed = value;
    });
  }

  void _dismissInitialPaywall() {
    setState(() {
      hasDismissedInitialPaywall = true;
    });
  }

  void _showPaywall() {
    _navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => PaywallScreen(
          onTryFree: () => _navigatorKey.currentState?.pop(),
          onClose: () => _navigatorKey.currentState?.pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'ZenPulse',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7EB8A4),
          brightness: Brightness.light,
        ),
      ),
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    if (isSubscribed == null) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (isSubscribed == false) {
      if (!hasDismissedInitialPaywall) {
        return PaywallScreen(
          onTryFree: _dismissInitialPaywall,
          onClose: _dismissInitialPaywall,
        );
      }

      return MeditationsScreen(
        isSubscribed: false,
        onOpenPaywall: _showPaywall,
      );
    }

    return MeditationsScreen(
      isSubscribed: true,
      onOpenPaywall: _showPaywall,
    );
  }
}
