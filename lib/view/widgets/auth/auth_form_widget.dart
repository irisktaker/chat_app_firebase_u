import 'dart:io';

import 'package:chat_app_firebase/view/widgets/pickers/user_image_picker_widget.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget(
    this.submitFun,
    this.isLoading, {
    Key? key,
  }) : super(key: key);

  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitFun;

  final bool isLoading;

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  File? _userPickedFile;

  void _pickedImage(File pickedImage) {
    _userPickedFile = pickedImage;
  }

  void _submit() {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userPickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Image is required"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      return;
    }

    if (_isValid) {
      _formKey.currentState!.save();
      widget.submitFun(
        _email.trim(),
        _username.trim(),
        _password.trim(),
        _userPickedFile!,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                !_isLogin ? UserImagePickerWidget(_pickedImage) : Container(),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "Email Address"),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 4) {
                        return "Please enter at least 4 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val!,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 7) {
                      return "Please enter at least 7 characters";
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (val) => _password = val!,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 12),
                widget.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          _isLogin ? "Login" : "Sing Up",
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? "Create New Account"
                        : "I Already have an account",
                  ),
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
