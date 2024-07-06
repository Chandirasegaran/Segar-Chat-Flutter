import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:segarchat/const.dart';
import 'package:segarchat/services/auth_service.dart';
import 'package:segarchat/services/media_services.dart';
import 'package:segarchat/services/navigation_service.dart';
import 'package:segarchat/services/storage_service.dart';
import 'package:segarchat/widgets/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;
  late NavigationService _navigationService;
  late MediaServices _mediaServices;
  late StorageService _storageService;

  String? email, password, name;
  File? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _mediaServices = _getIt.get<MediaServices>();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
    _storageService = _getIt.get<StorageService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            _headerText(),
            if (!isLoading) _registerForm(),
            if (!isLoading) _loginAccountLink(),
            if (isLoading)
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s Get Started!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Register an Account',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _registerForm() {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.65,
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.05),
        child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _profilePicSelector(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              customFormField(
                  height: MediaQuery.sizeOf(context).height * 0.12,
                  labeltext: "Name",
                  validationRegEx: NAME_VALIDATION_REGEX,
                  onSaved: (value) {
                    name = value;
                  }),
              customFormField(
                  height: MediaQuery.sizeOf(context).height * 0.12,
                  labeltext: "Email",
                  validationRegEx: EMAIL_VALIDATION_REGEX,
                  onSaved: (value) {
                    email = value;
                  }),
              customFormField(
                  height: MediaQuery.sizeOf(context).height * 0.12,
                  labeltext: "Password",
                  obscureText: true,
                  validationRegEx: PASSWORD_VALIDATION_REGEX,
                  onSaved: (value) {
                    password = value;
                  }),
              _registerButton(),
            ],
          ),
        ));
  }

  Widget _profilePicSelector() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaServices.getImageFromGallery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.15,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : NetworkImage(PLACEHOLDER_PFP) as ImageProvider,
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            if ((_registerFormKey.currentState?.validate() ?? false) &&
                selectedImage != null) {
              _registerFormKey.currentState?.save();
              bool result = await _authService.signUp(email!, password!);
              if (result) {}
              String? profilePicUrl =
                  await _storageService.uploadUserProfilePic(
                      file: selectedImage!, userId: _authService.user!.uid);
              print(result);
            }
          } catch (e) {
            print(e);
          }
          setState(() {
            isLoading = false;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _loginAccountLink() {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('Already have an account? '),
          GestureDetector(
            onTap: () {
              _navigationService.goBack();
            },
            child: const Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          )
        ],
      ),
    );
  }
}
