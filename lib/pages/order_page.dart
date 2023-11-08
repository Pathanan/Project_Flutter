import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/drink.dart';
import 'package:flutter_application_1/models/shop.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  final Drink drink;
  const OrderPage({
    super.key,
    required this.drink,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // customize sweetness
  double sweetValue = 0.5;
  void customizeSweet(double newValue) {
    setState(() {
      sweetValue = newValue;
    });
  }

  // customize ice
  double iceValue = 0.5;
  void customizeice(double newValue) {
    setState(() {
      iceValue = newValue;
    });
  }

  // customize pearls
  double pearlsValue = 0.5;
  void customizepearls(double newValue) {
    setState(() {
      pearlsValue = newValue;
    });
  }

  String selectedSize = 'M';
  void changeSize(String newSize) {
    setState(() {
      selectedSize = newSize;
    });
  }
// ค่าเริ่มต้นคือ Medium (M)

  //add to cart
  void addToCart() {
    //firstly, add to cart
    Provider.of<BubbleTeaShop>(context, listen: false).addToCart(widget.drink);

    //direct user back to shop page
    Navigator.pop(context);

    //let user know it has been successfuly added
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('เพิ่มลงตะกร้าเรียบร้อยแล้ว'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.drink.name)),
        backgroundColor: Colors.brown[200],
        body: SingleChildScrollView(
          child: Column(children: [
            //drink image
            Image.asset(widget.drink.imagePath),

            // sliders to customize drink
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // sweetness slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 100, child: Text('ระดับความหวาน')),
                      Expanded(
                        child: Slider(
                          value: sweetValue,
                          label: sweetValue.toString(),
                          divisions: 4,
                          onChanged: (value) => customizeSweet(value),
                        ),
                      ),
                    ],
                  ),

                  // ice slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 100, child: Text('ระดับน้ำแข็ง')),
                      Expanded(
                        child: Slider(
                          value: iceValue,
                          label: iceValue.toString(),
                          divisions: 4,
                          onChanged: (value) => customizeice(value),
                        ),
                      ),
                    ],
                  ),

                  //pearls slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 100, child: Text('ไข่มุก')),
                      Expanded(
                        child: Slider(
                          value: pearlsValue,
                          label: pearlsValue.toString(),
                          divisions: 4,
                          onChanged: (value) => customizepearls(value),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 100, child: Text('ขนาด')),
                      Row(
                        children: ['S', 'M', 'L']
                            .map((size) => Row(
                                  children: [
                                    Radio(
                                      value: size,
                                      groupValue: selectedSize,
                                      onChanged: (value) => changeSize(size),
                                    ),
                                    Text(size),
                                  ],
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // add to cart button
            Container(
              height: 50, // กำหนดความสูงของปุ่ม
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0), // กำหนดรูปแบบโค้งขอบ
                child: MaterialButton(
                  height: 50, // กำหนดความสูงของปุ่ม
                  child: Text(
                    'เพิ่มลงตะกร้า',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.brown,
                  onPressed: addToCart,
                ),
              ),
            ),
          ]),
        ));
  }
}
