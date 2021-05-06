import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/services/networkHelper.dart';

import 'showData.dart';

class UpdateUI extends StatefulWidget {
  UpdateUI({@required this.firstName, this.mobile, this.lastName});

  final String firstName, lastName, mobile;

  @override
  _UpdateUIState createState() => _UpdateUIState();
}

class _UpdateUIState extends State<UpdateUI> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var firstName, lastName, mobile;

  File imageFile;

  String baseimage;

//for camera dialogBox
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No Image Selected");
    } else {
      Image.file(
        imageFile,
        width: 200,
        height: 200,
      );
    }
    return Image.file(
      imageFile,
      width: 200,
      height: 200,
    );
  }

  _openGallery(BuildContext context) async {
    final _picker = ImagePicker();
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    final File file = File(pickedFile.path);
    // var picture = await ImagePicker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = file;
    });
    Navigator.of(context).pop();
  }

  //Camera
  _openCamera(BuildContext context) async {
    final _picker = ImagePicker();
    final pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
    final File file = File(pickedFile.path);

    setState(() {
      imageFile = file;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Text(
                'FistName: ' + widget.firstName,
                style: TextStyle(fontSize: 25),
              ),
              Text(
                'LastName: ' + widget.lastName,
                style: TextStyle(fontSize: 25),
              ),
              Text(
                'Mobile: ' + widget.mobile,
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 19, right: 19),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: widget.firstName,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.red.shade200)),

                            hintText: "Enter your FistName",
                            labelText: "FirstName",
                            //  errorText: mobileError,
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (mobileValue) {
                            if (mobileValue.isEmpty) {
                              return 'Please enter Mobile Number';
                            } else if (mobileValue.length < 4) {
                              return 'please enter a valid number';
                            }
                            firstName = mobileValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          initialValue: widget.lastName,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          // obscureText: _secureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.red.shade200)),
                            hintText: "Enter your LastName",
                            labelText: "Last Name",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (passwordValue) {
                            if (passwordValue.isEmpty) {
                              return 'Please enter some text';
                            }
                            lastName = passwordValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          initialValue: widget.mobile,
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          // obscureText: _secureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.red.shade200)),
                            hintText: "Enter Your Mobile Number",
                            labelText: "Mobile",
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onChanged: (lastNameValue) {
                            mobile = lastNameValue;
                          },

                          validator: (lastNameValue) {
                            if (lastNameValue.isEmpty) {
                              return 'Please enter your Mobile Number';
                            } else if (lastNameValue.length != 11) {
                              return 'please enter a valid Mobile Number';
                            }
                            //lastName = lastNameValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 5),
                        Column(
                          children: [
                            // //image
                            Container(
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        _showChoiceDialog(context);
                                      },
                                      child: Text("Select Image"),
                                    ),
                                    _decideImageView(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(left: 30, right: 30),
                          decoration: BoxDecoration(
                            //  shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green.shade500,
                          ),

                          child: TextButton(
                            child: Text(
                              _isLoading ? 'Proccessing...' : 'Update',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                //  _login(position: widget.position);
                                List<int> imageBytes =
                                    await imageFile.readAsBytes();
                                baseimage = base64.encode(imageBytes);
                                _updateData();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateData() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'image': baseimage
    };

    var res = await Network()
        .getItemUpdate(data: data, articleTitle: widget.firstName);
    // var body = json.decode(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => ViewData()),
      );
    }
  }
}
