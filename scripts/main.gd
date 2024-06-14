extends Control

@onready var highscore_value_label = $MC/HighscoreValueLabel


func _ready():
	GameManager.reset_game()
	highscore_value_label.text = str(ScoreManager.get_high_score())


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump"):
		GameManager.load_game_scene()
