extends TextureButton

signal send_respuesta(respuesta,button_name)

var NOMBRE:String


func set_Data(nombre: String, image_path: String):
	NOMBRE = nombre
	name = nombre
	$ColorRect/Label.text = nombre
	$ColorRect.visible = false
	self.texture_normal = load("res://imagenes/" + image_path)


func _on_tarjeta_button_down():
	emit_signal("send_respuesta",NOMBRE,name)


func _on_tarjeta_mouse_entered():
	$ColorRect.visible = true


func _on_tarjeta_mouse_exited():
	$ColorRect.visible = false
