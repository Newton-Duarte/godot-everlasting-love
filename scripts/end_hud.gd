extends Control

@onready var hearts_text = %HeartsText
@onready var coins_text = %CoinsText
@onready var score_text = %ScoreText
@onready var play_label = %PlayLabel
@onready var timer = $Timer
@onready var love_container = %LoveContainer

func _ready():
	SignalManager.game_over.connect(on_game_over)
	hide()

func _process(delta):
	if play_label.visible and (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")):
		GameManager.load_main_scene()

func on_game_over():
	hearts_text.text = str(ScoreManager.get_hearts())
	coins_text.text = str(ScoreManager.get_coins())
	score_text.text = str(ScoreManager.get_score())
	timer.start()
	show()


func _on_timer_timeout():
	play_label.show()
	love_container.show()
