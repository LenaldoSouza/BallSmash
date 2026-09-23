extends Weapon

const ROTATION_BOOST = 1


func _on_hit(_body: Node2D) -> void:
	var holder := get_parent()
	if holder and holder.has_method("boost_rotation_speed"):
		holder.boost_rotation_speed(ROTATION_BOOST)
