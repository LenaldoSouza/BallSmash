extends Weapon

func _on_hit(_body: Node2D) -> void:
	damage *= 1.5
