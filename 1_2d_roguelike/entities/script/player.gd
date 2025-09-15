extends CharacterBody2D


@export var speed : int = 150
var input_direction = Vector2.ZERO
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#监听输入控制玩家移动
	get_input()
	move_and_slide()
	#播放相应动画
	play_animation()

func get_input():
	input_direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = input_direction * speed


func play_animation():
	#播放玩家动画
	if input_direction != Vector2.ZERO:
		animation_player.play("move")
	else:
		animation_player.play("idle")
	#根据按键方向控制玩家朝向
	if Input.is_action_pressed("move_left"):
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("move_right"):
		$Sprite2D.flip_h = false
	
