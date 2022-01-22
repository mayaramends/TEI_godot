extends KinematicBody2D

export var speed = 32
export var health = 1
var motion = Vector2.ZERO
var move_direction = -1 # ele vem da direita
var gravity = 1200
var hitted = false

func _physics_process(delta: float) ->void:
	motion.x = speed * move_direction
	motion.y += gravity * delta
	
	if move_direction == 1:
		$texture.flip_h = true
	else: 
		$texture.flip_h = false
	
	_set_animation()
	
	motion = move_and_slide(motion)

func _on_anim_animation_finished(anim_name):
	if anim_name == "Idle":
		$texture.flip_h != $texture.flip_h
		$ray_wall.scale.x = -1
		move_direction *= -1
		$anim.play("run")

func _set_animation():
	var anim = "run"
	
	if $ray_wall.is_colliding():
		anim = "Idle"
	elif motion.x != 0:
		anim = "run"
	
	if hitted == true:
		anim = "hit"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func _on_hitbox_body_entered(body):
	hitted = true
	body.velocity.y -= 300
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
