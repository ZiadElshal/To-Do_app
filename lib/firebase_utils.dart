import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/task.dart';

class FirebaseUtils{
  ///func to use the collection and call it before update, delete,...
  static CollectionReference<Task> getTasksCollection(){
    return FirebaseFirestore.instance.collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: (snapShot, options) => Task.FromFireStore(snapShot.data()!),
        toFirestore: (task, options) => task.toFireStore()
    );
  }
  ///func to add task
  static Future<void> addTaskToFireStore(Task task){
    var taskCollection = getTasksCollection();   //collection
    DocumentReference<Task> taskDocumentRef = taskCollection.doc();  //create document
    task.id = taskDocumentRef.id;      //auto id
    return taskDocumentRef.set(task);
  }

  ///func to delete task
  static Future<void> deleteTaskFromFireStore(Task task){
    return getTasksCollection().doc(task.id).delete();
  }

  ///func to edit task
  static Future<void> updateTaskInFireStore(Task task) {
    var taskCollection = getTasksCollection();   //collection

    return taskCollection.doc(task.id).update({
      'isDone': true,
      //isDone ?? task.isDone,
    });
  }
}