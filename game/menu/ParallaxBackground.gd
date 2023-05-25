extends ParallaxBackground


export var scrollSpeedX:float = 35.0
export var scrollSpeedY:float = 25.0

func _process(delta):
	scroll_offset.x += scrollSpeedX*delta
	scroll_offset.y += scrollSpeedY*delta

