import 'package:ecommerce_app/customs/widgets/bottom_bar.dart';
import 'package:ecommerce_app/features/address/screens/address_screen.dart';
import 'package:ecommerce_app/features/admin/screens/add_product_screen.dart';
import 'package:ecommerce_app/features/auth/screens/auth_screen.dart';
import 'package:ecommerce_app/features/home/screens/category_deals_page.dart';
import 'package:ecommerce_app/features/home/screens/home_screen.dart';
import 'package:ecommerce_app/features/order_details/screens/order_details.dart';
import 'package:ecommerce_app/features/product_details/screens/product_details.dart';
import 'package:ecommerce_app/features/search/screens/search_screen.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
        settings: routeSettings,
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const HomeScreen(), settings: routeSettings);

    case BottomBar.routeName:
      return MaterialPageRoute(
          builder: (context) => const BottomBar(), settings: routeSettings);

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const AddProductScreen(),
          settings: routeSettings);

    case CategoryDealsPage.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => CategoryDealsPage(
          category: category,
        ),
        settings: routeSettings,
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => SearchScreen(
                searchQuery: searchQuery,
              ),
          settings: routeSettings);

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
                product: product,
              ),
          settings: routeSettings);

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => AddressScreen(
          totalAmount: totalAmount,
        ),
        settings: routeSettings,
      );

    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          order: order,
        ),
        settings: routeSettings,
      );

    default:
      return (MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Screen does not exist"),
                ),
              )));
  }
}
