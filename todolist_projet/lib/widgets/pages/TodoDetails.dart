import 'package:flutter/material.dart';
import 'package:todolist_projet/models/todo.dart';

class TodoDetails extends StatelessWidget {
  //@required l'argument est requis 
  const TodoDetails({Key key, @required this.todo,@required this.delete, @required this.routeToUpdate}) : super(key: key);

  final Todo todo; //Tâche en cours
  final Function(Todo) delete; //Fonction de suppression de la tâche
  final Function(Todo) routeToUpdate; //Fonction de route vers la page de la modification

  //Affiche les détails de la tâche sélectionnée
  //@param context instance qui permet de faire savoir où elle se trouve dans l'arborescence des widgets de votre application
  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
                title: Text('Tâche : ' + todo.title),
                content: Text(todo.content,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Modifier'), 
                    onPressed: () {
                     routeToUpdate(todo); //Appel fonction de route vers la page de la modification
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete), 
                    onPressed: () {
                          delete(todo);
                          Navigator.of(context).pop(true);
                          //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tâche supprimée'))); 
                      },
                    ),
                  ],
              );
  
  }  
}

  
  