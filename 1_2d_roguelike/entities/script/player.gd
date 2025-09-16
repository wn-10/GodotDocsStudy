extends CharacterBody2D


@export var speed : int = 150
var input_direction = Vector2.ZERO
var can_shoot = true #控制子弹是否可以发射
var fire_rate : float = 0.3 #子弹发射的间隔时间
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gun: Node2D = $Gun


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
	#枪口跟随鼠标旋转
	target_mouse()
	#发射子弹
	create_bullet()

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


func target_mouse():
	# 获取鼠标全局位置
	var mouse_global_pos = get_global_mouse_position()
	# 计算枪到鼠标的方向向量（使用全局位置计算）
	var direction = mouse_global_pos - gun.global_position
	# 计算旋转角度
	var angle = direction.angle()
	# 应用旋转到枪节点
	gun.rotation = angle
	#翻转图片
	$Gun/Sprite2D.flip_v = direction.x < 0
	$Sprite2D.flip_h = direction.x < 0


func create_bullet():
	#实例化子弹
	var bullet = preload("res://entities/scene/bullet/bullet.tscn").instantiate()
	#添加子弹
	if Input.is_action_pressed("shoot") and can_shoot:
		get_tree().current_scene.add_child(bullet)
		start_shoot()
	#子弹朝鼠标方向射出
	bullet.rotation = gun.rotation
	#子弹初始位置
	bullet.global_position = $Gun/Sprite2D/BulletPoint.global_position


func start_shoot():
	can_shoot = false
	await get_tree().create_timer(fire_rate).timeout  # 等待冷却时间
	can_shoot = true  # 冷却结束，允许再次发射
