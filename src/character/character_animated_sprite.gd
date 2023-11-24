class_name CharacterAnimatedSprite extends Node2D

const BODY: String = "body"
const HAIR: String = "hair"
const HEAD: String = "head"
const TORSO: String = "torso"
const HANDS: String = "hands"
const LEGS: String = "legs"
const FEET: String = "feet"

var animation: StringName:
	set(value):
		if animation != value:
			for child in get_children():
				child.animation = value
				child.play()

func play():
	for child in get_children():
		child.play()

func stop():
	for child in get_children():
		child.stop()

func set_sprite_frames(part: String, frames: SpriteFrames):
	var sprite: AnimatedSprite2D = null
	match part.to_lower():
		BODY: sprite = $Body
		HAIR: sprite = $Hair
		HEAD: sprite = $Head
		TORSO: sprite = $Torso
		HANDS: sprite = $Hands
		LEGS: sprite = $Legs
		FEET: sprite = $Feet
		
	if sprite != null:
		sprite.sprite_frames = frames
		sprite.set_frame_and_progress($Base.get_frame(), $Base.frame_progress)
		sprite.play()
