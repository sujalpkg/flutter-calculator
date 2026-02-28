import 'package:flutter/material.dart';

import '../models/conversion_model.dart';
import '../utils/exchange_rates.dart';

class ConvertScreen extends StatefulWidget {
  final ValueChanged<ConversionModel> onAddConversion;

  const ConvertScreen({
    super.key,
    required this.onAddConversion,
  });

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  final TextEditingController _amountController = TextEditingController();

  String _fromCurrency = 'INR';
  String _toCurrency = 'USD';
  double? _result;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _convertCurrency() {
    // Validation: amount field must not be empty and should be numeric.
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText);

    if (amountText.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount greater than 0.'),
        ),
      );
      return;
    }

    final convertedValue = ExchangeRates.convert(
      amount: amount,
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
    );

    final conversion = ConversionModel(
      inputAmount: amount,
      fromCurrency: _fromCurrency,
      toCurrency: _toCurrency,
      convertedAmount: convertedValue,
      conversionTime: DateTime.now(),
    );
    widget.onAddConversion(conversion);

    setState(() {
      _result = convertedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convert Currency'),
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
                    Text(
                      'Enter Details',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(
                            label: 'From',
                            value: _fromCurrency,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _fromCurrency = value);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdown(
                            label: 'To',
                            value: _toCurrency,
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _toCurrency = value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _convertCurrency,
                        icon: const Icon(Icons.currency_exchange),
                        label: const Text('Convert'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    if (_result == null)
                      const Text('Converted value will appear here.')
                    else
                      Text(
                        '${_amountController.text.trim()} $_fromCurrency = ${_result!.toStringAsFixed(2)} $_toCurrency',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Static Exchange Rates (base: INR)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text('1 USD = 83 INR'),
                    const Text('1 EUR = 90 INR'),
                    const Text('1 GBP = 105 INR'),
                    const Text('1 JPY = 0.55 INR'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: '$label Currency',
        prefixIcon: const Icon(Icons.public),
      ),
      items: ExchangeRates.supportedCurrencies
          .map(
            (currency) => DropdownMenuItem<String>(
              value: currency,
              child: Text(currency),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
