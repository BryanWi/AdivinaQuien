extends Control

onready var tarjeta = preload("res://game/assets/tarjeta.tscn")

var respuesta:String
var presi:String
var pistas: Array
var errores:int = 0

const TARJETAS_TABLERO = 14

onready var pistasLabel = $FondoPistas/Pistas
onready var tablero = $FondoTablero/Tablero

var arch: Array = read_json_file("res://game/assets/archivo_info.json")
var doc : Dictionary

func _ready():
	for i in arch.size():  
		doc[arch[i].nombre] = arch[i]
		
	$WinScreen.visible = false
	
	new_game()


func new_game():
	print("\nNuevo Juego")
	pistasLabel.text = ""
	errores = 0
	pistas = []
	$Error_Label.text = "Errores "+str(errores)+"/3"
	
	#vacíamos el tablero actual
	for item in tablero.get_children():
		item.queue_free()
	
	randomize() #Genera una nueva seed para más aleatoriedad
	var keys = doc.keys() #Tomamos las llaves del diccionario con los presidentes
	var rand_index = fmod(randi() , keys.size()) #índice aleatorio para seleccionar el presidente de la lista de llaves
	
	presi = keys.pop_at(rand_index) # Se selecciona al prsidente
	var opciones = [presi] # Se agrega el presidente elegido a las opciones que habrá en esta partida
	pistas = [] + doc[presi]["pistas"] # Se guardan las pistas del presidente elegido
	pistas.shuffle() # Se aleatoriza el orden de las pistas
	
	respuesta = doc[presi]["nombre"] # Se guarda la respuest actual
	print(respuesta)
	
	# Se llena el Array de opciones con presidentes aleatorios restantes, encargándose de no repetir ninguno
	for _i in range(TARJETAS_TABLERO-1):
		var rand_ind = fmod(randi() , keys.size())
		opciones.append(keys.pop_at(rand_ind))
	
	#Se aleatoriza el orden de las opciones, pues sino la correcta siempre estaría primero
	opciones.shuffle()
	
	# Se agregan las tarjetas al tablero conteniendo cada una de las opciones guardadas 
	for i in range(TARJETAS_TABLERO):
		var T = tarjeta.instance()
		var p_nombre = doc[opciones[i]]["nombre"]
		var image_path = doc[opciones[i]]["image"]
		T.set_Data(p_nombre, image_path)
		T.connect("send_respuesta",self,"check_answer")
		tablero.add_child(T)
	
	# Se coloca la primer pista
	set_pista()


func check_answer(nombre: String, btn_name: String):
	if (nombre == respuesta):
		print("Correcto")
		game_won()
	else:
		print("incorrecto")
		play_sound("error")
		errores += 1
		$Error_Label.text = "Errores "+str(errores)+"/3"
		if errores == 3:
			game_lost()
			return
		tablero.get_node(btn_name).disabled = true
		set_pista()
#	print("respuesta: "+respuesta)
#	print("nombre: "+nombre)

func game_lost():
	new_game()

func game_won():
	$WinScreen.visible = true
	play_sound("Win")

func set_pista():
	pistasLabel.text += pistas.pop_at(0) + "\n"

func _on_NuevoJuego_button_down():
	new_game()

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
