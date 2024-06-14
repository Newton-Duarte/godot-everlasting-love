extends Node

const SCROLL_SPEED: float = 120.0
const GAME_TIME := 60

var game_scene: PackedScene = preload("res://scenes/game.tscn")
var main_scene: PackedScene = preload("res://scenes/main.tscn")

var game_time = 60

func load_game_scene():
	get_tree().change_scene_to_packed(game_scene)

func load_main_scene():
	get_tree().change_scene_to_packed(main_scene)

func decrement_game_time():
	game_time -= 1
	if game_time <= 0:
		SignalManager.game_over.emit()

	SignalManager.game_time_updated.emit()

func reset_game():
	game_time = GAME_TIME
	ScoreManager.reset_scores()
