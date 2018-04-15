extends Area2D

signal hit
export (int) var SPEED  # how fast the player will move (pixels/sec)
var screensize  # size of the game window

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
    screensize = get_viewport_rect().size
    # Called every time the node is added to the scene.
    # Initialization here


func _process(delta):
    var velocity = Vector2() # the player's movement vector
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    
    if velocity.x != 0:
        $AnimatedSprite.animation = "left"
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x > 0	
    if velocity.length() > 0:
        velocity = velocity.normalized() * SPEED
        if velocity.x != 0:
            $AnimatedSprite.play()
        else:
            $AnimatedSprite.stop()
    else:
        $AnimatedSprite.stop()
    position += velocity * delta
    position.x = clamp(position.x, 0, screensize.x)
    position.y = clamp(position.y, 0, screensize.y)
    # Called every frame. Delta is time since last frame.
    # Update game logic here.



func _on_Player_body_entered(body):
    #hide() # Player disappears after being hit
    emit_signal("hit")
    body.hide()
    #$CollisionShape2D.disabled = true


func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false
