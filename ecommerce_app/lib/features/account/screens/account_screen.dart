import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/features/account/widgets/below_app_bar.dart';
import 'package:ecommerce_app/features/account/widgets/orders.dart';
import 'package:ecommerce_app/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: 120,
                  height: 45,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: const Column(children: [
        BelowAppBar(),
        SizedBox(
          height: 10,
        ),
        TopButtons(),
        SizedBox(
          height: 10,
        ),
        Orders(),
      ]),
    );
  }
}
