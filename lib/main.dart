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
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
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

  void createOperation(String input){
    if (checkSign(input)) return;
    setState(() => operation.add(input));
    calcText.text = operation.join();
  }

  bool checkSign(String sign){
    if (operation.isEmpty) return false;
    String lastElement = operation[operation.length - 1];
    print(int.tryParse(lastElement));
    if(int.tryParse(lastElement) == null && int.tryParse(sign) == null){
      if (lastElement == "%" && sign != "%"){
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
                maxWidth: 430,
              ),
              child: Column(
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
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          clear();
                        }, 
                        child: Text("C")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation("%");
                        }, 
                        child: Text("%")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(" / ");
                        }, 
                        child: Text(" / ")),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createOperation("7");
                        }, 
                        child: Text("7")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("8");
                        }, 
                        child: Text("8")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation("9");
                        }, 
                        child: Text("9")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(" * ");
                        }, 
                        child: Text("*")),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createOperation("4");
                        }, 
                        child: Text("4")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("5");
                        }, 
                        child: Text("5")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation("6");
                        }, 
                        child: Text("6")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(" - ");
                        }, 
                        child: Text("-")),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          createOperation("1");
                        }, 
                        child: Text("1")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("2");
                        }, 
                        child: Text("2")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation("3");
                        }, 
                        child: Text("3")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(" + ");
                        }, 
                        child: Text("+")),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          plusMinus();
                        }, 
                        child: Text("+/-")),
                      ElevatedButton(
                        onPressed: () {
                          createOperation("0");
                        }, 
                        child: Text("0")),
                        ElevatedButton(
                        onPressed: () {
                          createOperation(".");
                        }, 
                        child: Text(".")),
                        ElevatedButton(
                        onPressed: () {
                          calculateOperation();
                        }, 
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
