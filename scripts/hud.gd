extends Control

@onready var heart_text = %HeartText
@onready var coin_text = %CoinText
@onready var game_time_text = %GameTimeText

func _ready():
	SignalManager.game_time_updated.connect(on_game_time_updated)
	SignalManager.hearts_updated.connect(on_hearts_updated)
	SignalManager.coins_updated.connect(on_coins_updated)
	SignalManager.game_over.connect(on_game_over)

func on_game_time_updated():
	game_time_text.text = str(GameManager.game_time)

func on_hearts_updated():
	heart_text.text = str(ScoreManager.get_hearts())

func on_coins_updated():
	coin_text.text = str(ScoreManager.get_coins())

func on_game_over():
	hide()
