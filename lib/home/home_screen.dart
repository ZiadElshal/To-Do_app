import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/settings/settings_tab.dart';
import 'package:todo_app/task_list/add_task_bottomsheet.dart';
import 'package:todo_app/task_list/task_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      backgroundColor: provider.appTheme == ThemeMode.light
          ? AppColors.backGroundLightColor
          : AppColors.backGroundDarkColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.1,

        title: Text(AppLocalizations.of(context)!.app_title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: provider.appTheme == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.backGroundDarkColor,
        ),
        ),
      ),
      body: tabs[selectedIndex],
      //Expanded(child: tabs[selectedIndex]),
      // Column(
      //   children: [
      //     Container(
      //       color: AppColors.primaryColor,
      //       width: double.infinity,
      //       height: MediaQuery.of(context).size.height*0.1,
      //     ),
      //     Expanded(child: tabs[selectedIndex]),
      //   ],
      // ),

      bottomNavigationBar: BottomAppBar(
        elevation: 30,
        shadowColor: AppColors.primaryColor,
        // provider.appTheme == ThemeMode.light
        //     ? AppColors.primaryColor
        //     : AppColors.whiteColor,

        color: provider.appTheme == ThemeMode.light
            ? AppColors.whiteColor
            : AppColors.primaryDarkColor,
        height: MediaQuery.of(context).size.height*0.1,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index){
              selectedIndex = index;
              setState(() {

              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_bulleted_outlined),
                  label: AppLocalizations.of(context)!.task_list,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settings,
              )
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: (){
          addTaskBottomSheet();
        },
        child: Icon(Icons.add_outlined,
          color: provider.appTheme == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.primaryDarkColor,
          size: 30,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: provider.appTheme == ThemeMode.light
                ? AppColors.whiteColor
                : AppColors.primaryDarkColor,
            width: 4,
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  List<Widget> tabs = [TaskListTab(), SettingsTab()];

  void addTaskBottomSheet() {
    showModalBottomSheet(
        //isScrollControlled: true,
        context: context,
        builder: (context) => AddTaskBottomsheet()
    );
  }
}
