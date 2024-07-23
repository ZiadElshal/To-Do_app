import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class TaskListItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: provider.appTheme == ThemeMode.light
            ? AppColors.whiteColor
            : AppColors.primaryDarkColor,
        borderRadius: BorderRadius.circular(25),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///vertical line
          Container(
            margin: EdgeInsets.all(25) ,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            height: MediaQuery.of(context).size.height*0.09,
            width: MediaQuery.of(context).size.height*0.005,
          ),
          ///task name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primaryColor
                ),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                    color: provider.appTheme == ThemeMode.light
                        ? AppColors.blackColor
                        : AppColors.whiteColor,),
                    Text("10:30 AM",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: provider.appTheme == ThemeMode.light
                          ? AppColors.blackColor
                          : AppColors.whiteColor,
                    )
                    ),
                  ],
                ),
              ],
            ),
          ),
          ///check button
          Container(
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height*0.005,
                horizontal: MediaQuery.of(context).size.height*0.022
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.check,
            color: AppColors.whiteColor,
            size: 30,),
          )
        ],
      )
    );
  }
}
