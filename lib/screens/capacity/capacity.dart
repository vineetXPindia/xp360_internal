import 'package:flutter/material.dart';
import 'package:xp_internal/constants/colors.dart';
import 'package:xp_internal/widgets/top_bar.dart';

class CapacityPage extends StatelessWidget {
  const CapacityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = 'Capacity Page';
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Value notifiers to manage state
    final ValueNotifier<List<bool>> selectedService =
        ValueNotifier([true, false]);
    final ValueNotifier<String?> selectedValue = ValueNotifier(null);

    final List<Widget> serviceToggle = <Widget>[Text('FCL'), Text('LCL')];

    return Scaffold(
      backgroundColor: newCardBG,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TopBar(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              title: title,
            ),
            ValueListenableBuilder<List<bool>>(
              valueListenable: selectedService,
              builder: (context, value, child) {
                return ToggleButtons(
                  onPressed: (int index) {
                    selectedService.value = List.generate(
                      value.length,
                      (i) => i == index,
                    );
                  },
                  children: serviceToggle,
                  isSelected: value,
                  selectedColor: Colors.black,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  constraints: BoxConstraints(
                      minHeight: screenHeight * 0.06,
                      minWidth: screenWidth * 0.4),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.02),
              width: screenWidth * 0.8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: ValueListenableBuilder<String?>(
                    valueListenable: selectedValue,
                    builder: (context, value, child) {
                      return DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: value, // Holds the currently selected value
                        hint: const Text('Select Option'), // Placeholder text
                        isExpanded:
                            true, // Ensures dropdown matches container width
                        underline:
                            const SizedBox(), // Removes default underline
                        icon:
                            const Icon(Icons.arrow_drop_down), // Dropdown icon
                        items: const [
                          DropdownMenuItem(
                            value: "Available Capacity",
                            child: Text("Available Capacity"),
                          ),
                          DropdownMenuItem(
                            value: "Capacity at Unloading",
                            child: Text("Capacity at Unloading"),
                          ),
                          DropdownMenuItem(
                            value: "Future Capacity",
                            child: Text("Future Capacity"),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          selectedValue.value = newValue;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.02),
              height: screenHeight * 0.07,
              width: screenWidth * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Total ():',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Dedicated(), ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Dynamic()',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
