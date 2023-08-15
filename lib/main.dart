import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/password.dart';
import 'package:share_plus/share_plus.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {
  final _passwordController = TextEditingController();
  final _keywordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  int _passLength = 8;
  bool _useNumbers = true;
  bool _useLetters = true;
  bool _useSymbols = false;
  bool _useCaps = false;
  int selectedValue = 0;
  String hashType = 'MD5';

  @override
  Widget build(BuildContext inContext) {
    return MaterialApp(title: "Password Generator",
        home : Scaffold(
            //resizeToAvoidBottomInset : false, // устранение "bottom overflowed by pixels flutter"
            appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              title: Text('Password Generator'),
            ),
            body : SingleChildScrollView(
            child: Padding(
              padding : EdgeInsets.only(left: 0.0, top: 10.0),

                child : Column(
                    children : [

                      Divider(),
                      SizedBox(
                        width: 200,
                        child:TextFormField(
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'Password length',
                            border: OutlineInputBorder()
                          ),
                        initialValue: _passLength.toString(),
                        onChanged: (value) {
                          setState(() {
                            if (int.parse(value) != 0)
                            _passLength = int.parse(value);
                          });
                        },
                        )
                      ),

                      Row(children :[
                        SizedBox(width: 70),
                        Checkbox(
                            value : _useNumbers,
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            onChanged : (bool? inValue) {
                              setState(() { _useNumbers = inValue!; });
                            }
                        ),
                        Text('Use numbers'),
                        Checkbox(
                            value : _useLetters,
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            onChanged : (bool? inValue) {
                              setState(() { _useLetters = inValue!; });
                            }
                        ),
                        Text('Use letters')
                        ]
                      ),

                      Row(children :[
                        SizedBox(width: 70),
                        Checkbox(
                            value : _useSymbols,
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            onChanged : (bool? inValue) {
                              setState(() { _useSymbols = inValue!; });
                            }
                        ),
                        Text('Use symbols'),
                        Checkbox(
                            value : _useCaps,
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            onChanged : (bool? inValue) {
                              setState(() { _useCaps = inValue!; });
                            }
                        ),
                        Text('Use caps')
                      ]
                      ),

                      Row(children :[
                        SizedBox(width: 80),
                        ElevatedButton(
                          onPressed: () {
                            _passwordController.text = Password.generate(_passLength, _useNumbers, _useLetters, _useSymbols, _useCaps);
                          },
                          child: const Text('Generate'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: _passwordController.text));
                          },
                          child: const Text('Copy'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            _passwordController.text = '';
                          },
                          child: const Text('Clear'),
                        )
                        ]),

                      //Divider(),
                      SizedBox(height: 30),

                      Row(children :[
                        SizedBox(width: 100),
                        SizedBox(
                            width: 200,
                            child:TextFormField(
                              controller: _passwordController,
                              maxLength: _passLength,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder()
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        Column(children :[
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: IconButton(
                              icon: Icon(Icons.share, size: 40),
                              onPressed: () {
                                // Обработка нажатия на кнопку
                                Share.share(_passwordController.text);
                              },
                            ),
                          ),
                          SizedBox(height: 40)
                        ])
                        ]),

                      Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black,
                      ),

                      SizedBox(height: 20),
                      Row(children :[
                        SizedBox(width: 50),
                        SizedBox(
                            width: 300,
                            child:TextFormField(
                              controller: _keywordController,
                              //maxLength: _passLength,
                              decoration: InputDecoration(
                                  labelText: 'Key word',
                                  border: OutlineInputBorder()
                              )
                            )
                        )
                      ]),
                      Row(
                          children: [
                            SizedBox(width: 20),
                            Expanded(child :
                              RadioListTile(
                                title: Text('MD5'),
                                value: 0,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  hashType = 'MD5';
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded( child :
                              RadioListTile(
                                title: Text('SHA-1'),
                                value: 1,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  hashType = 'SHA-1';
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              )
                            )
                          ]),
                      Row(
                          children: [
                            SizedBox(width: 20),
                            Expanded(child :
                              RadioListTile(
                                title: Text('SHA-256'),
                                value: 2,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  hashType = 'SHA-256';
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded( child :
                              RadioListTile(
                                title: Text('SHA-512'),
                                value: 3,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  hashType = 'SHA-512';
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              )
                            )
                          ]),
                      Row(children :[
                        SizedBox(width: 80),
                        ElevatedButton(
                          onPressed: () {
                            _passwordController2.text = Password.getHash(hashType, _keywordController.text);
                          },
                          child: const Text('Generate'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: _passwordController2.text));
                          },
                          child: const Text('Copy'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            _passwordController2.text = '';
                          },
                          child: const Text('Clear'),
                        )
                      ]),
                      SizedBox(height: 30),
                      Row(children :[
                        SizedBox(width: 100),
                        SizedBox(
                            width: 200,
                            child:TextFormField(
                              controller: _passwordController2,
                              //maxLength: _passLength,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder()
                              ),
                            )
                        ),
                        SizedBox(width: 10),
                        Column(children :[
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: IconButton(
                              icon: Icon(Icons.share, size: 40),
                              onPressed: () {
                                // Обработка нажатия на кнопку
                                Share.share(_passwordController2.text);
                              },
                            ),
                          ),
                          SizedBox(height: 10)
                        ])
                      ])

                    ]
                ), //mainAxisAlignment: MainAxisAlignment.center
                )
        )


        )
    );
  }
}

