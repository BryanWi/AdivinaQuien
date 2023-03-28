extends Control

onready var tarjeta = preload("res://game/assets/tarjeta.tscn")

var respuesta:String
var presi:String
var pistas: Array
var errores:int = 0

const TARJETAS_TABLERO = 20

onready var pistasLabel = $FondoPistas/Pistas
onready var tablero = $FondoTablero/ScrollContainer/Tablero

var arch: Array = read_json_file("res://game/assets/archivo_info.json")
var doc : Dictionary

func _ready():
	for i in arch.size():  
		doc[arch[i].nombre] = arch[i]
	print(arch.size())
	$WinScreen.visible = false
	
	new_game()


func new_game():
	print("\nModo Estudio")
	errores = 0
	pistas = []
	
	#vacíamos el tablero actual
	for item in tablero.get_children():
		item.queue_free()
	
	var keys = doc.keys() #Tomamos las llaves del diccionario con los presidentes
	
	# Se agregan las tarjetas al tablero conteniendo cada una de las opciones guardadas 
	for i in range(keys.size()):
		var T = tarjeta.instance()
		var p_nombre = doc[keys[i]]["nombre"]
		var image_path = doc[keys[i]]["image"]
		T.set_Data(p_nombre, image_path)
		T.connect("send_respuesta",self,"check_answer")
		tablero.add_child(T)


func check_answer(nombre: String, _btn_name: String):
	pistasLabel.text = nombre
	pistas = doc[nombre]["pistas"]
	for i in pistas:
		pistasLabel.text +=  "\n\n" + i


func play_sound(sonido: String) ->void:
	match sonido:
		"Win":
			$Sonidos/win_fx.play()
		"error":
			$Sonidos/error_fx.play()


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


func _on_Regresar_button_down():
	Global.change_scene("main_menu")
