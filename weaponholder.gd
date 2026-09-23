extends Node2D

var current_weapon: Weapon = null
var owner_ball: CharacterBody2D = null

const ORBIT_RADIUS = 45.0
var rotation_speed: float = 3.0

const WEAPON_SCENES: Array[PackedScene] = [
	preload("res://armasOBJ/dagger.tscn"),
	preload("res://armasOBJ/sword.tscn"),
	preload("res://armasOBJ/lance.tscn"),
	preload("res://armasOBJ/sickle.tscn"),
	preload("res://armasOBJ/hammer.tscn"),
	preload("res://armasOBJ/saw.tscn"),
]


func equip_weapon(weapon_scene: PackedScene) -> void:
	if current_weapon:
		current_weapon.queue_free()
		current_weapon = null

	current_weapon = weapon_scene.instantiate()
	add_child(current_weapon)
	current_weapon.owner_ball = owner_ball
	current_weapon.position = Vector2(ORBIT_RADIUS, 0)
	current_weapon.rotation = deg_to_rad(90)


func equip_random_weapon() -> void:
	var random_scene: PackedScene = WEAPON_SCENES[randi() % WEAPON_SCENES.size()]
	equip_weapon(random_scene)


func _process(delta: float) -> void:
	rotation += rotation_speed * delta

const MAX_ROTATION_SPEED = 100.0

func boost_rotation_speed(amount: float) -> void:
	rotation_speed = min(rotation_speed + amount, MAX_ROTATION_SPEED)
