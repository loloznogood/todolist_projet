import 'package:flutter/material.dart';
import 'package:todolist_projet/models/todo.dart';

class TodoPreview extends StatelessWidget {
  //@required l'argument est requis 
  const TodoPreview({Key key, @required this.todo, @required this.checkbox, @required this.tap}) : super(key: key);

  final Todo todo; //Tâche selectionnée
  final Function(Todo) checkbox; //Fonction d'état de la checkbox de la tâche
  final Function(Todo) tap; //Fonction qui affiche la description de la tâche en cliquant dessus

  //Affiche les détails de la tâche sélectionnée
  //@param context instance qui permet de faire savoir où elle se trouve dans l'arborescence des widgets de votre application
  @override
  Widget build(BuildContext context)
  {
    return ListTile(
          onTap: () => tap(todo),
          leading: Checkbox(
              value: todo.done,
              onChanged: (checked) {
                checkbox(todo); //Appel fonction changement d'état checkbox
              }),
          title: Text(
            todo.title,
            style: TextStyle(
                decoration: todo.done
                    ? TextDecoration.lineThrough //Si checkbox sélectionné titre barré
                    : TextDecoration.none //Sinon non barré
            ),
          ),
          subtitle: Text(
            todo.content,
            style: TextStyle(
                decoration: todo.done
                    ? TextDecoration.lineThrough //Si checkbox sélectionné description barré
                    : TextDecoration.none //Sinon non barré
            ),
          ),
          );
  }
}