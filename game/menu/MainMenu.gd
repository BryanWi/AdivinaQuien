extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Jugar_button_up():
	Global.change_scene("juego")


func _on_Estudiar_button_up():
	Global.change_scene("estudio")


