extends RigidBody2D

export (int) var MIN_SPEED # minimum speed range
export (int) var MAX_SPEED # maximum speed range
var mob_types = ["fall"]
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


#func _on_Visibility_screen_exited():
#    queue_free()


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # replace with function body
