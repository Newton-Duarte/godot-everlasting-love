extends Node2D

var heart_scene: PackedScene = preload("res://scenes/heart.tscn")
var coin_scene: PackedScene = preload("res://scenes/coin.tscn")

var collectibles = [heart_scene, coin_scene]

@onready var spawn_l = $SpawnL
@onready var spawn_r = $SpawnR
@onready var collectibles_holder = $CollectiblesHolder
@onready var spawn_collectible_timer = $SpawnCollectibleTimer
@onready var game_timer = $GameTimer

func _ready():
	SignalManager.game_over.connect(on_game_over)
	ScoreManager.reset_scores()
	spawn_collectible()

func _process(delta):
	pass

func spawn_collectible():
	var collectible = get_random_collectible()
	var x_pos = randf_range(spawn_l.position.x, spawn_r.position.x)
	var y_pos = spawn_l.position.y
	collectible.position = Vector2(x_pos, y_pos)
	collectibles_holder.add_child(collectible)

func get_random_collectible():
	var rand = randi_range(0, 100)
	
	if rand <= 75:
		return heart_scene.instantiate()
	else:
		return coin_scene.instantiate()

func on_game_over():
	game_timer.stop()
	spawn_collectible_timer.stop()
	destroy_all_remaining_collectibles()

func destroy_all_remaining_collectibles():
	var remaining_collectibles = collectibles_holder.get_children()
	
	for collectible in remaining_collectibles:
		collectible.queue_free()

func _on_spawn_collectible_timer_timeout():
	spawn_collectible()

func _on_game_timer_timeout():
	GameManager.decrement_game_time()
