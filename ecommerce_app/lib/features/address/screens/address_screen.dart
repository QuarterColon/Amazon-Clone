import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/customs/widgets/custom_button.dart';
import 'package:ecommerce_app/customs/widgets/custom_textfield.dart';
import 'package:ecommerce_app/features/address/services/address_services.dart';
import 'package:ecommerce_app/paymentconfig/gpay.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController tf1 = TextEditingController();
  final TextEditingController tf2 = TextEditingController();
  final TextEditingController tf3 = TextEditingController();
  final TextEditingController tf4 = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final List<PaymentItem> paymentItems = [];
  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    paymentItems.add(PaymentItem(
      amount: widget.totalAmount,
      type: PaymentItemType.total,
      status: PaymentItemStatus.final_price,
    ));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tf1.dispose();
    tf2.dispose();
    tf3.dispose();
    tf4.dispose();
  }

  // void onGooglePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressServices.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }

  //   addressServices.placeOrder(
  //       context: context,
  //       address: addressToBeUsed,
  //       totalSum: double.parse(widget.totalAmount));
  // }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = tf1.text.isNotEmpty ||
        tf2.text.isNotEmpty ||
        tf3.text.isNotEmpty ||
        tf4.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${tf1.text}, ${tf2.text}, ${tf4.text}, -  ${tf3.text}";
      } else {
        throw Exception("Please all the values.");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "Error");
    }

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }

    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  if (address.isNotEmpty)
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              address,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: tf1,
                    hintText: "Flat, House no. , building",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: tf2,
                    hintText: "Area, Street",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: tf3,
                    hintText: "Pincode",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: tf4,
                    hintText: "Town/ City",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // GooglePayButton(
            //   onPressed: () => payPressed(address),
            //   width: double.infinity,
            //   type: GooglePayButtonType.pay,
            //   onPaymentResult: onGooglePayResult,
            //   paymentItems: paymentItems,
            //   margin: const EdgeInsets.only(top: 15),
            //   height: 50,
            //   paymentConfiguration: PaymentConfiguration.fromJsonString(
            //       GooglePayConfig.googlePay),
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
            CustomButton(
                text: "Place Order", onTap: (() => payPressed(address))),
          ]),
        ),
      ),
    );
  }
}
