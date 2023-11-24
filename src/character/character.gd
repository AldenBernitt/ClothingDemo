class_name Character extends Node2D

var toggled: bool = false

func _ready():
	$CharacterAnimatedSprite.play()

func _process(_delta: float):
	if Input.is_action_just_pressed("toggle"):
		toggled = !toggled
		if toggled:
			$CharacterAnimatedSprite.animation = "run"
		else:
			$CharacterAnimatedSprite.animation = "idle"

func set_sprite_frames(part: String, frames: SpriteFrames):
	$CharacterAnimatedSprite.set_sprite_frames(part, frames)
