///in case if used provider with .get() instead of Stream<> .snapshot()

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/task.dart';

///in case if used provider with .get() instead of Stream<> .snapshot()
class ListProvider extends ChangeNotifier{
  ///data
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore() async{

    /// to get : collection => Documents => Data
    QuerySnapshot<Task> querySnapshot = await FirebaseUtils.getTasksCollection().get();
    /// to convert :
    /// List<QueryDocumentSnapshot<Task> => List<Task>
    tasksList = querySnapshot.docs.map((doc){
      return doc.data();
    }
    ).toList();

    ///filter all Tasks => select Date
    ///compare between day , month , year of all tasks
    ///then update result in taskList
    tasksList = tasksList.where((task){
      if(selectDate.day == task.dateTime.day &&
      selectDate.month == task.dateTime.month &&
      selectDate.year == task.dateTime.year){
        return true;
      }
      return false;
    }).toList();

    ///sorting tasks
    tasksList.sort((Task task1 , Task task2){
     return task1.dateTime.compareTo(task2.dateTime);
    });

   notifyListeners();
  }

  void changeSelectDate(DateTime newSelectDate){
    selectDate = newSelectDate;
    getAllTasksFromFireStore();
  }
}