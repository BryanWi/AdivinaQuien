extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tarjeta = preload("res://game/assets/tarjeta.tscn")

var respuesta:String
var presi:String
var n_pista:int = 0

var TARJETAS_TABLERO = 18

#var doc: Dictionary = {
#	"Porfirio Díaz" : {
#		"nombre" : "Porfirio Díaz",
#		"image" : "diaz_porfirio_2.jpg",
#		"pistas" : ["Pista 1", "Pista 2", "Pista 3"]
#		},
#	"AMLO" : {
#		"nombre" : "Andrés Manuel López Obrador",
#		"image" : "AMLO.jpg",
#		"pistas" : ["Pista 1", "Pista 2", "Pista 3"]
#	}
#}

#var doc: Dictionary = read_json_file("res://game/assets/archivo_info.json")

var arch: Array = read_json_file("res://game/assets/archivo_info.json")
var doc : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in arch.size():  
		doc[arch[i].nombre] = arch[i]
		
	print(doc)
	
#	doc = arch[0]
#	print("Aqui despues")
#	print(doc)
#	print(doc.nombre)
#	doc = arch[1]
#	print(doc.nombre)
#	print(doc.image)
#	print(doc.pistas[1])
#	print(arch[0].pistas[0])
#	for i in range(16):
#		if i%2 == 0:
#			doc["PD" + str(i)]={
#			"nombre" : "Porfirio Díaz",
#			"image" : "diaz_porfirio_2.jpg",
#			"pistas" : ["Pista 1", "Pista 2", "Pista 3"]
#			}
#		else:
#
#			doc["AMLO" + str(i)]={
#			"nombre" : "Andrés Manuel López Obrador",
#			"image" : "AMLO.jpg",
#			"pistas" : ["Pista 1", "Pista 2", "Pista 3"]
#			}
#
#
#
	new_game()


func new_game():
	$Label.text = ""
	
	for item in $Tablero.get_children():
		item.queue_free()
	
	randomize()
	var keys = doc.keys()
	print(keys.size())
	var rand_index = fmod(randi() , keys.size())
	
	presi = keys.pop_at(rand_index)
	var opciones = [presi]
	respuesta = doc[presi]["nombre"]
	print(presi)
	
	for i in range(TARJETAS_TABLERO-1):
		var rand_ind = fmod(randi() , keys.size())
		opciones.append(keys.pop_at(rand_ind))
	
	opciones.shuffle()
	
	for i in range(TARJETAS_TABLERO):
		var T = tarjeta.instance()
		var p_nombre = doc[opciones[i]]["nombre"]
		var image_path = doc[opciones[i]]["image"]
		T.set_Data(p_nombre, image_path)
		T.connect("send_respuesta",self,"check_answer")
		$Tablero.add_child(T)
	set_pista()


func check_answer(nombre: String, btn_name: String):
	if (nombre == respuesta):
		print("Correcto")
	else:
		print("incorrecto")
		$Tablero.get_node(btn_name).disabled = true
		set_pista()
#	print("respuesta: "+respuesta)
#	print("nombre: "+nombre)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_pista():
	$Label.text += doc[presi]["pistas"][n_pista] + "\n"
	n_pista += 1
	if n_pista >= doc[presi]["pistas"].size():
		n_pista= 0

func _on_NuevoJuego_button_down():
	new_game()


func read_json_file(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data

