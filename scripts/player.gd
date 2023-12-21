extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -600.0

var speed = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _sprite = $sprite


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		_sprite.pause()
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction < 0:
		_sprite.flip_h = true
	elif direction > 0:
		_sprite.flip_h = false
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED/15)
		if is_on_floor():
			_sprite.play("run")
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED/8)		
		if is_on_floor():
			_sprite.play("idle")
	
	move_and_slide()
