extends ParallaxLayer

@onready var sprite = $Sprite2D

@export var texture: Texture
@export var scroll_scale: float = 0.0
@export var tx_x: float = 1920.0
@export var tx_y: float = 1080.0

func _ready():
	motion_scale.x = scroll_scale
	var scale_f = get_viewport_rect().size.y / tx_y
	sprite.texture = texture
	sprite.scale = Vector2(scale_f, scale_f)
	motion_mirroring.x = tx_x * scale_f
