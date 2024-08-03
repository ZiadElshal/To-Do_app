import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/authentication/custom_text_form_field.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: "Ziad");

  TextEditingController emailController = TextEditingController(text: "ziad@route.com");

  TextEditingController passwordController = TextEditingController(text: "123456");

  TextEditingController confirmPasswordController = TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
            Container(
              color: AppColors.whiteColor,
              child: Image.asset("assets/images/main_background.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              ),
            ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppColors.whiteColor
            ),
            title: Text("Create Account",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.whiteColor
            ),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),

          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.28,),

                  CustomTextFormField(label: "User Name", controller: nameController,
                  validator: (text){
                    if (text == null || text.trim().isEmpty){
                      return "Please Enter User Name";
                    }
                    return null;
                    },
                  ),
                  CustomTextFormField(label: "E-mail Address", controller: emailController,
                    validator: (text){
                      if (text == null || text.trim().isEmpty){
                        return "Please Enter E-mail Address";
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid){
                        return "Please Enter Valid E-mail";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormField(label: "Password", controller: passwordController,
                    validator: (text){
                      if (text == null || text.trim().isEmpty){
                        return "Please Enter Password";
                      }
                      if(text.length < 6){
                        return "Password should be at least 6 chars";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    // obscureText: true
                    //     ?Icon(
                    //   obscureText
                    //       ? Icons.visibility_rounded
                    //       : Icons.visibility_off_rounded,
                    //   size: 24,
                    // ):
                    obscureText: true,
                    icon: Icon(Icons.visibility_outlined,
                    color: AppColors.labelTextColor,
                    size: 30,
                    ),
                  ),
                  CustomTextFormField(label: "Confirm Password", controller: confirmPasswordController,
                    validator: (text){
                      if (text == null || text.trim().isEmpty){
                        return "Please Enter Confirm Password";
                      }
                      if(text != passwordController.text){
                        return "Confirm Password doesn't match Password";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    icon: Icon(Icons.visibility_outlined,
                      color: AppColors.labelTextColor,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.06,),

                  ElevatedButton(
                      onPressed: (){
                        register();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Create Account"),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.authPrimaryColor,
                      foregroundColor: AppColors.whiteColor,
                      //fixedSize: Size(350, 65),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width*0.9,
                        MediaQuery.of(context).size.height*0.08,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      // shadowColor: AppColors.whiteColor
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void register() async {
    if(formKey.currentState?.validate() == true){
      ///register
      //todo: show loading
      DialogUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        ///in case success
        DialogUtils.showMessage(context: context, message: "Registration Successfully",
        title: Icon(Icons.check_circle_outline_rounded,color: AppColors.greenColor,
        size: 80,),
          posActionName: "Continue",
            posAction: () {
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
          buttonColor: AppColors.greenColor
        );
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: "The password provided is too weak.",
              posActionName: "Ok",
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: "The account already exists for that email.",
              title: Icon(Icons.error_outline_rounded,
                color: AppColors.labelTextColor,
                size: 80,),
            posActionName: "Ok",
              buttonColor: AppColors.labelTextColor
          );
          print('The account already exists for that email.');
        }else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: "Network Connection Error.",
              title: Icon(Icons.error_outline_rounded,
                color: AppColors.labelTextColor,
                size: 80,),
              posActionName: "Ok",
              buttonColor: AppColors.labelTextColor
          );
          print('Network Connection Error.');
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: Icon(Icons.highlight_remove_rounded,
              color: AppColors.redColor,
              size: 80,),
          posActionName: "Ok",
            buttonColor: AppColors.redColor
        );
        print(e);
      }
    }
  }
}
