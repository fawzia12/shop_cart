import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shoplist/model/product.dart';
import 'package:shoplist/screen/update_product_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});
  final Products product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.network(
          widget.product.image ?? "",
          width: 40,
          height: 75,
          scale: 2.1,
        ),
        title: Text(
          'Product name:${widget.product.productname}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Code: ${widget.product.productcode ?? ''} ',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Quantity:${widget.product.qty ?? ''}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              ' unitPrice: ${widget.product.unitprice ?? ''}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'Total Price:${widget.product.totalPrice ?? ''}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
                onPressed: () {
               _customdialog(context,widget.product.id.toString());
                },
                icon: Container(
                    height: 40,
                    width: 47,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red),
                    child: const Icon(Icons.delete))),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UpdateProductScreen.home,
                    arguments: widget.product);
              },
              icon: Container(
                  height: 40,
                  width: 47,
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Icon(Icons.edit)),
            ),
          ],
        ));
  }
}

Future<void> _delateproduct(String id) async {
  Uri uri = Uri.parse(
      "https://crud.teamrabbil.com/api/v1/DeleteProduct/$id}");
  Response response = await get(uri);

}

void _customdialog(context,String id) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Container(
              height: 200,
              width: 200,
              color: Colors.white,
              child: Column(
                children: [
                  Image.network(
                      "https://cdn-icons-png.freepik.com/256/4980/4980658.png?semt=ais_hybrid",
                      scale: 4.6),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Are you sure to DElete?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _delateproduct(id);
                            
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('yes'))
                    ],
                  )
                ],
              ),
            ),
          ));
}
