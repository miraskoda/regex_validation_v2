import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  String initialPattern = r'^[ -~Ā-ž]*$';
  late RegExp _allowedCharacters;

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _regexTextEditingController =
      TextEditingController();

  String errorText = '';

  @override
  void initState() {
    _allowedCharacters = RegExp(initialPattern);
    _regexTextEditingController.text = initialPattern;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: 'Enter text'),
              onChanged: (text) {
                setState(() {
                  setText(text);
                });
              },
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _regexTextEditingController,
                    decoration: const InputDecoration(
                        labelText: 'Enter regex expression'),
                    onChanged: (regex) {
                      try {
                        setState(() {
                          _allowedCharacters = RegExp(regex);
                          setText(_textEditingController.text);
                        });
                      } catch (_) {}
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _allowedCharacters = RegExp(initialPattern);
                        _regexTextEditingController.text = initialPattern;
                        setText(_textEditingController.text);
                      });
                    },
                    child: const Text('Reset expression')),
              ],
            ),
            const Divider(),
            const SizedBox(height: 50.0),
            if (errorText.isEmpty) ...[
              const Text(
                'Input is valid.',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ] else ...[
              Text(
                'Input contains invalid characters. $errorText',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void setText(String text) {
    if (text.isEmpty) {
      errorText = '';
      return;
    }
    errorText = spreadWrongChars(text);
  }

  String spreadWrongChars(String inputText) {
    var dump = '';
    for (var i = 0; i < inputText.length; i++) {
      var letter = inputText[i];
      if (!_allowedCharacters.hasMatch(letter)) {
        dump += ' $letter ';
      }
    }
    return dump.isEmpty ? '' : 'And this chars is wrong $dump';
  }
}
///Tento kód definuje jednoduchou aplikaci ve Flutteru s formulářem, kde můžete zadat text. Regulární výraz _allowedCharacters povoluje pouze znaky z ASCII rozsahu 32-126 a vietnamské diakritiky. Po stisknutí tlačítka "Validate" se text zkontroluje a zobrazí se odpovídající zpráva.

//Mějte na paměti, že tento kód je zjednodušený a můžete jej upravit dle svých potřeb a přizpůsobit design a chování vaší aplikace.





