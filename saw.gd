extends Weapon

var extra_hits: int = 2
const HIT_DELAY = 0.15
const EXTRA_HITS_INCREASE = 1


func _on_hit(body: Node2D) -> void:
	for i in extra_hits:
		await get_tree().create_timer(HIT_DELAY).timeout
		if is_instance_valid(body) and body.has_method("take_damage"):
			body.take_damage(damage)

	extra_hits += EXTRA_HITS_INCREASE
