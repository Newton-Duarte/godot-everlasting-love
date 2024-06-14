extends ParallaxBackground

func _ready():
	SignalManager.player_died.connect(on_player_died)

func _process(delta):
	scroll_offset.x -= GameManager.SCROLL_SPEED * delta

func on_player_died():
	set_process(false)
