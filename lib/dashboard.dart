import 'package:flutter/material.dart';

class Item {
  String itemName;
  String itemPrice;

  Item({this.itemName, this.itemPrice});
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static String newItem = '';
  static String newPrice = '';
  List<Item> items = [];

  final _formKey = GlobalKey<FormState>();
  TextEditingController _itemController;
  TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _itemController,
                  decoration: InputDecoration(
                    hintText: 'Item',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => _itemController.clear(),
                      icon: Icon(Icons.clear),
                    )
                  ),
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Please provide item name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          hintText: 'Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                            suffixIcon: IconButton(
                              onPressed: () => _priceController.clear(),
                              icon: Icon(Icons.clear),
                            )
                        ),
                        validator: (value) {
                          if(value.isEmpty) {
                            return 'Please provide price';
                          }
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          newItem = _itemController.text;
                          newPrice = _priceController.text;
                          items.add(Item(itemName: newItem, itemPrice: newPrice));
                          setState(() {
                            _itemController.clear();
                            _priceController.clear();
                          });
                        }
                      },
                      icon: Icon(
                        Icons.subdirectory_arrow_left,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DataTable(
            columnSpacing: MediaQuery.of(context).size.width * 0.6,
            columns: [
              DataColumn(
                label: Text('Item'),
              ),
              DataColumn(
                label: Text('Price'),
              ),
            ],
            rows: items
                .map(
                  (element) => DataRow(
                    cells: [
                      DataCell(
                        Text(element.itemName),
                      ),
                      DataCell(
                        Text(element.itemPrice),
                      ),
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _itemController.dispose();
  }
}
