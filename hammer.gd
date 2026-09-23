extends Weapon

var damage_cap: float = 5.0
const CAP_INCREASE = 2.0
const KNOCKBACK_MULTIPLIER = 20.0


func _apply_damage(body: Node2D) -> void:
	var holder := get_parent()
	var speed: float = holder.rotation_speed if holder else 1.0
	var calculated_damage: int = max(int(min(speed, damage_cap)), 1)
	body.take_damage(calculated_damage)

	if body.has_method("apply_knockback"):
		var direction: Vector2 = body.global_position - global_position
		body.apply_knockback(direction, calculated_damage * KNOCKBACK_MULTIPLIER)


func _on_hit(_body: Node2D) -> void:
	damage_cap += CAP_INCREASE
