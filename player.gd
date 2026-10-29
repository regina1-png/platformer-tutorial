extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var walk_speed = 130.0
var sprint_speed = 260.0
var current_speed = walk_speed
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := 0.0
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		direction -= 1.0
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		direction += 1.0

	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = sprint_speed
	else:
		current_speed = walk_speed

	if direction != 0:
		velocity.x = direction * current_speed
		animated_sprite.play("run")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		animated_sprite.play("idle")

	move_and_slide()
