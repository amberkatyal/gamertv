import 'package:bluestacks/app/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _username;
  String _password;

  @override
  void initState() {
    super.initState();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    Map<String, String> dummyUsers = {
      '9898989898': 'password123',
      '9876543210': 'password123'
    };
    if (dummyUsers[this._username] != this._password) {
      final snackbar = SnackBar(
        content: Text(
          'Incorrect Login.',
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
      return;
    }
    performLogin();
  }

  void performLogin() async {
    final storage = new FlutterSecureStorage();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
    await storage.write(key: 'isLoggedIn', value: this._username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Center(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('lib/resources/images/kratos.jpg'),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .16,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'lib/resources/images/gametv.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter username';
                                      } else if (value.length < 3) {
                                        return 'Please enter minimum 3 characters';
                                      } else if (value.length > 10) {
                                        return 'Please enter maximum 10 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (val) => this._username = val,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .translate('username'),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintMaxLines: 1,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    maxLength: 11,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter username';
                                      } else if (value.length < 3) {
                                        return 'Please enter minimum 3 characters';
                                      } else if (value.length > 11) {
                                        return 'Please enter maximum 11 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (val) => this._password = val,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)
                                          .translate('password'),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintMaxLines: 1,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.orange[900],
                              textColor: Colors.white,
                              elevation: 6,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                AppLocalizations.of(context).translate('login'),
                                style: TextStyle(fontSize: 18),
                              ),
                              onPressed: _submit,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
