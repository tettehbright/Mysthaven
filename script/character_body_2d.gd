extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var coin_counter = 0

@onready var coin_label = %Label

func _process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction == 0:
		animated_sprite.play("idle")
	elif direction > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("walk")
	elif direction < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("walk")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("coin"):
		set_coin(coin_counter + 5)
		print(coin_counter)
	
func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	coin_label.text = "Coint Count: " + str(coin_counter)
