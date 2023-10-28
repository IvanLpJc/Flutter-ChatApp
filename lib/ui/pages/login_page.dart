import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/ui/helpers/dialogs.dart';
import 'package:chat_app/ui/pages/pages.dart';
import 'package:chat_app/ui/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  static const String route = 'login_page';
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.95,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Logo(
                    title: 'Hello again!',
                  ),
                  _LoginForm(),
                  Labels(
                    navigationRoute: SignUpPage.route,
                    message: 'Not an account yet?',
                    suggestion: 'Create account',
                  ),
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(fontWeight: FontWeight.w200),
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

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool showCleanButtonEmail = false;
  bool showCleanButtonPass = false;

  bool _showPass = true;

  @override
  void initState() {
    emailController.addListener(() {
      setState(() {
        showCleanButtonEmail = emailController.text != '';
      });
    });
    passController.addListener(() {
      setState(() {
        showCleanButtonPass = passController.text != '';
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomInput(
            obscureText: false,
            inputType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            placeholder: 'Email',
            textController: emailController,
            showClearButton: showCleanButtonEmail,
          ),
          CustomInput(
            obscureText: _showPass,
            inputType: TextInputType.visiblePassword,
            prefixIcon: Icons.lock_outlined,
            placeholder: 'Password',
            textController: passController,
            showClearButton: showCleanButtonPass,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _showPass ? 'Show password' : 'Hide password',
                  textAlign: TextAlign.end,
                ),
                IconButton(
                    onPressed: () => setState(() {
                          _showPass = !_showPass;
                        }),
                    icon: _showPass
                        ? const Icon(Icons.remove_red_eye_outlined)
                        : const Icon(Icons.visibility_off_outlined))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          BlueButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              final loginOk = await authService.login(
                  emailController.text.trim(), passController.text.trim());

              if (loginOk) {
                Navigator.pushReplacementNamed(context, 'users_page');
              } else {
                //TODO: Change this.
                showAlert(context,
                    title: 'Login unsuccessful!',
                    subtitle: 'Make sure the credentials are correct');
              }
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
