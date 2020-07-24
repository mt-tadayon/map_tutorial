import 'package:flutter/material.dart';
import 'package:foldtutorial/widgets/form_input_field.dart';

class Item {
  String itemName;
  double itemPrice;

  Item({this.itemName, this.itemPrice});
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Item> items = [];
  bool sort = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _itemController;
  TextEditingController _priceController;

  Iterable<DataRow> rowTable(List<Item> items) {
    Iterable<DataRow> dataRows = items.map((item) {
      return DataRow(cells: [
        DataCell(
          Text(item.itemName),
        ),
        DataCell(
          Text(item.itemPrice.toString()),
        )
      ]);
    });
    return dataRows;
  }

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                FormInputField(
                  itemController: _itemController,
                  hintText: 'Item',
                  validateMessage: 'Please provide the item name',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FormInputField(
                        itemController: _priceController,
                        hintText: 'Price',
                        validateMessage: 'Please provide the price',
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          items.add(Item(
                              itemName: _itemController.text,
                              itemPrice: double.parse(_priceController.text)));
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
          DataTable(sortColumnIndex: 1, sortAscending: sort, columns: [
            DataColumn(
              label: Text('Item'),
            ),
            DataColumn(
              numeric: true,
              onSort: (int index, bool ascending) {
                if (ascending) {
                  items.sort((a, b) => b.itemPrice.compareTo(a.itemPrice));
                } else {
                  items.sort((a, b) => a.itemPrice.compareTo(b.itemPrice));
                }
                setState(() {
                  sort = ascending;
                });
              },
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Price'),
                    ],
                  ),
                ),
              ),
            ),
          ], rows:
            // TODO: Create a row for each item's name and item's price in the table
            rowTable(items).toList(),
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
