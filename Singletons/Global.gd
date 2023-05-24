extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var points = 0

## valores de dificultad: 0 (facill), 1(medio), 2(difícil)
var dificultad = 0

var scenes:Dictionary = {
	"main_menu" : "res://game/menu/MainMenu.tscn",
	"juego" : "res://game/Game.tscn",
	"estudio" : "res://game/estudio/Estudio.tscn"
}


func _ready():
	pass # Replace with function body.


func change_scene(scene):
	
	if scenes.has(scene):
		var path = scenes[scene]
		get_tree().change_scene(path)
	else:
		print("[Global.gd] Scene not valid. No se encontró la escena en el diccionari 'scenes'")
