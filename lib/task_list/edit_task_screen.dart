import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/task.dart';
import 'package:todo_app/task_list/add_task_bottomsheet.dart';


class EditTaskScreen extends StatefulWidget {
  static const String routeName = "edit_task_screen";

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}
class _EditTaskScreenState extends State<EditTaskScreen> {
  late Task task;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var task = ModalRoute.of(context)?.settings.arguments as Task;
    DateTime selectedDate = task.dateTime;


    return Scaffold(
      backgroundColor: provider.appTheme == ThemeMode.light
          ? AppColors.backGroundLightColor
          : AppColors.backGroundDarkColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.whiteColor
        ),
        toolbarHeight: MediaQuery.of(context).size.height*0.1,

        title: Text(AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: provider.appTheme == ThemeMode.light
                ? AppColors.whiteColor
                : AppColors.backGroundDarkColor,
          ),
        ),
      ),
      body: Container(
        //height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.06,
            vertical: MediaQuery.of(context).size.height * 0.06,
          ),
          decoration: BoxDecoration(
            color: provider.appTheme == ThemeMode.light
                ? AppColors.whiteColor
                : AppColors.primaryDarkColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(AppLocalizations.of(context)!.edit_task,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: provider.appTheme == ThemeMode.light
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.08),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onChanged: (text){
                        //title = text;
                      },
                      decoration: InputDecoration(
                        hintText: task.title,
                        //AppLocalizations.of(context)!.task_title,
                        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: provider.appTheme == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.whiteColor,
                        ),

                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.011),

                    TextField(
                      onChanged: (text){
                        //description = text;
                      },
                      decoration: InputDecoration(
                        hintText: task.description,
                        //AppLocalizations.of(context)!.task_details,
                        hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: provider.appTheme == ThemeMode.light
                              ? AppColors.blackColor
                              : AppColors.whiteColor,
                        ),
                      ),
                      maxLines: 4,
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height*0.04),

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

                    SizedBox(height: MediaQuery.of(context).size.height*0.11),


                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      ///width  ///height
                      fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.580,
                          MediaQuery.of(context).size.height * 0.07
                      ),
                      backgroundColor: provider.appTheme == ThemeMode.light
                          ? AppColors.primaryColor
                          : AppColors.primaryColor,
                    ),
                    onPressed: () {

                    },
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        AppLocalizations.of(context)!.save_changes,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: provider.appTheme == ThemeMode.light
                                ? AppColors.whiteColor
                                : AppColors.primaryDarkColor,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                )
              ],
            ),
          ),
      ),
    );
  }
  void showCalendar() async{
    var provider = Provider.of<AppConfigProvider>(context, listen: false);
    var chosenDate = await showDatePicker(
        locale: Locale(provider.appLanguage),
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    selectedDate = chosenDate ?? selectedDate;
    setState(() {

    });

  }
}
