extends Node2D


@onready var player: CharacterBody2D = $"../Player"
@onready var hair_strand = $"../Hair_strand"

@export var offset: float = -150.0

func _process(delta: float) -> void:
	position.y = player.position.y + offset
	
	hair_strand.set_point_position(1, player.position)
	hair_strand.set_point_position(2, Vector2(to_local(player.position).x, 500))
	
	player.look_at(hair_strand.get_point_position(0))
