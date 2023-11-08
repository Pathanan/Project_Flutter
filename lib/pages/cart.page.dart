import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/drink_tile.dart';
import 'package:flutter_application_1/models/drink.dart';
import 'package:flutter_application_1/models/shop.dart';
import 'package:flutter_application_1/pages/PaymentPage.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //remove drink form cart
  void removeFromCart(Drink drink) {
    Provider.of<BubbleTeaShop>(context, listen: false).removeFromeCart(drink);
  }

  double calculateTotalAmount(List<Drink> cart) {
    double total = 0;
    for (var drink in cart) {
      total += double.parse(drink.price);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BubbleTeaShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // หัวเรื่อง
              const Text(
                'ตะกร้าสินค้า',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 10),

              // รายการในตะกร้า
              Expanded(
                child: ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) {
                    // รับสินค้าแต่ละในตะกร้า
                    Drink drink = value.cart[index];

                    // แสดงเป็นไทล์ที่ดูดี
                    return DrinkTile(
                      drink: drink,
                      onTap: () => removeFromCart(drink),
                      trailing: Icon(Icons.delete),
                    );
                  },
                ),
              ),

              // ยอดรวม
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'ยอดรวม: ${calculateTotalAmount(value.cart).toStringAsFixed(2)} \บาท',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // ปุ่มชำระเงิน
              Container(
                height: 50, // ทำให้ปุ่มเต็มความกว้าง
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(30.0), // กำหนดรูปแบบโค้งขอบ
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown, // สีพื้นหลังของปุ่ม
                    ),
                    onPressed: () {
                      // สร้าง List ของรายการสินค้าในตะกร้า
                      List<Drink> cartItems = value.cart;

                      // Navigate to PaymentPage พร้อมส่งข้อมูลที่อยู่ในตะกร้า
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPage(cart: cartItems)),
                      );
                    },
                    child: Text('จ่ายเงิน'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
