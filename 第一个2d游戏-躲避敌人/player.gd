extends Area2D


@export var init_position : Vector2 #游戏开始时的初始位置
@export var speed :int = 350 #物体移动速度
var screen #记录屏幕范围
signal game_over
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	#当游戏开始的信号发时才显示玩家
	hide()
	#将玩家位置移动到初始位置处
	position = init_position
	#将图片缩小
	scale = Vector2(0.5,0.5)
	#获取屏幕范围
	screen = get_viewport_rect()


func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO #记录物体运动方向
	#监听玩家输入,获得物体运动方向
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_down"):
		direction.y = 1
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	
	#根据物体运动方向,改变图片动画朝向
	if direction.x != 0: #水平方向
		animated_sprite_2d.play("walk")
		#动画水平方向默认朝 向右 即direction.x=1,当x=-1时要水平翻转图片,所以 x < 1
		animated_sprite_2d.flip_h = direction.x < 1
	if direction.y != 0: #水平方向
		animated_sprite_2d.play("up")
		#动画垂直方向默认朝 向 上即direction.y=-1,当y=1时要垂直翻转图片,所以 y > -1
		animated_sprite_2d.flip_v = direction.y > -1
	
	#移动位置
	direction = direction.normalized() #归一化,斜向运动时比水平和垂直运动速度快
	position += direction * speed * delta
	
	#将移动范围限制在屏幕内
	position = position.clamp(screen.position,screen.size)


func _on_body_entered(body: Node2D) -> void:
	#碰到敌人死亡
	hide()
	#发出信号游戏结束
	game_over.emit()
	#禁用碰撞
	$CollisionShape2D.set_deferred("disabled",true)


func start():
	$CollisionShape2D.set_deferred("disabled",false)
	position = init_position
	animated_sprite_2d.play("up")
	
	
