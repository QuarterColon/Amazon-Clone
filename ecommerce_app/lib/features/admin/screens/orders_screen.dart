import 'package:ecommerce_app/customs/widgets/loader.dart';
import 'package:ecommerce_app/features/account/widgets/single_product.dart';
import 'package:ecommerce_app/features/admin/services/admin_services.dart';
import 'package:ecommerce_app/features/order_details/screens/order_details.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;

  final AdminServices adminServices = AdminServices();

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, OrderDetailsScreen.routeName,
                    arguments: orderData),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(image: orderData.products[0].images[0]),
                ),
              );
            },
          );
  }
}
