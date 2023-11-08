import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/drink.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class PaymentPage extends StatefulWidget {
  final List<Drink> cart;

  PaymentPage({required this.cart});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod; // ตัวแปรเพื่อเก็บวิธีการชำระเงินที่เลือก

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;

    // คำนวณยอดรวมราคาทั้งหมด
    for (var drink in widget.cart) {
      totalAmount += double.parse(drink.price);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('จ่ายเงิน'),
      ),
      body: Center(
        child: Container(
          color: Colors.brown[200], // ตั้งค่าสีพื้นหลังเป็นสีน้ำตาล
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Colors.brown[100],
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text('รายการจ่ายเงิน'),
                        // แสดงรายการสินค้าที่อยู่ในตะกร้า
                        ListView.builder(
                          itemCount: widget.cart.length,
                          shrinkWrap: true, // จัดการเรื่องขนาดของ ListView
                          itemBuilder: (context, index) {
                            // แสดงรายละเอียดของสินค้าที่อยู่ในตะกร้า
                            return ListTile(
                              title: Text(widget.cart[index].name),
                              subtitle: Text(widget.cart[index].price),
                            );
                          },
                        ),
                        // แสดงยอดรวมราคาทั้งหมด
                        Text('ราคารวม: ${totalAmount.toStringAsFixed(2)} \บาท'),
                        // เส้นขีดระหว่างกลาง
                        Divider(
                          color: Colors.black,
                        ),

                        // เพิ่มเลือกวิธีการชำระเงิน (เงินสด หรือ แสกน QR โค้ด)
                        Text('ช่องทางการชำระ'),
                        Row(
                          children: <Widget>[
                            Radio<String>(
                              value: 'Cash',
                              groupValue: selectedPaymentMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPaymentMethod = value;
                                });
                              },
                            ),
                            Text('เงินสด'),
                            Radio<String>(
                              value: 'Ture Wallet',
                              groupValue: selectedPaymentMethod,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPaymentMethod = value;
                                });
                              },
                            ),
                            Text('Ture Wallet'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // ปุ่มยืนยันการชำระเงิน
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // ดำเนินการตรวจสอบและจัดการการชำระเงินที่เลือกที่นี่

                        // เมื่อการชำระเงินเสร็จสิ้น, กลับไปที่หน้าร้าน
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('ชำระเงินเสร็จสิ้น'),
                              content: Text('ขอบคุณที่ชำระเงินเรียบร้อยแล้ว!'),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // ปิดกล่องข้อความ
                                    Navigator.of(context)
                                        .pop(); // กลับไปที่หน้าร้าน
                                  },
                                  child: Center(
                                    child: Text('ตกลง'),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                            Size(100, 50)), // กำหนดความสูงของปุ่ม
                      ),
                      child: Text('ยืนยันการชำระเงิน'),
                    ),
                  ],
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
