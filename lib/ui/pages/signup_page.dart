import 'package:flutter/material.dart';
import 'package:taichat/ui/pages/login_page.dart';
import 'package:taichat/ui/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  static const String route = 'signup_page';
  const SignUpPage({Key? key}) : super(key: key);
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
                    title: 'Sign Up!',
                  ),
                  _SignUpForm(),
                  Labels(
                    navigationRoute: LoginPage.route,
                    message: 'You have an account?',
                    suggestion: 'Use your account',
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

class _SignUpForm extends StatefulWidget {
  const _SignUpForm();

  @override
  State<_SignUpForm> createState() => __SignUpFormState();
}

class __SignUpFormState extends State<_SignUpForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController repeatePassController = TextEditingController();

  bool showCleanButtonName = false;
  bool showCleanButtonEmail = false;
  bool showCleanButtonPass = false;
  bool showCleanButtonPassRep = false;

  bool _showPass = true;

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {
        showCleanButtonName = nameController.text != '';
      });
    });
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
    repeatePassController.addListener(() {
      setState(() {
        showCleanButtonPassRep = repeatePassController.text != '';
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    repeatePassController.dispose();

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
            inputType: TextInputType.text,
            prefixIcon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameController,
            showClearButton: showCleanButtonName,
          ),
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
          CustomInput(
            obscureText: _showPass,
            inputType: TextInputType.visiblePassword,
            prefixIcon: Icons.lock_outlined,
            placeholder: 'Repeat Password',
            textController: repeatePassController,
            showClearButton: showCleanButtonPassRep,
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
            onPressed: () {},
            text: 'Create account',
          ),
        ],
      ),
    );
  }
}
