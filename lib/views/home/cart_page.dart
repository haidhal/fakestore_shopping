import 'package:fakestore_shopping/controller/home_controller.dart';
import 'package:fakestore_shopping/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.read<HomeController>().getCartData());
    super.initState();
  }

  int quat = 1;

  @override
  Widget build(BuildContext context) {
    var proWatch = context.watch<HomeController>();
    var proRead = context.read<HomeController>();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            Image.network(
                              proRead.cartData[index].image.toString(),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: Text(
                                proWatch.cartData[index].title.toString(),
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            quat++;
                                          });

                                          proRead.qntUpdate(
                                              index,
                                              CartModel(
                                                id: proWatch.cartData[index].id,
                                                image: proWatch
                                                    .cartData[index].image
                                                    .toString(),
                                                price: proWatch
                                                    .cartData[index].price
                                                    .toString(),
                                                rating: proWatch
                                                    .cartData[index].rating
                                                    .toString(),
                                                title: proWatch
                                                    .cartData[index].title
                                                    .toString(),
                                                qny: quat,
                                              ));
                                        },
                                        icon: const Text('+')),
                                    Text("Qty ${proWatch.cartData[index].qny}"),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            quat--;
                                          });

                                          proRead.qntUpdate(
                                              index,
                                              CartModel(
                                                id: proWatch.cartData[index].id,
                                                image: proWatch
                                                    .cartData[index].image
                                                    .toString(),
                                                price: proWatch
                                                    .cartData[index].price
                                                    .toString(),
                                                rating: proWatch
                                                    .cartData[index].rating
                                                    .toString(),
                                                title: proWatch
                                                    .cartData[index].title
                                                    .toString(),
                                                qny: quat,
                                              ));
                                        },
                                        icon: const Text('-')),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      proRead.delectCart(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: proWatch.cartData.length),
            )
          ],
        ),
      ),
    );
  }
}
