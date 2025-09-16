extends Area2D




func _process(_delta: float) -> void:
	#先让默认鼠标样式消失
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#用自定义动画来替代原鼠标样式
	global_position = get_global_mouse_position()
	$AnimatedSprite2D.play("idle")
