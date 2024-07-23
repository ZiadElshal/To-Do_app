import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/settings/language_bottom_sheet.dart';
import 'package:todo_app/settings/theme_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: provider.appTheme == ThemeMode.light
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                width: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: provider.appTheme == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.language_outlined,
                      size: 30,
                      color: provider.appTheme == ThemeMode.light
                          ? AppColors.primaryColor
                          : AppColors.primaryDarkColor,
                    ),
                    Text(
                        provider.appLanguage == "en"
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: provider.appTheme == ThemeMode.light
                              ? AppColors.primaryColor
                              : AppColors.primaryDarkColor,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          ///theme
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: provider.appTheme == ThemeMode.light
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                width: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: provider.appTheme == ThemeMode.light
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.language_outlined,
                      size: 30,
                      color: provider.appTheme == ThemeMode.light
                          ? AppColors.primaryColor
                          : AppColors.primaryDarkColor,
                    ),
                    Text(provider.appTheme == ThemeMode.light
                            ? AppLocalizations.of(context)!.light
                            : AppLocalizations.of(context)!.dark,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: provider.appTheme == ThemeMode.light
                              ? AppColors.primaryColor
                              : AppColors.primaryDarkColor,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ThemeBottomSheet());
  }
}
