import 'package:flutter/material.dart';

import '../models/conversion_model.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeChanged;
  final List<ConversionModel> history;
  final ValueChanged<ConversionModel> onAddConversion;

  const SplashScreen({
    super.key,
    required this.onThemeChanged,
    required this.history,
    required this.onAddConversion,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Simple fade + scale animation for logo and title.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _fadeAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.80, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _animationController.forward();

    // In debug mode, Android/Flutter may still show a brief native launch splash
    // before this custom Flutter splash. That's expected in many setups.
    // Keep this transition short so the user experience feels like one smooth splash.
    Future.delayed(const Duration(milliseconds: 320), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 280),
          pageBuilder: (_, __, ___) => HomeScreen(
            onThemeChanged: widget.onThemeChanged,
            history: widget.history,
            onAddConversion: widget.onAddConversion,
          ),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'YOUR LOGO',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Currency Converter',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fast • Simple • Beautiful',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
