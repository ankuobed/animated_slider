import 'package:flutter/material.dart';
import 'package:playground/models/Bottle.dart';

class BottleWidget extends StatelessWidget {
  final Bottle bottle;
  const BottleWidget({Key? key, required this.bottle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color foregroundColor =
        bottle.color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Image.asset(
              bottle.imageUrl,
              height: 500,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(bottle.caption,
                style: TextStyle(color: foregroundColor, fontSize: 19)),
            Divider(height: 50, color: foregroundColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${bottle.price}',
                  style: TextStyle(
                    color: foregroundColor,
                    fontSize: 19,
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: foregroundColor)),
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.add, color: foregroundColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
