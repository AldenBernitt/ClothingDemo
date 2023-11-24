extends MenuBar

const NONE_INDEX: int = 0
const HERO_INDEX: int = 1
const PLUMBER_INDEX: int = 2

const EMPTY: SpriteFrames = preload("res://sprite_frames/empty.tres")

const HERO_HAIR: SpriteFrames = preload("res://sprite_frames/hair/hair_blonde_short.tres")
const HERO_HAT: SpriteFrames = preload("res://sprite_frames/hero/hero_hat.tres")
const HERO_SHIRT: SpriteFrames = preload("res://sprite_frames/hero/hero_shirt.tres")
const HERO_GLOVES: SpriteFrames = preload("res://sprite_frames/hero/hero_gloves.tres")
const HERO_PANTS: SpriteFrames = preload("res://sprite_frames/hero/hero_pants.tres")
const HERO_BOOTS: SpriteFrames = preload("res://sprite_frames/hero/hero_boots.tres")

const PLUMBER_HAIR: SpriteFrames = preload("res://sprite_frames/plumber/plumber_hair.tres")
const PLUMBER_HAT: SpriteFrames = preload("res://sprite_frames/plumber/plumber_hat.tres")
const PLUMBER_SHIRT: SpriteFrames = preload("res://sprite_frames/plumber/plumber_shirt.tres")
const PLUMBER_GLOVES: SpriteFrames = preload("res://sprite_frames/plumber/plumber_gloves.tres")
const PLUMBER_PANTS: SpriteFrames = preload("res://sprite_frames/plumber/plumber_pants.tres")
const PLUMBER_SHOES: SpriteFrames = preload("res://sprite_frames/plumber/plumber_shoes.tres")

const HERO_LOOKUP: Dictionary = {
	CharacterAnimatedSprite.HAIR: HERO_HAIR,
	CharacterAnimatedSprite.HEAD: HERO_HAT,
	CharacterAnimatedSprite.TORSO: HERO_SHIRT,
	CharacterAnimatedSprite.HANDS: HERO_GLOVES,
	CharacterAnimatedSprite.LEGS: HERO_PANTS,
	CharacterAnimatedSprite.FEET: HERO_BOOTS
}
const PLUMBER_LOOKUP: Dictionary = {
	CharacterAnimatedSprite.HAIR: PLUMBER_HAIR,
	CharacterAnimatedSprite.HEAD: PLUMBER_HAT,
	CharacterAnimatedSprite.TORSO: PLUMBER_SHIRT,
	CharacterAnimatedSprite.HANDS: PLUMBER_GLOVES,
	CharacterAnimatedSprite.LEGS: PLUMBER_PANTS,
	CharacterAnimatedSprite.FEET: PLUMBER_SHOES
}

@export var character: Character

func _ready():
	for child in get_children():
		setup_item(child)
		check_item(child, NONE_INDEX)
		child.index_pressed.connect(func(index: int): check_item(child, index))

func _process(_delta: float):
	if Input.is_action_just_pressed("cycle_hair"):
		cycle($Hair)
	if Input.is_action_just_pressed("cycle_head"):
		cycle($Head)
	if Input.is_action_just_pressed("cycle_torso"):
		cycle($Torso)
	if Input.is_action_just_pressed("cycle_hands"):
		cycle($Hands)
	if Input.is_action_just_pressed("cycle_legs"):
		cycle($Legs)
	if Input.is_action_just_pressed("cycle_feet"):
		cycle($Feet)

func setup_item(menu: PopupMenu):
	menu.add_icon_radio_check_item(null, "None", NONE_INDEX)
	menu.add_icon_radio_check_item(null, "Hero", HERO_INDEX)
	menu.add_icon_radio_check_item(null, "Plumber", PLUMBER_INDEX)

func check_item(menu: PopupMenu, index: int):
	if index >= menu.item_count:
		return
	
	for i in menu.item_count:
		menu.set_item_checked(i, false)
	menu.set_item_checked(index, true)
	
	var part: String = CharacterAnimatedSprite.HAIR if menu == $Hair else \
		CharacterAnimatedSprite.HEAD if menu == $Head else \
		CharacterAnimatedSprite.TORSO if menu == $Torso else  \
		CharacterAnimatedSprite.HANDS if menu == $Hands else \
		CharacterAnimatedSprite.LEGS if menu == $Legs else \
		CharacterAnimatedSprite.FEET if menu == $Feet else ""
	
	var frames: SpriteFrames = null
	match index:
		NONE_INDEX: frames = EMPTY
		HERO_INDEX: frames = HERO_LOOKUP[part]
		PLUMBER_INDEX: frames = PLUMBER_LOOKUP[part]
	if frames == null:
		frames = EMPTY
	
	character.set_sprite_frames(part, frames)

func cycle(menu: PopupMenu):
	var ind: int = -1
	for i in menu.item_count:
		if menu.is_item_checked(i):
			ind = i
	check_item(menu, (ind + 1) % menu.item_count)
