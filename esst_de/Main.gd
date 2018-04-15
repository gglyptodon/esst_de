extends Node2D

export (PackedScene) var Fish
var score

func _ready():
    randomize()
	
	


func game_over():
    print("game over")
    $ScoreTimer.stop()
    $FishTimer.stop()
    $HUD.show_game_over()


func new_game():
    score = 60
    print("ng")
    $Player.start($StartPosition.position)
    $StartTimer.start()
    $HUD.update_score(score)
    $HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
    $FishTimer.start()
    $ScoreTimer.start()

func _on_ScoreTimer_timeout():
    score -= 1
    if score <= 0:
        game_over()
    $HUD.update_score(score)


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