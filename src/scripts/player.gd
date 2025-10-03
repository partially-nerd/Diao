extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var properties: Node = $Properties

@export var WALK_SPEED = 200
@export var GRAVITY = 400
var screen_size

func framerate_independent_weight(weight):
	return 1 - exp(-weight)

func _ready():
	screen_size = get_viewport_rect().size

func animate_sprite():
	if properties.get_meta("is_walking"):
		animated_sprite_2d.play("walking")
	else:
		animated_sprite_2d.play("idle")

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("move_left"):
		properties.set_meta("is_walking", true)
		velocity.x -= WALK_SPEED * delta
	elif Input.is_action_pressed("move_right"):
		properties.set_meta("is_walking", true)
		velocity.x += WALK_SPEED * delta
	elif Input.is_action_pressed("duck"):
		properties.set_meta("is_walking", true)
		velocity.y -= 2 * delta * GRAVITY
	else:
		properties.set_meta("is_walking", false)
		velocity.x = 0

	animate_sprite()

	move_and_slide()
