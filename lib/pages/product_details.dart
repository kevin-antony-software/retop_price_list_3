import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetails extends StatefulWidget {
  static const String id = 'product_details';

  const ProductDetails({
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  final String productName;
  final String productPrice;
  final String productImage;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double _currentSliderValue = 20;
  double afterDiscount = 0;

  @override
  Widget build(BuildContext context) {
    afterDiscount =
        double.parse(widget.productPrice) * (1 - _currentSliderValue / 100);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: Material(
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.productImage),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Selling Price is : Rs ",
                  ),
                  TextSpan(
                    text: NumberFormat.currency(locale: 'si-Rs', symbol: '')
                        .format(double.parse(widget.productPrice))
                        .toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Discount : $_currentSliderValue %",
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            StatefulBuilder(
              builder: (context, state) => Center(
                child: Slider(
                  value: _currentSliderValue,
                  min: 0.0,
                  divisions: 40,
                  max: 40.0,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double newValue) {
                    setState(() {
                      _currentSliderValue = newValue;
                      afterDiscount = (double.parse(widget.productPrice) *
                          (1 - newValue / 100));
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Discounted Price is : Rs ",
                  ),
                  TextSpan(
                    text: NumberFormat.currency(locale: 'si-Rs', symbol: '')
                        .format(afterDiscount)
                        .toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
