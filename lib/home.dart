import 'package:flutter/material.dart';
import 'item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _sum = 0;
  bool _showSelected = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      screenWidth = screenWidth * 0.8;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food MENU'),
        centerTitle: true,
        actions: [
          Tooltip(
            message: 'Reset selection',
            child: IconButton(
              onPressed: () {
                setState(() {
                  _sum = 0;
                  for (var e in items) {
                    e.selected = false;
                    e.quantity = 1;
                    e.combo = 'None';
                  }
                  _showSelected = false;
                });
              },
              icon: const Icon(Icons.restore),
            ),
          ),
          Tooltip(
            message: 'Show/Hide Selected Items',
            child: IconButton(
              onPressed: () {
                if (_sum != 0) {
                  setState(() {
                    _showSelected = !_showSelected;
                  });
                }
              },
              icon: const Icon(Icons.shopping_cart_checkout),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _showSelected
                ? ListView.builder(
              itemCount: items.where((item) => item.selected).length,
              itemBuilder: (context, index) {
                var selectedItems = items.where((item) => item.selected).toList();
                return _buildItemRow(selectedItems[index], screenWidth);
              },
            )
                : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildItemRow(items[index], screenWidth);
              },
            ),
          ),
          BottomAppBar(
            elevation: 8,
            child: Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  'Total Price: \$${_sum.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(Item item, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            item.image,
            height: screenWidth * 0.3,
            width: screenWidth * 0.3,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: item.selected,
                      onChanged: (e) {
                        setState(() {
                          item.selected = e!;
                          _recalculateSum();
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    QuantityDropdown(
                      initialQuantity: item.quantity,
                      updateQuantity: (quantity) {
                        setState(() {
                          item.quantity = quantity;
                          _recalculateSum();
                        });
                      },
                    ),
                  ],
                ),
                ComboDropdown(
                  initialCombo: item.combo,
                  updateCombo: (combo) {
                    setState(() {
                      item.combo = combo;
                      _recalculateSum();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _recalculateSum() {
    _sum = 0;
    for (var item in items) {
      if (item.selected) {
        _sum += item.price * item.quantity;
        if (item.combo == 'French Fries') _sum += 4 * item.quantity;
        if (item.combo == 'Wedge Fries') _sum += 5 * item.quantity;
        if (item.combo == 'Curly Fries') _sum += 6 * item.quantity ;
      }
    }
  }
}
