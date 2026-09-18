import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController resultController = TextEditingController();

  String _convertNumberToWords(String value) {
    if (value.trim().isEmpty) {
      return '';
    }

    final parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      return '';
    }

    if (parsedValue == 0) {
      return 'zero';
    }

    const ones = [
      'zero',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine'
    ];
    const teens = [
      'ten',
      'eleven',
      'twelve',
      'thirteen',
      'fourteen',
      'fifteen',
      'sixteen',
      'seventeen',
      'eighteen',
      'nineteen'
    ];
    const tens = [
      '',
      '',
      'twenty',
      'thirty',
      'forty',
      'fifty',
      'sixty',
      'seventy',
      'eighty',
      'ninety'
    ];
    const scales = ['', 'thousand', 'million', 'billion'];

    String convertUnderThousand(int number) {
      if (number < 10) {
        return ones[number];
      }
      if (number < 20) {
        return teens[number - 10];
      }
      if (number < 100) {
        final tensDigit = number ~/ 10;
        final onesDigit = number % 10;
        if (onesDigit == 0) {
          return tens[tensDigit];
        }
        return '${tens[tensDigit]} ${ones[onesDigit]}';
      }

      final hundredsDigit = number ~/ 100;
      final remainder = number % 100;
      if (remainder == 0) {
        return '${ones[hundredsDigit]} hundred';
      }
      return '${ones[hundredsDigit]} hundred ${convertUnderThousand(remainder)}';
    }

    final groups = <int>[];
    var remaining = parsedValue;
    while (remaining > 0) {
      groups.add(remaining % 1000);
      remaining ~/= 1000;
    }

    final words = <String>[];
    for (int i = groups.length - 1; i >= 0; i--) {
      final groupValue = groups[i];
      if (groupValue == 0) {
        continue;
      }

      final groupWords = convertUnderThousand(groupValue);
      final scale = scales[i];
      if (scale.isEmpty) {
        words.add(groupWords);
      } else {
        words.add('$groupWords $scale');
      }
    }

    return words.join(' ');
  }

  @override
  void dispose() {
    amountController.dispose();
    resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              amountController.text.isEmpty ? '0' : amountController.text,
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  resultController.text = _convertNumberToWords(value);
                  resultController.selection = TextSelection.fromPosition(
                    TextPosition(offset: resultController.text.length),
                  );
                });
              },
              style: const TextStyle(
                color: Colors.green,
              ),
              decoration: InputDecoration(
                hintText: 'Please enter the amount in USD',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: const Icon(Icons.monetization_on_outlined),
                prefixIconColor: Colors.black,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.pinkAccent,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: resultController,
              readOnly: true,
              style: const TextStyle(
                color: Colors.green,
              ),
              decoration: InputDecoration(
                hintText: 'You Entered Amount in USD in Words',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: const Icon(Icons.monetization_on_outlined),
                prefixIconColor: Colors.black,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.pinkAccent,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
