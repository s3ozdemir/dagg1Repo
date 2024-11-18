extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		print("player")
		body.velocity.y *= -1.2
