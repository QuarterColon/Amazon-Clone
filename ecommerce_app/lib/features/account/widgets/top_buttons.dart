import 'package:ecommerce_app/features/account/services/account_services.dart';
import 'package:ecommerce_app/features/account/widgets/account_button.dart';
import 'package:ecommerce_app/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Your Orders",
              onTap: () {},
            ),
            AccountButton(
              text: "Turn Seller",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: "Log Out",
              onTap: () {
                AuthService().logOut(context: context);
              },
            ),
            AccountButton(
              text: "Your Wishlist",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
