import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/services/networkHelper.dart';
import 'package:flutter_crud/src/showData.dart';

class Insert extends StatefulWidget {
  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
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


  bool validateMobile(String number) {
    Pattern pattern = r'^(?:\+88|01)?(?:\d{11}|\d{13})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(number))
      return false;
    else
      return true;
  }
  String mobileInvalidErrorMsg;


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
      appBar: AppBar(title: Text('Insert Data'), centerTitle: true,),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
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
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.red.shade200)),

                            hintText: "Enter your First Name",
                            labelText: "First Name",
                            //  errorText: mobileError,
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (firstNameValue) {
                            if (firstNameValue.isEmpty) {
                              return 'Please enter your First Name';
                            } else if (firstNameValue.length < 4) {
                              return 'please enter a valid name';
                            }
                            firstName = firstNameValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          // obscureText: _secureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.red.shade200)),

                            hintText: "Enter Your Last Name",
                            labelText: "Last Name",

                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          validator: (lastNameValue) {
                            if (lastNameValue.isEmpty) {
                              return 'Please enter your Last Name';
                            } else if (lastNameValue.length < 5) {
                              return 'please enter a valid Last name';
                            }
                            lastName = lastNameValue;
                            return null;
                          },
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          style: TextStyle(color: Color(0xFF000000)),
                          cursorColor: Color(0xFF9b9b9b),
                          keyboardType: TextInputType.text,
                          // obscureText: _secureText,
                          decoration: InputDecoration(
                            errorText: mobileInvalidErrorMsg,
                            filled: true,
                            fillColor: Colors.white54,
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.red.shade200)),

                            hintText: "Enter Your Mobile Number",
                            labelText: "Mobile",

                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                          onChanged: (lastNameValue){
                            mobile = lastNameValue;

                          },

                         validator: (lastNameValue) {




                            if (lastNameValue.isEmpty) {
                              return 'Please enter your Mobile Number';
                            } else if (lastNameValue.length != 11 ) {
                              return 'please enter a valid Mobile Number';
                            }
                           //lastName = lastNameValue;
                           return null;
                         },
                        ),
                        SizedBox(height: 5),

                        Column(children: [

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

                        ],),




                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          // padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(left: 30, right: 30),
                          decoration: BoxDecoration(
                            //  shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green.shade500,
                          ),

                          child: TextButton(
                            child: Text(
                              _isLoading ? 'Proccessing...' : 'Insert Data',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            onPressed: () async{
                              if (_formKey.currentState.validate()) {
                                //  _login(position: widget.position);
                             //   print(mobile);
                            //    print(password);
                                if (validateMobile(mobile)) {
                                  setState(() {
                                    mobileInvalidErrorMsg = null;
                                    _isLoading = true;
                                  });
                                //  _insertData();

                                 // List<int> imageBytes = imageFile.readAsBytesSync();
                                //  String imageFileName = imageFile.path.split('/').last;
                                  List<int>  imageBytes = await imageFile.readAsBytes();
                                  baseimage = base64.encode(imageBytes);
                                //  print(imageFileName);
                                //  print(baseimage);

                                  _insertData();
                                }
                                //_updateData();
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

  void _insertData() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'firstName': firstName, 'lastName': lastName, 'mobile': mobile, 'image': baseimage};
print(data);
    var res = await Network().insertOneItem(
        data: data);
    // var body = json.decode(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => ViewData()),
      );
    }
  }
}
