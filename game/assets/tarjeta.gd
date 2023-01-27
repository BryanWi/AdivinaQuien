extends TextureButton


signal send_respuesta(respuesta,button_name)
var NOMBRE:String


func _ready():
	pass # Replace with function body.
	#set_Data("Porfirio Díaz", "diaz_porfirio_2.jpg")
	#print(list_files_in_directory("res://imagenes/"))

func set_Data(nombre: String, image_path: String):
	NOMBRE = nombre
	name = nombre
	var image = Image.new()
	image.load("res://imagenes/" + image_path)
	var t = ImageTexture.new()
	t.create_from_image(image)
	self.texture_normal = t


func _on_tarjeta_button_down():
	emit_signal("send_respuesta",NOMBRE,name)

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files
