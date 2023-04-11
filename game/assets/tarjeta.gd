extends TextureButton

signal send_respuesta(respuesta,button_name)

var NOMBRE:String


func set_Data(nombre: String, image_path: String):
	NOMBRE = nombre
	name = nombre
	$ColorRect/Label.text = nombre
	$ColorRect.visible = false
	var ImagenPresidente:StreamTexture =  load("res://imagenes/" + image_path)
	self.texture_normal = ImagenPresidente
	self.texture_disabled = ImagenPresidente


func _on_tarjeta_button_down():
	emit_signal("send_respuesta",NOMBRE,name)


func _on_tarjeta_mouse_entered():
	if self.disabled == false:
		$ColorRect.visible = true
	
	$ColorRect/Label.visible = true


func _on_tarjeta_mouse_exited():
	if self.disabled == false:
		$ColorRect.visible = false
	$ColorRect/Label.visible = false

func disable():
	self.disabled = true
	$ColorRect.color = Color(0.196078,0.196078,0.196078,0.788235)
	$ColorRect.visible = true
	
