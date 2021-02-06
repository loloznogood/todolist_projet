import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist_projet/widgets/pages/TodoAdd.dart';
import 'package:todolist_projet/models/todo.dart';
import 'package:todolist_projet/data/tododata.dart';
import 'package:todolist_projet/widgets/pages/OneTodoPage.dart';
import 'package:todolist_projet/widgets/pages/TodoMaster.dart';
import 'package:todolist_projet/widgets/pages/TodoDetails.dart';

class AllTodosPage extends StatefulWidget {
  const AllTodosPage({Key key}) : super(key: key);

  @override
  AllTodosPageState createState() => AllTodosPageState();
}

class AllTodosPageState extends State<AllTodosPage> {
  
  int get doneCount => todos.where((todo) => todo.done).length;

  //Change l'état de la checkbox
  //@param todo tâche sélectionnée
  void checkbox(Todo todo){
    setState(() {
      if (todo.done) todo.done = false;
      else todo.done = true;
    });
  }

  //Retourne details de la tâche
  //@param todo tâche sélectionnée
  void tap(Todo todo) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return TodoDetails(todo: todo, delete: delete,routeToUpdate: routeToUpdate,);
      },
      );
  }

  //Supprime une tâche
  //@param todo tâche sélectionnée
  void delete(Todo todo)
  {
    setState(() {
      todos.remove(todo);
    });
  }

  final TextEditingController controllerTitle =  new TextEditingController(); //Controller titre de la tâche
  final TextEditingController controllerContent =  new TextEditingController(); //Controller description de la tâche

  //Récuperer le controller titre de la tâche
  //@param todo tâche sélectionnée
  TextEditingController getControllerTitle(Todo todo) {
    controllerTitle.text = todo.title; //Affiche le titre actuelle dans le controller du titre
    return controllerTitle;
  }

  //Récuperer le controller description de la tâche
  //@param todo tâche sélectionnée
  TextEditingController getControllerContent(Todo todo) {
    controllerContent.text = todo.content; //Affiche la description actuelle dans le controller de la description 
    return controllerContent;
  }

  //Modifie le titre et la description de la tâche
  //@param todo tâche sélectionnée
  void controllerTodo(Todo todo) {
    if (controllerTitle.text.isEmpty) {
      return;
    }
    setState(() {
      todo.title = controllerTitle.text;
      todo.content = controllerContent.text;
    });
  }

  //Effectuer une initialisation de l'objet
  @override
   void initState() {
     super.initState();
   }

  //libérer la mémoire allouée aux controllers lorsque l'objet d'état est supprimé
  @override
  void dispose() {
    controllerTitle.dispose();
    controllerContent.dispose();
    super.dispose();
  }
  
  //Dirige l'utilisateur vers la page de modification de la tâche voulant être modifiée
  //@param todo tâche sélectionnée
  void routeToUpdate(Todo todo) {
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => OneTodoPage(todo: todo,controllerTodo: controllerTodo,getControllerTitle: getControllerTitle, getControllerContent:getControllerContent,),
    ));
  }


  //Pop-up de confirmation de suppression de la tâche
  maybeRemoveChecked() {
    if (doneCount == 0) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Voulez-vous vraiment supprimer ?',
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Annuler'), 
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text('Supprimer'), 
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    ).then((supprimer) {
      if (supprimer) { //Si l'utilisateur appuie sur le bouton de suppression alors la tâche selectionnée est supprimée
        removeCheck();
      }
    });
  }

  //Supprime les tâches cochées
  removeCheck() {
    List<Todo> pending = [];
    for(var todo in todos) {
      if (!todo.done) pending.add(todo);
    }
    setState(() => todos = pending);
  }

  //Affiche la liste, bouton supprimer et ajouter
  //@param context instance qui permet de faire savoir où elle se trouve dans l'arborescence des widgets de votre application
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Todo List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete), //Bouton de suppression
            onPressed: maybeRemoveChecked, //pop-up confirmation de suppression
          ),
        ],
        ),
      body: TodoMaster(listTodos: todos, checkbox: checkbox, tap: tap,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:(_) => TodoAdd(), //Redirection vers la page d'ajout d'une tâche à la liste actuelle
            )
          ).then((title) {
              setState(() {
                todos.add(Todo(title,"Aucune description")); //Ajout de la tâche avec comme message "Aucune description"
              });
          });
        }
      ),
    );
  }
}

  

