import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form/pages/user_info_page.dart';

import '../model/user.dart';

class RegisterFormPage extends StatefulWidget {
  @override
  _RegisterFormPage createState() => _RegisterFormPage();
}

class _RegisterFormPage extends State<RegisterFormPage> {
  bool _hidePass = true;
  bool _hideConfirm = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  List<String> _countries = ['Russian', 'China', 'USA', 'Korea','Japan', 'Germany'];
  String _selectedCountry = 'USA';
  String country = 'USA';
 

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();
  
  @override
  void dispose(){
    _nameController.dispose();
   _phoneController.dispose();
   _emailController.dispose();
   _storyController.dispose();
   _passController.dispose();
   _confirmPassController.dispose();
   _nameFocus.dispose();
   _phoneFocus.dispose();
   _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_){_fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full name *',
              hintText: 'Enter Name Here', 
              prefixIcon: Icon(Icons.person),
              suffixIcon: GestureDetector(
                onTap: (){
                  _nameController.clear();
                },
                child: Icon(Icons.delete_outline,
                color: Colors.red,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                )
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
              //validator: (val) => val!.isEmpty ? 'Name required': null,

            ),
              SizedBox(height: 19,),
            TextFormField(
              focusNode: _phoneFocus,
              //autofocus: true,
              onFieldSubmitted: (_){_fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone number *',
              hintText: 'Enter your phone here',
              helperText: 'Phone format: (xxx)xxx-xxx',
              prefixIcon: Icon(Icons.call),
              suffixIcon: GestureDetector(
                onTap: ()//onLongPress: ()
                {
                  _phoneController.clear();
                },
                child: Icon(Icons.delete_outline,
                color: Colors.red,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  //FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter(RegExp(r'^[()\d-]{1,15}$'),allow: true),
                ],
                validator: (value)=> _validatePhoneNumber(value!) ? null : 'Phone number must be entered as (###)###-####',
                onSaved: (value) => newUser.phone = value!,
              ),


              SizedBox(height: 19,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email address',
              hintText: 'Enter your Email address',
              icon: Icon(Icons.mail)
              ),
              keyboardType: TextInputType.emailAddress,
              //validator: _validateEmail,
              onSaved: (value) => newUser.email = value!,
              ),
              
              SizedBox(height: 19,),

              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.map),
                  labelText: 'Country?'
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    child: Text(country), 
                    value: country,
                    );
                }).toList(),
                onChanged: (country){
                  print(country);
                  setState(() {
                    _selectedCountry = country.toString();
                    newUser.country = country.toString();
                  });
                },
                value: _selectedCountry,
                ),
              SizedBox(height: 19,),  


            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(labelText: 'Life story',
              hintText: 'Tell us about your self',
              helperText: 'Keep it short, this is just demo',
              border:  OutlineInputBorder()
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) => newUser.story = value!,
              ),


              SizedBox(height: 20,),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(labelText: 'Password *',
              hintText: 'Enter the password',
              suffixIcon: IconButton(
                icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                onPressed: () {setState(() {
                  _hidePass = !_hidePass;
                });},
                ),
                icon: Icon(Icons.security),
                ),
                validator: _validatePassword,

              ),
              SizedBox(height: 19,),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hideConfirm,
              maxLength: 8,
              decoration: InputDecoration(labelText: 'Confirm password *',
              hintText: 'Confirm the password',
              suffixIcon: IconButton(
                icon: Icon(_hideConfirm ? Icons.visibility : Icons.visibility_off),
                onPressed: () {setState(() {
                  _hideConfirm = !_hideConfirm;
                });},
                ),
                icon: Icon(Icons.border_color),
                ),
                validator: _validatePassword,
              ),
              SizedBox(height: 15,),
              RaisedButton(onPressed: _submitForm, color: Colors.green,child: Text('Submit form', style: TextStyle(color: Colors.white),),)

          ],
        ),
      ),
    );
  }

  void _submitForm(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState?.save();
      _showDialog(name: _nameController.text);
      print('form is valide');
    print('Name: ${_nameController.text}');
    print('Phone: ${_phoneController.text}');
    print('Email: ${_emailController.text}');
    print('Country: ${_selectedCountry}');
    print('Story: ${_storyController.text}');
    
    }else {
      _showMessage(message: 'Form is not valid! please review and correct');
      //print('Form is not valid! please review and correct');
    }
  }
  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z]$');
    if(value! .isEmpty){
      return 'Name is reqired.';
    } else if (_nameExp.hasMatch(value)) {
      return 'Please enter alphabewtical characters';
    }
    return null;
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return _phoneExp.hasMatch(input);
  }

  String? _validateEmail(String? value) {
      if(value!.isEmpty) {
        return 'Email cannot be empty';
      }else if (!_emailController.text.contains('@')){return 'Invalid email address';}
      else return null;

  }

  String? _validatePassword(String? value){
    if (_passController.text.length != 8)
    return '8 character required for password';
    else if (_confirmPassController.text != _passController.text)
    return 'Password does not match';
    else return null;
  }

  void _showMessage({required String message}) 
  {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Text(
        message, 
        style: TextStyle(
          color: Colors.black, 
          fontWeight: FontWeight.w600,
      fontSize: 18.0
      ),
      )
    ));
  }

  void _showDialog({required String name}) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
          'Registration successful',
          style: TextStyle(color: Colors.green),),
        content: Text(
          '$name welcome, you are ristered!!!!', 
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0),
        ),
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoPage(userInfo: newUser,),
                )
              );                
              }, 
            child: Text(
              'verified', 
              style: TextStyle(
                color: Colors.green,
                fontSize: 18.0,
              ))
          )
        ],
      );
    });
  }
}