extends CharacterBody2D

@export var speed: float = 400.0
@export var slow: float = 15.0
@export var spring: float = 150.0
@export var damp: float = 10.0
@export var multiplier: float = 100.0
@export var fall_speed: float = 800.0
@export var fall_horizontal_speed: float = 100.0
@export var fall_duration: float = 3.0

var displacement: float = 0.0 
var y_velocity: float = 0.0
var falling: bool = false
var fall_timer: float = 0.0


func _physics_process(delta: float) -> void:
	if falling:
		handle_falling(delta)
	else:
		# Handle Climb.dw
		if Input.is_action_just_pressed("climb"):
			y_velocity = 50.0
		elif Input.is_action_pressed("slide"):
			position.y += speed * delta
		
		var force = -spring * displacement - damp * y_velocity
		y_velocity += force * delta
		displacement += y_velocity * delta
		
		velocity.y = -displacement * multiplier

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, damp)

	move_and_slide()


func handle_falling(delta):
	fall_timer += delta
	velocity.y = fall_speed
	
	# Move towards x = 0
	if position.x > 0:
		velocity.x = -fall_horizontal_speed
	elif position.x < 0:
		velocity.x = fall_horizontal_speed
	else:
		velocity.x = 0
	
	if fall_timer >= fall_duration:
		falling = false
		fall_timer = 0


func fall():
	if not falling:
		falling = true
	
