extends Node2D


@export var speed = 200
signal game_over
@export var enemy_scene : PackedScene


#游戏开始
func _on_hud_start_game() -> void:
	$Player.show()
	$EnemyTimer.start()
	$Player.start()


#游戏结束
func _on_player_game_over() -> void:
	$Player.hide()
	$EnemyTimer.stop()
	$Timer.stop()
	game_over.emit()


#每隔一段时间生成敌人
func _on_enemy_timer_timeout() -> void:
	#实例化
	var enemy = enemy_scene.instantiate()
	#添加到场景中
	add_child(enemy)
