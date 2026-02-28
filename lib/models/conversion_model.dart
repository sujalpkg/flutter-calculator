class ConversionModel {
  final double inputAmount;
  final String fromCurrency;
  final String toCurrency;
  final double convertedAmount;
  final DateTime conversionTime;

  ConversionModel({
    required this.inputAmount,
    required this.fromCurrency,
    required this.toCurrency,
    required this.convertedAmount,
    required this.conversionTime,
  });

  // Returns a beginner-friendly display string for list items.
  String toDisplayString() {
    return '${inputAmount.toStringAsFixed(2)} $fromCurrency → $toCurrency = ${convertedAmount.toStringAsFixed(2)} $toCurrency';
  }
}
