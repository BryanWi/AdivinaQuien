extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tarjeta = preload("res://game/assets/tarjeta.tscn")

var respuesta:String
var presi:String
var n_pista:int = 0
var pistas: Array
var errores:int = 0

var TARJETAS_TABLERO = 14


func _ready():
	for i in arch.size():  
		doc[arch[i].nombre] = arch[i]
		
	$WinScreen.visible = false
	
	new_game()


var arch: Array = read_json_file("res://game/assets/archivo_info.json")
var doc : Dictionary


func new_game():
	print("\nNuevo Juego")
	$Label.text = ""
	errores = 0
	n_pista = 0
	pistas = []
	$Error_Label.text = "Errores "+str(errores)+"/3"
	
	for item in $Tablero.get_children():
		item.queue_free()
	
	randomize()
	var keys = doc.keys()
	var rand_index = fmod(randi() , keys.size())
	
	presi = keys.pop_at(rand_index)
	var opciones = [presi]
	pistas = [] + doc[presi]["pistas"]
	pistas.shuffle()
	
	respuesta = doc[presi]["nombre"]
	print(respuesta)
	
	for _i in range(TARJETAS_TABLERO-1):
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
		game_won()
	else:
		print("incorrecto")
		$Sonidos/error_fx.play()
		errores += 1
		$Error_Label.text = "Errores "+str(errores)+"/3"
		if errores == 3:
			game_lost()
			return
		$Tablero.get_node(btn_name).disabled = true
		set_pista()
#	print("respuesta: "+respuesta)
#	print("nombre: "+nombre)

func game_lost():
	new_game()

func game_won():
	$WinScreen.visible = true
	play_sound("Win")

func set_pista():
	$Label.text += pistas.pop_at(0) + "\n"
	n_pista += 1
	if n_pista >= doc[presi]["pistas"].size():
		n_pista = 0
	print("n_pista: ", n_pista, " pistas: ", doc[presi]["pistas"].size())

func _on_NuevoJuego_button_down():
	new_game()

func play_sound(sonido:String) ->void:
	pass
	match sonido:
		"Win":
			$Sonidos/win_fx.play()
		"error":
			pass


func _on_win_fx_finished():
	new_game()
	$WinScreen.visible = false

func read_json_file(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data
