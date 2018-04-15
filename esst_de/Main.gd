extends Node2D

export (PackedScene) var Fish
var time_remaining
var score

func _ready():
    randomize()
	
	


func game_over():
    print("game over")
    $CountdownTimer.stop()
    $FishTimer.stop()
    $HUD.show_game_over()


func inc_score():
    print("++")
    score +=1
    #$CountdownTimer.stop()
    #$FishTimer.stop()
    $HUD.update_score(score)


func new_game():
    time_remaining = 12
    score = 0
    print("ng")
    $Player.start($StartPosition.position)
    $StartTimer.start()
    $HUD.update_time_remaining(time_remaining)
    $HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
    $FishTimer.start()
    $CountdownTimer.start()

func _on_CountdownTimer_timeout():
    time_remaining -= 1
    if time_remaining <= 0:
        game_over()
    $HUD.update_time_remaining(time_remaining)


func _on_FishTimer_timeout():
    # choose a random location on Path2D
    $FishPath/FishSpawnLocation.set_offset(randi())
    # create a Mob instance and add it to the scene
    var fish = Fish.instance()
    add_child(fish)
    # set the mob's direction perpendicular to the path direction
    var direction = $FishPath/FishSpawnLocation.rotation + PI/2
    # set the mob's position to a random location
    fish.position = $FishPath/FishSpawnLocation.position
    # add some randomness to the direction
    direction += rand_range(-PI/4, PI/4)
    fish.rotation = direction
    # choose the velocity
    fish.set_linear_velocity(Vector2(rand_range(fish.MIN_SPEED, fish.MAX_SPEED), 0).rotated(direction))
