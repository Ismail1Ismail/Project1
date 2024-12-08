import 'package:flutter/material.dart';

class Item {
  final String _name;
  final double _price;
  bool _selected = false;
  final String _image;
  int _quantity = 1;
  String _combo = 'None';

  Item(this._name, this._price, this._image);


  String get name => _name;
  double get price => _price;
  bool get selected => _selected;
  String get image => _image;
  int get quantity => _quantity;
  String get combo => _combo;

  set selected(bool e) => _selected = e;
  set quantity(int q) => _quantity = q;
  set combo(String c) => _combo = c;

  @override
  String toString() {
    String space = '';
    for (int i = 0; i < 3 - _price.toString().length; i++) {
      space += ' ';
    }
    return 'Price: \$$_price $space$_name';
  }
}


List<Item> items = [
  Item('Fried Chicken Burger', 7,
      "https://images.unsplash.com/photo-1637710847214-f91d99669e18?q=80&w=1021&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  Item('Chicken Mozzarella', 8,
      "https://stpierrebakery-co-uk.s3.eu-west-1.amazonaws.com/app/uploads/2022/10/Chicken-Mozzarella-Burger-1440x960.jpg"),
  Item('Classic Burger', 10,
      "https://images.unsplash.com/photo-1508737027454-e6454ef45afd?q=80&w=986&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  Item('Mushroom Burger', 12,
      "https://images.unsplash.com/photo-1551987840-f62d9c74ae78?q=80&w=981&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  Item('Smash Burger', 11,
      "https://images.unsplash.com/photo-1678110707289-ab14382a1625?q=80&w=996&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  Item('Bacon  Burger', 12,
      "https://images.unsplash.com/photo-1553979459-d2229ba7433b?q=80&w=1068&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  Item('HotDog', 4,
      "https://images.unsplash.com/photo-1607103071568-159bb70b4bf0?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),

];



class QuantityDropdown extends StatefulWidget {
  final Function(int) updateQuantity;
  final int initialQuantity;

  const QuantityDropdown({required this.updateQuantity, required this.initialQuantity, Key? key}) : super(key: key);

  @override
  State<QuantityDropdown> createState() => _QuantityDropdownState();
}

class _QuantityDropdownState extends State<QuantityDropdown> {
  int _selectedQuantity = 1;

  @override
  void initState() {
    super.initState();
    _selectedQuantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: _selectedQuantity,
      items: List.generate(10, (index) => index + 1)
          .map((quantity) => DropdownMenuItem(
        value: quantity,
        child: Text(quantity.toString()),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedQuantity = value!;
          widget.updateQuantity(_selectedQuantity);
        });
      },
    );
  }
}


class ComboDropdown extends StatefulWidget {
  final Function(String) updateCombo;
  final String initialCombo;

  const ComboDropdown({required this.updateCombo, required this.initialCombo, Key? key}) : super(key: key);

  @override
  State<ComboDropdown> createState() => _ComboDropdownState();
}

class _ComboDropdownState extends State<ComboDropdown> {
  String _selectedCombo = 'None';

  @override
  void initState() {
    super.initState();
    _selectedCombo = widget.initialCombo;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedCombo,
      items: ['None', 'French Fries', 'Wedge Fries', 'Curly Fries']
          .map((combo) => DropdownMenuItem(
        value: combo,
        child: Text(combo),
      ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCombo = value!;
          widget.updateCombo(_selectedCombo);
        });
      },
    );
  }
}
