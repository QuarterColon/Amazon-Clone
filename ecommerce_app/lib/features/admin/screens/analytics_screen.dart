import 'package:charts_flutter_maintained/charts_flutter_maintained.dart'
    as charts;
import 'package:ecommerce_app/customs/widgets/loader.dart';
import 'package:ecommerce_app/features/admin/models/sales.dart';
import 'package:ecommerce_app/features/admin/services/admin_services.dart';
import 'package:ecommerce_app/features/admin/widgets/category_products_charts.dart';
import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context: context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (earnings == null || totalSales == null)
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                    id: 'Sales',
                    data: earnings!,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earnings,
                  )
                ]),
              )
            ],
          );
  }
}
