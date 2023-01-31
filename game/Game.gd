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

var doc_test: Dictionary = {
	"Porfirio Díaz" : {
		"nombre" : "Porfirio Díaz",
		"image" : "diaz_porfirio_2.jpg",
		"pistas" : ["Pista 1", "Pista 2", "Pista 3", "Pista 4"]
		},
	"AMLO" : {
		"nombre" : "Andrés Manuel López Obrador",
		"image" : "AMLO.jpg",
		"pistas" : ["Pista 1", "Pista 2", "Pista 3", "Pista 4"]
	}
}
var doc: Dictionary = {
	"Guadalupe Victoria":{
		"nombre" : "Guadalupe Victoria",
		"image" : "Guadalupe Victoria.jpg",
		"pistas" : [
			"Inició su gubernatura en 1824",
			"Terminó de gobernar en 1829",
			"Fue el primer presidente",
			"Fue resultado de las primeras elecciones federales"
		]
	},
	"Vicente Guerrero":{
		"nombre" : "Vicente Guerrero",
		"image" : "Vicente Guerrero.png",
		"pistas" : [
			"Inició su gubernatura en 1829",
			"Fue el segundo presidente",
			"Terminó de gobernar en el año en que empezó",
			"Su gobierno duró 8 meses"
		]
	},
	"Jose María Bocanegra":{
		"nombre" : "Jose María Bocanegra",
		"image" : "José María Bocanegra.png",
		"pistas" : [
			"Fue el segundo presidente en iniciar su gobierno en 1829",
			"Su gobierno duró 7 días",
			"Fue el tercer presidente",
			"Cedió su presidencia tras un ataque de insurgentes que rodearon el Palacio Nacional"
		]
	},
	"Pedro Vélez" :{
		"nombre" : "Pedro Vélez",
		"image" : "Pedro Vélez.png",
		"pistas" : [
			"Gobierno de 3 personas iniciado en diciembre de 1829",
			"Gobernó Junto a Luis Quintanar y Lucas Alamán",
			"Tercer gobierno de 1829",
			"Duró por 8 días"
		]
	},
	"Anastasio Bustamante" :{
		"nombre" : "Anastasio Bustamante",
		"image" : "Anastasio Bustamante.png",
		"pistas" : [
			"Inició gobierno en 1930",
			"Terminó de gobernar en agosto de 1932",
			"Asume el cargo tras una rebelión contra Guerrero",
			"Tuvo 3 gobiernos entre 1830 y 1841"
		]
	},
	"Melchor Múzquiz" :{
		"nombre" : "Melchor Múzquiz",
		"image" : "Melchor Múzquiz.png",
		"pistas" : [
			"Inició en agosto de 1832",
			"Terminó en diciembre de 1832",
			"Fue presidente interino durante el cargo de Anastasio Bustamante, quien salió a combatir y no podía mantener su puesto",
			"Trató de renunciar ante el Congreso, pero le pidieron que siguiera gobernando"
		]
	},
	"Manuel Gómez Pedraza" :{
		"nombre" : "Manuel Gómez Pedraza",
		"image" : "Manuel Gómez Pedraza.png",
		"pistas" : [
			"Inicia en diciembre de 1832",
			"Termina en marzo de 1833",
			"Santa Anna, Lorenzo Zavala y Jose María Lobato no le permitieron ejercer su puesto como presidente electo hasta 1932",
			"Se desterró durante dos años en Francia"
		]
	},
	"Valentín Gómez Farías" :{
		"nombre" : "Valentín Gómez Farías",
		"image" : "Valentín Gómez Farías.png",
		"pistas" : [
			"Inició su cargo en abril de 1833",
			"Era vicepresidente, pero tomó el puesto de presidente debido a varias ausencias",
			"Tuvo 4 mandatos entre 1833 y 1834",
			"Asumió el cargo varias veces debido a ausencias de Santa Anna"
		]
	}, # Aquí hay un salto temporal de presidentes, aunque el orden como tal no importa
	"Benito Juarez" :{
		"nombre" : "Benito Juarez",
		"image" : "Benito Juarez.png",
		"pistas" : [
			"pista 1",
			"pista 2",
			"pista 3"
		]
	},
	"Felix Zuloaga" :{
		"nombre" : "Félix Zuloaga",
		"image" : "Felix zuloaga.png",
		"pistas" : [
			"pista 1",
			"pista 2",
			"pista 3"
		]
	},
	"Jose Maria Iglesias" :{
		"nombre" : "Jose Maria Iglesias",
		"image" : "Jose MAria Iglesias.png",
		"pistas" : [
			"pista 1",
			"pista 2",
			"pista 3"
		]
	},
	"Juan N Mendez" :{
		"nombre" : "Juan N Mendez",
		"image" : "Juan N Mendez.png",
		"pistas" : [
			"pista 1",
			"pista 2",
			"pista 3"
		]
	},
	"Manuel Robles Pezuela" :{
		"nombre" : "Manuel Robles Pezuela",
		"image" : "Manuel Robles Pezuela.png",
		"pistas" : [
			"pista 1",
			"pista 2",
			"pista 3"
		]
	},
	"Maximiliano de Hasburgo" :{
		"nombre" : "Maximiliano de Hasburgo",
		"image" : "Maximiliano de hasburgo.png",
		"pistas" : [
			"pista 1",
			"pista 2",
			"pista 3"
		]
	},
	"Sebastian Lerda de Tejada" :{
		"nombre" : "Sebastian Lerda de Tejada",
		"image" : "Sebastian Lerda de Tejada.png",
		"pistas" : [
			"pista 1",
			"pista 2",
			"pista 3"
		]
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print(doc_test)
	$WinScreen.visible = false
	print(typeof(doc_test))
#	for i in range(7):
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
#var doc2: Dictionary = {
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

