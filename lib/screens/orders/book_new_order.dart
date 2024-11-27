import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:xp_internal/constants/colors.dart';

class BookNewOrder extends StatefulWidget {
  const BookNewOrder({super.key});

  @override
  State<BookNewOrder> createState() => _BookNewOrderState();
}

class _BookNewOrderState extends State<BookNewOrder> {
  final String title = 'Book New Order';
  String? selectedValue;
  DateTime? selectedDate;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  List<bool> selectedService = <bool>[true, false];
  final List<String> customers = <String>['Zebronics', 'Adani', 'Birla'];
  @override
  void dispose() {
    _dateController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: newCardBG,
      appBar: AppBar(
        backgroundColor: newCardBG,
        title: Text(
          'Book New Orders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(screenWidth * 0.035),
              ),
              padding: EdgeInsets.all(screenWidth * 0.015),
              child: LayoutBuilder(
                builder: (context, constraints) => ToggleButtons(
                  constraints: BoxConstraints.expand(width: screenWidth / 2.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenWidth * 0.03),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                  ),
                  selectedColor: Colors.black,
                  fillColor: Colors.white,
                  color: Colors.white,
                  isSelected: selectedService,
                  children: <Widget>[
                    Text('Single Route'),
                    Text('Multiple Route'),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < selectedService.length; i++) {
                        selectedService[i] = i == index;
                      }
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            //customer selector
            // Customer selector
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.01,
                vertical: screenHeight * 0.01,
              ),
              child: TypeAheadField<String>(
                // Use the builder to create the TextField
                builder: (context, controller, focusNode) {
                  return TextField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: _textController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      ),
                      labelText: 'Select Customer',
                    ),
                  );
                },
                suggestionsCallback: (pattern) {
                  return getSuggestions(pattern);
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSelected: (String suggestion) {
                  setState(() {
                    _textController.text =
                        suggestion; // Display selected suggestion in the text field
                  });
                },
              ),
            ),
            //date selector
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.05),
                          borderSide: BorderSide.none),
                      labelText: 'Select Date',
                      prefixIcon: Align(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: Icon(Icons.calendar_month_rounded),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            searchableDropdown(
                screenHeight, screenWidth, 'Select Origin', Icons.map_outlined),
            searchableDropdown(screenHeight, screenWidth, 'Select Destination',
                Icons.location_on),
            searchableDropdown(screenHeight, screenWidth, 'Select Service Type',
                Icons.card_travel_rounded),
            searchableDropdown(screenHeight, screenWidth, 'Select Vehicle Type',
                Icons.local_shipping_outlined),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.035),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Align(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: Icon(Icons.format_list_numbered),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: Text(
                        'Select Number of Vehicles:',
                        style: TextStyle(fontSize: screenWidth * 0.036),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.15),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.2, vertical: screenHeight * 0.015),
        color: newCardBG,
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade900,
          onPressed: () {},
          child: Text(
            'Check Prices',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    // TextEditingController _dateController = TextEditingController();
    final DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String convertedDateTime =
            '${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        _dateController.text = convertedDateTime;
      });
    }
  }

  List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(customers);
    matches.retainWhere(
        (test) => test.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Widget searchableDropdown(double screenHeight, double screenWidth,
      String title, IconData iconInfo) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: screenHeight * 0.01),
          width: screenWidth * 0.9,
          child: TextField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: title,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                prefixIcon: Align(
                  heightFactor: 1,
                  widthFactor: 1,
                  child: Icon(
                    iconInfo,
                    color: Colors.black,
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget textField(
      BuildContext context, double screenHeight, double screenWidth) {
    return Container(
      child: TypeAheadField(
        itemBuilder: (context, suggestions) {
          return ListTile(
            title: Text('Select Destination'),
            contentPadding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
          );
        },
        onSelected: (suggestion) {},
        suggestionsCallback: (pattern) async {
          return;
        },
      ),
    );
  }
}
