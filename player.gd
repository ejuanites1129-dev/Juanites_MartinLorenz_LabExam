extends Area2D
signal hit

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO 
	
	#Input validation
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta 
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.length() > 0:
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "right"
		elif velocity.x < 0:
			$AnimatedSprite2D.animation = "left"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "down"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "up"
		
		$AnimatedSprite2D.play() 
	else:
		$AnimatedSprite2D.animation = "idle" 
		$AnimatedSprite2D.play()

func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)
