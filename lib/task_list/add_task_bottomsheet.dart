import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddTaskBottomsheet extends StatefulWidget {
  @override
  State<AddTaskBottomsheet> createState() => _AddTaskBottomsheetState();
}

class _AddTaskBottomsheetState extends State<AddTaskBottomsheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.6,
      decoration: BoxDecoration(
        ///bottom sheet appear color
        color: provider.appTheme == ThemeMode.light
            ? AppColors.whiteColor
            : AppColors.primaryDarkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: provider.appTheme == ThemeMode.light
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*0.02),

            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return AppLocalizations.of(context)!.task_title_warning; ///invalid: user not enter text
                        }
                        return null; ///valid
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.task_title,
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: provider.appTheme == ThemeMode.light
                        //         ? AppColors.hintTextColor
                        //         : AppColors.hintTextColor,
                        //   )
                        // )
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.011),

                    TextFormField(
                      validator: (text){
                        if(text == null || text.isEmpty){
                          return AppLocalizations.of(context)!.task_details_warning; ///invalid: user not enter text
                        }
                        return null; ///valid
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.task_details,
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                          // enabledBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(
                          //       color: provider.appTheme == ThemeMode.light
                          //           ? AppColors.hintTextColor
                          //           : AppColors.hintTextColor,
                          //     )
                          // )
                      ),
                      maxLines: 4,
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.03),

                    Text(AppLocalizations.of(context)!.select_date,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: provider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.whiteColor,
                    ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month_outlined,
                          size: 30,
                          color: provider.appTheme == ThemeMode.light
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                        ),
                        InkWell(
                          onTap: (){
                            showCalendar();
                          },
                                      ///format date
                          child: Text(
                            provider.appLanguage == "en"
                                ?DateFormat.yMd().format(selectedDate):
                            DateFormat('yMd', 'ar').format(selectedDate),
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: provider.appTheme == ThemeMode.light
                                ? AppColors.blackColor
                                : AppColors.whiteColor,
                          ),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.03),

                    FloatingActionButton(
                      backgroundColor: AppColors.primaryColor,
                      onPressed: (){
                        addTask();
                      },
                      child: Icon(Icons.check,
                        color: AppColors.whiteColor,
                        size: 35,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: AppColors.whiteColor,
                            width: 3,
                          )
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    if(formKey.currentState?.validate() == true){
      ///add task
    }
  }

  void showCalendar() async{
    var provider = Provider.of<AppConfigProvider>(context, listen: false);
    var chosenDate = await showDatePicker(
        locale: Locale(provider.appLanguage),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    selectedDate = chosenDate ?? selectedDate;
    setState(() {

    });

  }
}
