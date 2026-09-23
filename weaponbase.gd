class_name Weapon
extends Area2D

@export var damage: int = 1
var owner_ball: CharacterBody2D = null


func _on_body_entered(body: Node2D) -> void:
	if body == owner_ball:
		return
	if not body.has_method("take_damage"):
		return

	_apply_damage(body)
	_on_hit(body)


func _apply_damage(body: Node2D) -> void:
	body.take_damage(damage)


func _on_hit(_body: Node2D) -> void:
	pass  # cada arma sobrescreve isso com sua evolução própria
