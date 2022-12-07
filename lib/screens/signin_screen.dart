import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import "../provider/auth.dart";

import '../widgets/background_image.dart';
import '../widgets/button.dart';
import '../screens/home_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "signIn-route";
  const SignInScreen({Key? key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).signInWithEmail(
        email: _authData["email"] as String,
        password: _authData["password"] as String,
      );
    } on HttpException catch (error) {
      var errorMessage = "Authentication failed, details not correct";
      if (error.toString().contains("USER_DOES_NOT_EXIST")) {
        errorMessage = "User does not exist";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This is not a valid email address";
      } else if (error.toString().contains("PASSWORD_DOES_NOT_MATCH")) {
        errorMessage = "Incorrect password";
      }
      _showErrorDialog(errorMessage);
      setState(() {
        _isLoading = false;
      });
      return;
    } catch (error) {
      const errorMessage =
          "Could not authenticate you, Please try again later. ";
      _showErrorDialog(errorMessage);
      setState(() {
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomeScreen.routeName, (Route route) => false);
    //Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: const Text("An Error Occurerd"),
                content: Text(
                  message,
                ),
                actions: [
                  ElevatedButton(
                      child: const Text("Okay"),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      })
                ]));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: BackgroundImage(
          widget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'LOGIN',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Good to see you again',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 170),
                    //const Spacer(),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Your Email',
                        hintStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.primary, width: 2.0),
                          borderRadius: BorderRadius.zero,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.primary, width: 2.0),
                          //borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value.toString();
                      },
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      obscureText: true,
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.primary, width: 2.0),
                          borderRadius: BorderRadius.zero,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: theme.primary, width: 2.0),
                          //borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Cannot be Empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value.toString();
                      },
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 54,
                      width: 194,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                'Sign In',
                                style: GoogleFonts.lato(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      'Forgot your password?',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
