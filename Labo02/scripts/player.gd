extends CharacterBody2D

enum State { IDLE, RUN, JUMP, FALL, ATTACK }
var state: State = State.IDLE

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animation_finished)
	animated_sprite.play("idle")


func _physics_process(delta: float) -> void:
	# Appliquer la gravité lorsque le personnage est dans les airs.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("move_left", "move_right")

	if state != State.ATTACK:
		velocity.x = direction * SPEED

		# Garder la dernière orientation lorsque le personnage s'arrête.
		if direction != 0:
			animated_sprite.flip_h = direction < 0

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		if Input.is_action_just_pressed("attack"):
			change_state(State.ATTACK)
	else:
		velocity.x = 0

	move_and_slide()

	if state != State.ATTACK:
		update_movement_state()


func update_movement_state() -> void:
	if not is_on_floor():
		if velocity.y < 0:
			change_state(State.JUMP)
		else:
			change_state(State.FALL)
	elif velocity.x != 0:
		change_state(State.RUN)
	else:
		change_state(State.IDLE)


func change_state(new_state: State) -> void:
	if state == new_state:
		return

	state = new_state

	match state:
		State.IDLE:
			animated_sprite.play("idle")

		State.RUN:
			animated_sprite.play("run")

		State.JUMP, State.FALL:
			animated_sprite.play("idle")

		State.ATTACK:
			velocity.x = 0
			animated_sprite.play("attack")


func _on_animation_finished() -> void:
	if state == State.ATTACK:
		update_movement_state()
