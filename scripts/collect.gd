extends Area2D

enum COLLECT_TYPE { HEART, COIN }

@export var collect_name: COLLECT_TYPE
@export var speed := 60

@onready var sprite = $Sprite2D
@onready var sound = $Sound

var is_collected := false

func _process(delta):
	position.y += delta * speed


func _on_screen_exited():
	queue_free()


func _on_body_entered(body):
	if !is_collected:
		is_collected = true
		sound.play()
		sprite.hide()
		if collect_name == COLLECT_TYPE.HEART:
			ScoreManager.increment_hearts()
		elif collect_name == COLLECT_TYPE.COIN:
			ScoreManager.increment_coins()


func _on_sound_finished():
	queue_free()
