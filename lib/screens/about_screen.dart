import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final bool showRates;

  const AboutScreen({
    super.key,
    this.showRates = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showRates ? 'Exchange Rates' : 'About App'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          showRates
                              ? Icons.currency_exchange
                              : Icons.info_outline_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          showRates
                              ? 'Static Exchange Rates'
                              : 'Currency Converter App',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (showRates) ...[
                      _buildInfoRow('1 USD', '83 INR'),
                      _buildInfoRow('1 EUR', '90 INR'),
                      _buildInfoRow('1 GBP', '105 INR'),
                      _buildInfoRow('1 JPY', '0.55 INR'),
                      const SizedBox(height: 8),
                      Text(
                        'Note: These are static values for educational use.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ] else ...[
                      Text(
                        'This Flutter app converts values between INR, USD, EUR, GBP, and JPY using static exchange rates. It demonstrates beautiful UI design, multi-screen navigation, theme switching, and local history tracking.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 8),
                      _buildInfoRow('Developer', 'Sujal Jain'),
                      _buildInfoRow(
                        'Course',
                        'Mobile Application Development',
                      ),
                      _buildInfoRow('Version', '1.0.0'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Design Highlights',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text('• Material 3 components'),
                    const Text('• Responsive spacing and rounded cards'),
                    const Text('• Light and Dark theme support'),
                    const Text('• Beginner-friendly and readable Dart code'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
