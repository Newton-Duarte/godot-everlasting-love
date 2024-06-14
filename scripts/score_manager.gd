extends Node

var score: int = 0
var high_score: int = 0
var hearts: int = 0
var coins: int = 0

func get_score():
	return score

func get_high_score():
	return high_score

func get_hearts():
	return hearts

func get_coins():
	return coins

func set_hearts(value: int):
	hearts = value
	SignalManager.hearts_updated.emit()

func set_coins(value: int):
	coins = value
	SignalManager.coins_updated.emit()

func increment_hearts():
	set_hearts(hearts + 1)
	increment_score()

func increment_coins():
	set_coins(coins + 1)
	increment_score()

func set_score(value: int):
	score = value
	if score > high_score:
		high_score = score
	SignalManager.score_updated.emit()

func increment_score():
	set_score(score + 1)

func reset_scores():
	score = 0
	hearts = 0
	coins = 0
	SignalManager.hearts_updated.emit()
	SignalManager.coins_updated.emit()
