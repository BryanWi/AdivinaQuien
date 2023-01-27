extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Texto_enunciado = $Texto_enunciado # Nombre del texto a enunciar

# Lectura de los archivos:

var Archivo : Array = read_json_file("Assets/Textos.json")
var Enunciado : Dictionary
var index_Enunciado : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func correr_juego():
	Enunciado = Archivo[index_Enunciado]
	Texto_enunciado.text = Enunciado.enunciado

func read_json_file(filename):
	var file = File.new()
	file.open(filename, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
