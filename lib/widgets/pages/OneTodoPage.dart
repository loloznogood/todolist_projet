import 'package:flutter/material.dart';
import 'package:todolist_projet/models/todo.dart';

class OneTodoPage extends StatelessWidget {
  //@required l'argument est requis 
  const OneTodoPage({Key key, @required this.todo, @required this.controllerTodo, @required this.getControllerTitle, @required this.getControllerContent}) : super(key: key);

  final Todo todo; //Tâche en cours
  final Function(Todo) controllerTodo; //Fonction du controller qui modifie le titre et la description de la tâche
  final Function(Todo) getControllerTitle; //Fonction de récupereration du controller du titre de la tâche
  final Function(Todo) getControllerContent; //Fonction de récupération du controller de la description de la tâche

  //Affiche la page de modification d'une tâche
  //@param context instance qui permet de faire savoir où elle se trouve dans l'arborescence des widgets de votre application
   @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title:Text('Modifier la tâche...')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Titre de la tâche', textAlign: TextAlign.center,),
            TextField(
              controller: getControllerTitle(todo), //Utilisateur rentre le titre
              autocorrect: true,
              decoration: InputDecoration(hintText: 'Saisir votre nouveau titre'),
            ),
             TextField(
              controller: getControllerContent(todo), //Utilisateur rentre la description
              autocorrect: true,
              decoration: InputDecoration(hintText: 'Saisir votre nouvelle description'),
            ),
            RaisedButton(
              child:Text('Ajouter'),
              onPressed: () {
                controllerTodo(todo); //SetState les modification sont appliquées
                Navigator.of(context).pop(true); //Retour à la page de description de la tâche
                Navigator.of(context).pop(true); //Puis ici on arrive directement au menu principal avec l'ensemble des tâches
              }
            )
          ],
        )
       )
      );
    }
  }