class ExchangeRates {
  // Static exchange rates with INR as the base reference currency.
  static const Map<String, double> ratesInInr = {
    'INR': 1.0,
    'USD': 83.0,
    'EUR': 90.0,
    'GBP': 105.0,
    'JPY': 0.55,
  };

  static List<String> get supportedCurrencies => ratesInInr.keys.toList();

  // Converts amount from one currency to another through INR.
  // Formula:
  // amountInINR = amount * rate(from)
  // convertedAmount = amountInINR / rate(to)
  static double convert({
    required double amount,
    required String fromCurrency,
    required String toCurrency,
  }) {
    if (!ratesInInr.containsKey(fromCurrency) ||
        !ratesInInr.containsKey(toCurrency)) {
      throw ArgumentError('Unsupported currency selected.');
    }

    final amountInInr = amount * ratesInInr[fromCurrency]!;
    final convertedAmount = amountInInr / ratesInInr[toCurrency]!;
    return convertedAmount;
  }
}
