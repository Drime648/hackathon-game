extends KinematicBody2D

const MAX_SPEED = 550
const ACCELERATION = 50
const GRAVITY = 20
const JUMP_HEIGHT = -660
const UP = Vector2(0, -1)

var motion = Vector2()


func _physics_process(delta):
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("walk")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("walk")
	else:
		$Sprite.play("Idle")
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	else: 
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("fall")
		motion.x = lerp(motion.x, 0, 0.05)
	motion = move_and_slide(motion, UP)
	pass
