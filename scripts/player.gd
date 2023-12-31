extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -800.0

var speed = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _sprite = $sprite
@onready var _anim = $AnimationPlayer


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		#if velocity.y >= 0:
			#_anim.pause()
		#if velocity.y < 0:
			#_anim.play("fall_transition")
			#_anim.queue("fall")
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#_anim.play("jump")
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		_sprite.flip_h = true
	elif direction > 0:
		_sprite.flip_h = false
	
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, SPEED/5)
		#if is_on_floor():
			#_anim.play("run")
	elif direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED/5)
		if is_on_floor():
			_anim.play("idle")
	
	move_and_slide()


func game_over():
	position = Vector2(0.0, 0.0)
