import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:segarchat/const.dart';
import 'package:segarchat/services/alert_services.dart';
import 'package:segarchat/services/auth_service.dart';
import 'package:segarchat/services/navigation_service.dart';
import 'package:segarchat/widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertServices _alertServices;

  String? email, password;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertServices = _getIt.get<AlertServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _BuildUI(),
    );
  }

  Widget _BuildUI() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              _headerText(),
              SizedBox(
                height: 20.0,
              ),
              Image.asset(
                'assets/images/LiveChat.gif',
                height: 280,
              ),
              _loginForm(),
              _loginButton(),
              SizedBox(
                height: 20.0,
              ),
              _createAccountLink(),
            ],
          ),
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
            'Hi, Welcome Back!',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Login to Continue',
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

  Widget _loginForm() {
    return Container(
      // height: MediaQuery.sizeOf(context).height*0.28,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.05),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            customFormField(
              labeltext: "Email",
              // height: MediaQuery.sizeOf(context).height * 0.15,
              validationRegEx: EMAIL_VALIDATION_REGEX,
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            customFormField(
              labeltext: "Password",
              // height: MediaQuery.sizeOf(context).height * 0.12,
              validationRegEx: PASSWORD_VALIDATION_REGEX,
              obscureText: true,
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState!.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await _authService.login(email!, password!);
            print(result);
            if (result) {
              _navigationService.pushReplacementNamed("/home");
              _alertServices.showTost(
                text: "Logged in Successfully",
                icon: Icons.check,
              );
            } else {
              _alertServices.showTost(text: "Login Failed, Please Try again!");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createAccountLink() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('Don\'t have an account? '),
        GestureDetector(
          onTap: () {
            _navigationService.pushNamed("/register");
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    );
  }
}
