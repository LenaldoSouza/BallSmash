extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 1500.0
const FRICTION = 2000.0
const BOUNCE_FORCE = 1
const BALL_RADIUS = 32.0
const MAX_HEALTH = 500

static var used_hues: Array[float] = []
const MIN_HUE_DISTANCE = 0.15

signal died(player: CharacterBody2D)

@export var input_left: String = "p2_left"
@export var input_right: String = "p2_right"
@export var input_up: String = "p2_up"
@export var input_down: String = "p2_down"

var health: int = MAX_HEALTH

@onready var sprite: Sprite2D = $Sprite2D
@onready var hp_label: Label = $Label

@onready var weapon_holder: Node2D = $WeaponHolder

func _ready() -> void:
	randomize()
	_set_random_color()
	_update_hp_label()
	weapon_holder.owner_ball = self
	weapon_holder.equip_random_weapon()

func take_damage(amount: int) -> void:
	health -= amount
	health = max(health, 0)
	_update_hp_label()

	if health <= 0:
		died.emit(self)


func _update_hp_label() -> void:
	hp_label.text = str(health)


func _set_random_color() -> void:
	var hue := _get_unique_hue()
	sprite.modulate = Color.from_hsv(hue, 1.0, 1.0)


func _get_unique_hue() -> float:
	var hue := randf()
	var tentativas := 0

	while _is_hue_too_close(hue) and tentativas < 100:
		hue = randf()
		tentativas += 1

	used_hues.append(hue)
	return hue


func _is_hue_too_close(hue: float) -> bool:
	for used in used_hues:
		if abs(hue - used) < MIN_HUE_DISTANCE:
			return true
	return false


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(input_left, input_right, input_up, input_down)

	if direction:
		velocity = velocity.move_toward(direction * SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()
	_bounce_off_screen_edges()


func _bounce_off_screen_edges() -> void:
	var screen_size := get_viewport_rect().size

	if global_position.x < BALL_RADIUS:
		global_position.x = BALL_RADIUS
		velocity.x = abs(velocity.x) * BOUNCE_FORCE
	elif global_position.x > screen_size.x - BALL_RADIUS:
		global_position.x = screen_size.x - BALL_RADIUS
		velocity.x = -abs(velocity.x) * BOUNCE_FORCE

	if global_position.y < BALL_RADIUS:
		global_position.y = BALL_RADIUS
		velocity.y = abs(velocity.y) * BOUNCE_FORCE
	elif global_position.y > screen_size.y - BALL_RADIUS:
		global_position.y = screen_size.y - BALL_RADIUS
		velocity.y = -abs(velocity.y) * BOUNCE_FORCE
