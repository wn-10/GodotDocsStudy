extends RigidBody2D


var animated_sprite_names : Array
var speed = 200
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	#获取所有动画名称
	animated_sprite_names = animated_sprite_2d.sprite_frames.get_animation_names()
	#播放随机动画
	animated_sprite_2d.play(animated_sprite_names.pick_random())
	linear_velocity = Vector2(200,300)
	
	#随机点位
	var localtion = $Path2D/PathFollow2D
	localtion.progress_ratio = randf()
	#设置初始位置
	position = localtion.position
	
	#设置旋转角度
	rotation = localtion.rotation + deg_to_rad(randi_range(30,120))
	#设置方向
	var direction = Vector2.RIGHT.rotated(rotation)
	#linear_velocity为线性运动速度,包含「运动方向」和「速度大小」两个关键信息
	linear_velocity = direction * speed
	

#超出屏幕范围时消失
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
