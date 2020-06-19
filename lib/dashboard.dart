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
                FormInputField(
                  itemController: _itemController,
                  hintText: 'Item',
                  validateMessage: 'Please provide the item name',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FormInputField(
                        itemController: _priceController,
                        hintText: 'price',
                        validateMessage: 'Please provide the price',
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          newItem = _itemController.text;
                          newPrice = _priceController.text;
                          items.add(
                              Item(itemName: newItem, itemPrice: newPrice));
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

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key key,
    @required TextEditingController itemController,
    this.hintText,
    this.validateMessage,
  })  : _controller = itemController,
        super(key: key);

  final TextEditingController _controller;
  final String hintText;
  final String validateMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () => _controller.clear(),
            icon: Icon(Icons.clear),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return validateMessage;
        }
        return null;
      },
    );
  }
}
