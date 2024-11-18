extends CharacterBody2D

const SPEED = 100
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var on_vine = false


#on vine control
func _on_vine_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		on_vine=true
		print("t")
func _on_vine_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		on_vine=false
		print("f")
		
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#climbing vines
	if on_vine :
		
		if Input.is_action_pressed("jump"):
			velocity.y = delta*JUMP_VELOCITY*20
		elif Input.is_action_pressed("down"):
			velocity.y = -delta*JUMP_VELOCITY*20
		else:
			velocity.y=0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip the player
	if direction > 0:
		animated_sprite_2d.flip_h=false
		
	elif direction < 0:
		animated_sprite_2d.flip_h=true
		
	#Play animation
	if direction==0:
		animated_sprite_2d.play("idle")
	elif direction != 0:
		animated_sprite_2d.play("run")
			
	#Movement codes
func _process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	
	move_and_slide()
