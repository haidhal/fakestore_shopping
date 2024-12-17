import 'dart:developer';

import 'package:fakestore_shopping/controller/home_controller.dart';
import 'package:fakestore_shopping/main.dart';
import 'package:fakestore_shopping/model/cart_model.dart';
import 'package:fakestore_shopping/views/home/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.read<HomeController>().getAllProduct());
  }

  bool isAdd = false;
  @override
  Widget build(BuildContext context) {
    var proWatch = context.watch<HomeController>();
    var proRead = context.read<HomeController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ));
              },
              icon: const Icon(Icons.card_travel))
        ],
      ),
      body: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              proWatch.isLoading != true
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 200),
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),

                          // width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                          height: 100,
                                          proWatch.prodData[index].image
                                              .toString()),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 8,
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            isAdd = proRead.isCart(isAdd);
                                            log(isAdd.toString());
                                            proRead.cartAdd(CartModel(
                                                id: proWatch.prodData[index].id,
                                                image: proWatch
                                                    .prodData[index].image
                                                    .toString(),
                                                price: proWatch
                                                    .prodData[index].price
                                                    .toString(),
                                                rating: proWatch.prodData[index]
                                                    .rating!.rate
                                                    .toString(),
                                                title: proWatch
                                                    .prodData[index].title
                                                    .toString()));
                                          },
                                          icon: Icon(isAdd == true
                                              ? Icons.favorite_outline
                                              : Icons.favorite_outline),
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      proWatch.prodData[index].title.toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Text(
                                    "⭐ ${proWatch.prodData[index].rating!.rate.toString()}",
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "\$${proWatch.prodData[index].price.toString()}",
                              ),
                            ],
                          ),
                        ),
                        itemCount: proWatch.prodData.length,
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
