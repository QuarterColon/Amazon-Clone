import 'package:ecommerce_app/customs/widgets/loader.dart';
import 'package:ecommerce_app/features/home/Services/home_services.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;
  @override
  void initState() {
    super.initState();
    fetchDealOfTheDay();
  }

  void fetchDealOfTheDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: const Text(
                      'Deal Of The Day',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Image.network(
                    product!.images[0],
                    height: 235,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      '\$100',
                      style: TextStyle(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 5,
                      right: 40,
                    ),
                    child: const Text(
                      'Shades',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: product!.images
                          .map(
                            (e) => Image.network(
                              e,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ).copyWith(
                      left: 15,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              );
  }
}
