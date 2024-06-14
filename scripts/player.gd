extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_idle_long := false

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_X_SPEED = 180.0
const X_ACCEL = 1000
const FRICTION = 700

@onready var sprite = $Sprite
@onready var idle_long_timer = $IdleLongTimer

func _ready():
	SignalManager.game_over.connect(on_game_over)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x += direction * X_ACCEL * delta
		velocity.x = clamp(velocity.x, -MAX_X_SPEED, MAX_X_SPEED)
		
		if direction > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	if not is_on_floor():
		sprite.play("jump")
	else:
		if velocity.x == 0:
			if is_idle_long:
				sprite.play("idle_long")
			else:
				sprite.play("idle")

			if !is_idle_long and idle_long_timer.is_stopped():
				print("Starting Idle Long Timer: " + sprite.animation)
				idle_long_timer.start()
		else:
			sprite.play("walk")
			idle_long_timer.stop()
			is_idle_long = false

	move_and_slide()

func on_game_over():
	idle_long_timer.stop()
	sprite.play("cheer")
	set_physics_process(false)

func _on_idle_long_timer_timeout():
	print("Animate Idle Long")
	sprite.play("idle_long")
	is_idle_long = true
