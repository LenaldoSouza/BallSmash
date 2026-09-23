extends Weapon

const STRETCH_AMOUNT = 5.0


func _on_hit(_body: Node2D) -> void:
	position.x += STRETCH_AMOUNT
