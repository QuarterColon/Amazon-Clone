// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/features/admin/models/sales.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String description,
    required String category,
    required String name,
    required double price,
    required int quantity,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dxnks5kxh", "fuy7kqwk");
      List<String> imageUrls = [];
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          category: category,
          price: price,
          quantity: quantity,
          images: imageUrls);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Product added succesfully");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(
    BuildContext context,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (var i = 0; i < (jsonDecode(res.body)).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders({
    required BuildContext context,
  }) async {
    List<Order> orders = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (var i = 0; i < (jsonDecode(res.body)).length; i++) {
              orders.add(
                Order.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
              print(orders);
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orders;
  }

  void changeOrderStatus({
    required BuildContext context,
    required Order order,
    required VoidCallback onSuccess,
    required int status,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/change-order-status"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'id': order.id,
                'status': status,
              }));

      httpErrorHandle(response: res, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> earnings = [];
    int totalEarnings = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var response = json.decode(res.body);
            totalEarnings = response['totalEarnings'];
            earnings = [
              Sales(
                label: 'Mobiles',
                earnings: response['mobileEarnings'],
              ),
              Sales(
                label: 'Essentials',
                earnings: response['essentialEarnings'],
              ),
              Sales(
                label: 'Appliances',
                earnings: response['applianceEarnings'],
              ),
              Sales(
                label: 'Books',
                earnings: response['booksEarnings'],
              ),
              Sales(
                label: 'Fashion',
                earnings: response['fashionEarnings'],
              ),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return {
      'sales': earnings,
      'totalEarnings': totalEarnings,
    };
  }
}
