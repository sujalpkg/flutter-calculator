import 'package:flutter/material.dart';

import '../models/conversion_model.dart';

class HistoryScreen extends StatelessWidget {
  final List<ConversionModel> history;

  const HistoryScreen({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: history.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.history_toggle_off,
                      size: 56,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No conversions yet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(item.toDisplayString()),
                      subtitle: Text(
                        '${item.conversionTime.day.toString().padLeft(2, '0')}-'
                        '${item.conversionTime.month.toString().padLeft(2, '0')}-'
                        '${item.conversionTime.year} '
                        '${item.conversionTime.hour.toString().padLeft(2, '0')}:'
                        '${item.conversionTime.minute.toString().padLeft(2, '0')}',
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
