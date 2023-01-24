extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var doc: Dictionary = {
	"Luis Echeverría":{
		"images" : "res://imagenes/Luis_Echeverria/",
		1 : {
			"pregunta" : "Cuándo gobernó Luis Echeverría Álvarez",
			"respuesta" : "1970",
			"otras" : ["1976","1958","1988"]
		}
	}
}
var current_question: String = "" #Número de la pregunta
var current_answer: String = ""

onready var ansButton0 = $GridContainer/ans0
onready var ansButton1 = $GridContainer/ans1
onready var ansButton2 = $GridContainer/ans2
onready var ansButton3 = $GridContainer/ans3

#el LOD del blur_material va de 0 a 5
onready var blur_material = $TextureRect/Blur.material
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_question(persona: String, n_pregunta: int):
	
	
	current_question = doc[persona][n_pregunta]["pregunta"]
	current_answer = doc[persona][n_pregunta]["respuesta"]
	
	var opciones:Array = []
	opciones.append(current_answer)
	opciones.append_array(doc[persona][n_pregunta]["otras"])
	opciones.shuffle()
	
	ansButton0.text = opciones[0]
	ansButton1.text = opciones[1]
	ansButton2.text = opciones[2]
	ansButton3.text = opciones[3]
	
	$ColorRect/Pregunta_label.text = current_question
	ansButton0.disabled = false
	ansButton1.disabled = false
	ansButton2.disabled = false
	ansButton3.disabled = false
	

func check_answer(button:Button):
	var answer: String = button.text 
	
	if answer == current_answer:
		print("Correcto")
	else:
		print("Incorrecto")
		button.disabled = true

func _on_ans0_button_down():
	check_answer(ansButton0)


func _on_ans1_button_down():
	check_answer(ansButton1)


func _on_ans2_button_down():
	check_answer(ansButton2)


func _on_ans3_button_down():
	check_answer(ansButton3)


func _on_siguiente_button_down():
	change_question("Luis Echeverría",1)
