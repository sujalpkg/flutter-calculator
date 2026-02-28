import 'package:flutter/material.dart';

import '../models/conversion_model.dart';
import 'about_screen.dart';
import 'convert_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<ThemeMode> onThemeChanged;
  final List<ConversionModel> history;
  final ValueChanged<ConversionModel> onAddConversion;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.history,
    required this.onAddConversion,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter App'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              onThemeChanged(
                isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Convert currencies with a clean and easy interface.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildNavigationCard(
                    context,
                    title: 'Convert Currency',
                    subtitle: 'Calculate exchange value instantly',
                    icon: Icons.currency_exchange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConvertScreen(
                            onAddConversion: onAddConversion,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildNavigationCard(
                    context,
                    title: 'Exchange Rates',
                    subtitle: 'View static rates used in this app',
                    icon: Icons.bar_chart,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AboutScreen(showRates: true),
                        ),
                      );
                    },
                  ),
                  _buildNavigationCard(
                    context,
                    title: 'Conversion History',
                    subtitle: 'See all previous conversions',
                    icon: Icons.history,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryScreen(history: history),
                        ),
                      );
                    },
                  ),
                  _buildNavigationCard(
                    context,
                    title: 'About App',
                    subtitle: 'Project details and developer info',
                    icon: Icons.info_outline,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
