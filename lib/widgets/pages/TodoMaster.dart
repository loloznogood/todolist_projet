import 'package:flutter/material.dart';
import 'package:todolist_projet/widgets/pages/TodoPreview.dart';
import 'package:todolist_projet/models/todo.dart';

class TodoMaster extends StatelessWidget {
  //@required l'argument est requis 
  const TodoMaster({Key key, @required this.listTodos, @required this.checkbox, @required this.tap,}) : super(key: key);

  final List<Todo> listTodos; //Liste des tâches
  final Function(Todo) checkbox; //Fonction d'état de la checkbox de la tâche
  final Function(Todo) tap; //Fonction qui affiche la description de la tâche en cliquant dessus

  //Affiche les détails de la tâche sélectionnée
  //@param context instance qui permet de faire savoir où elle se trouve dans l'arborescence des widgets de votre application
  @override
  Widget build(BuildContext context)
  {
    final children = <Widget>[];
    for(Todo todo in listTodos)
    {
      children.add(TodoPreview(todo: todo, checkbox: checkbox, tap: tap,)); //Ajout de chaque tâche
    }

    return ListView(
      children: children.toList(), //Retourne la liste des tâches
    );
  }
}