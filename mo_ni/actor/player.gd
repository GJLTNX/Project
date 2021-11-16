extends KinematicBody2D

onready var sprite = $Sprite #拿到某个子节点
#onready var tmp = $HurtArea/CollisionShape2D

export var run_speed = 350 #移动速度
export var jump_speed = -1000 #跳跃速度
export var gravity = 2500

var velocity = Vector2() #玩家当前移动速度，初始默认xy轴速度都为零

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right') #根据按键判断动作
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_up')

	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		sprite.scale.x = 1
	if left:
		velocity.x -= run_speed
		sprite.scale.x = -1

func _physics_process(delta): #在每一帧都会进行调用
	velocity.y += gravity * delta #delta指这一帧距离上一帧的时间，改等式表示速度的增量
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1)) #vector传递法线，判断任务人物是否处在地板上


func _on_HurtArea_area_entered(area):
	playerDie()
	
func playerDie():
	print('玩家死亡')
	get_tree().reload_current_scene()
