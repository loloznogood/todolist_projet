import 'package:flutter/material.dart';

class TodoAdd extends StatefulWidget {
    @override
    TodoAddState createState() => TodoAddState();
  }  
  
  class TodoAddState extends State<TodoAdd> {
    TextEditingController controllerTitle; //Controller titre de la tâche 
    TextEditingController controllerContent; //Controller description de la tâche

   //Effectuer une initialisation des controllers
   @override
   void initState() {
     controllerTitle = TextEditingController();
     controllerContent = TextEditingController(); 
     super.initState();
   }

    //libérer la mémoire allouée aux controllers lorsque l'objet d'état est supprimé.
    @override
    void dispose() {
      controllerTitle.dispose();
      controllerContent.dispose();
      super.dispose();
    }

    //Affiche la page d'ajout d'une tâche
    //@param context instance qui permet de faire savoir où elle se trouve dans l'arborescence des widgets de votre application
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title:Text('Nouvelle tâche...')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Titre de la tâche', textAlign: TextAlign.center,),
            TextField(
              controller: controllerTitle, //Utilisateur rentre le titre
              autocorrect: true,
              decoration: InputDecoration(hintText: 'Saisir votre nouveau titre'),
            ),
            RaisedButton(
              child:Text('Ajouter'),
              onPressed: () {
                if (controllerTitle.text.isEmpty) { //Si l'utilisateur ne rentre pas de titre alors le bouton ajouter n'a aucun effet
                  return; 
                }
                else { //Sinon la tâche sera ajoutée et il sera dirigé vers le menu principal
                  Navigator.of(context).pop(controllerTitle.text);
                }
              }
            ),
            //On decide qu'on ne peut ajouter une description qu'en modifiant la tâche
            Text('Vous pourrez ajouter votre description en modifiant cette tâche dans le menu principal', textAlign: TextAlign.center,)         ],
        )
       )
      );
    }
  }