extends CanvasLayer


var current_time = 3
var score = 0
signal start_game


func _ready() -> void:
	$ScoreLabel.hide()


func _on_start_button_pressed() -> void:
	$MessageLabel.text = str(current_time)
	$Timer.start()
	score = 0
	$ScoreLabel.text = str(score)

func _on_timer_timeout() -> void:
	current_time -= 1
	$MessageLabel.text = str(current_time)
	if current_time == 0:
		start_game.emit()
		current_time = 3
		$Timer.stop()
		$ScoreLabel.show()
		$MessageLabel.hide()
		$StartButton.hide()
		$ScoreTimer.start()


func _on_score_timer_timeout() -> void:
	score += 1
	$ScoreLabel.text = str(score)


func _on_main_game_over() -> void:
	$ScoreTimer.stop()
	$MessageLabel.text = "游戏失败,再接再厉"
	$MessageLabel.show()
	$StartButton.show()
