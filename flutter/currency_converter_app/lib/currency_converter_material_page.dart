import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  static const double _rate = 83.0;

  final TextEditingController inrController = TextEditingController();
  final TextEditingController usdController = TextEditingController();

  String _formatAmount(double value) {
    return value.toStringAsFixed(2);
  }

  void _updateUsdFromInr(String value) {
    if (value.trim().isEmpty) {
      usdController.clear();
      return;
    }

    final inrAmount = double.tryParse(value);
    if (inrAmount == null) {
      return;
    }

    final usdAmount = inrAmount / _rate;
    usdController.value = TextEditingValue(
      text: _formatAmount(usdAmount),
      selection: TextSelection.collapsed(
        offset: _formatAmount(usdAmount).length,
      ),
    );
  }

  void _updateInrFromUsd(String value) {
    if (value.trim().isEmpty) {
      inrController.clear();
      return;
    }

    final usdAmount = double.tryParse(value);
    if (usdAmount == null) {
      return;
    }

    final inrAmount = usdAmount * _rate;
    inrController.value = TextEditingValue(
      text: _formatAmount(inrAmount),
      selection: TextSelection.collapsed(
        offset: _formatAmount(inrAmount).length,
      ),
    );
  }

  Widget _currencyField({
    required String label,
    required String prefix,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required ValueKey<String> key,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        key: key,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter $label amount',
          prefixText: prefix,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.amber, width: 2),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    inrController.dispose();
    usdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Basic Currency Converter',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                _currencyField(
                  key: const ValueKey('inr_amount'),
                  label: 'INR',
                  prefix: '₹ ',
                  controller: inrController,
                  onChanged: _updateUsdFromInr,
                ),
                const SizedBox(height: 16),
                _currencyField(
                  key: const ValueKey('usd_amount'),
                  label: 'USD',
                  prefix: '\$ ',
                  controller: usdController,
                  onChanged: _updateInrFromUsd,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Fixed rate: 1 USD = 83 INR',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.amber,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
