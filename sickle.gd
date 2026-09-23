extends Weapon

const POISON_INCREASE = 1


func _on_hit(body: Node2D) -> void:
	if body.has_method("apply_poison"):
		body.apply_poison(POISON_INCREASE)
