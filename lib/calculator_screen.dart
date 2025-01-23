import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "0"; // Holds the text displayed on the screen
  String currentOperation = ""; // Holds the selected operation
  double firstOperand = 0; // Holds the first number
  double secondOperand = 0; // Holds the second number

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        // Clear all values
        displayText = "0";
        currentOperation = "";
        firstOperand = 0;
        secondOperand = 0;
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        // Set the operation
        firstOperand = double.parse(displayText);
        currentOperation = value;
        displayText = "0";
      } else if (value == "=") {
        // Perform calculation
        secondOperand = double.parse(displayText);
        switch (currentOperation) {
          case "+":
            displayText = (firstOperand + secondOperand).toString();
            break;
          case "-":
            displayText = (firstOperand - secondOperand).toString();
            break;
          case "*":
            displayText = (firstOperand * secondOperand).toString();
            break;
          case "/":
            displayText = (firstOperand / secondOperand).toString();
            break;
        }
        currentOperation = ""; // Reset operation
      } else {
        // Append digit to the display text
        if (displayText == "0") {
          displayText = value;
        } else {
          displayText += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                // Define button labels
                List<String> buttons = [
                  "7", "8", "9", "/",
                  "4", "5", "6", "*",
                  "1", "2", "3", "-",
                  "C", "0", "=", "+"
                ];
                return GestureDetector(
                  onTap: () => buttonPressed(buttons[index]),
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        buttons[index],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
