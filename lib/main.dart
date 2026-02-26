import 'package:flutter/material.dart';
import 'package:equations/equations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom( // Use styleFrom for easy configuration
            foregroundColor: Colors.white, // Text and icon color
            backgroundColor: const Color.fromARGB(255, 3, 45, 78),  // Button background color
            textStyle: const TextStyle(fontSize: 16), // Text style
            shape: RoundedRectangleBorder( // Button shape
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> operation = [];
  final calcText = TextEditingController();
  double clearButtonWidth = 160;
  double normalButtonWidth = 80;
  double buttonHeight = 50;

  void createOperation(String input){
    if (checkSign(input)) return;
    setState(() => operation.add(input));
    calcText.text = operation.join();
  }

  bool checkSign(String sign){
    if (operation.isEmpty) return false;
    String lastElement = operation[operation.length - 1];
    if(int.tryParse(lastElement) == null && int.tryParse(sign) == null){
      if (lastElement == "%" && sign != "%" && sign != "."){
        return false;
      }

      setState(() => operation[operation.length -1] = sign);
      calcText.text = operation.join();
      return true;
    }
    return false;
  }
  void calculateOperation(){
    for(int i = 0; i < operation.length; i++){
      if(operation[i] == "%"){
        operation[i] = "/100";
      }
    }
    final result = ExpressionParser().evaluate(operation.join());
    calcText.text = result.toString();
  }

  void clear(){
    setState(() {
      operation = [];
    });
    calcText.text = "";
  }

  void plusMinus(){
    if(operation.isEmpty || int.tryParse(operation[operation.length - 1]) == null || operation[operation.length - 1] == "0"){
      return;
    }
    if(operation[operation.length - 1][0] != "-"){
        operation[operation.length - 1] = "-" + operation[operation.length - 1];
      } else {
        operation[operation.length - 1] = operation[operation.length - 1].substring(1);
      }
      calcText.text = operation.join();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 400,
              ),
              child: Column(
                spacing: 5.0,
                children: [
                  TextField(
                    readOnly: true,
                    controller: calcText,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 5.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          clear();
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(clearButtonWidth, buttonHeight)
                        ),
                        child: Text("C")),
                        ElevatedButton(
                          onPressed: () {
                            createOperation("%");
                          }, 
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(normalButtonWidth, buttonHeight)
                          ),
                        child: Text("%")),
                        ElevatedButton(
                          onPressed: () {
                            createOperation(" / ");
                          }, 
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(normalButtonWidth, buttonHeight)
                          ),
                          child: Text(" / ")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 5.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createOperation("7");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("7")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("8");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("8")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation("9");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("9")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(" * ");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("*")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 5.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createOperation("4");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("4")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("5");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("5")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation("6");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("6")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(" - ");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("-")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 5.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createOperation("1");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("1")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("2");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("2")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation("3");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("3")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(" + ");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("+")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 5.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          plusMinus();
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("+/-")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("0");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("0")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(".");
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text(".")),
                        ElevatedButton(
                        onPressed: () {
                          calculateOperation();
                        }, 
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(normalButtonWidth, buttonHeight)
                        ),
                        child: Text("=")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
