extends Area2D


@export var speed : int = 300


func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta


func _on_body_entered(body: Node2D) -> void:
	print(body)
