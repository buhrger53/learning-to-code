@tool
extends EditorScript


# maybe try some stuff with flattened 1d arrays?
# yeah the turtle is kind of fictional
## random grid that we should try to pathfind through.
## should i make the "1"s actually usuable?
## right now, they could just be any number (that isn't 0, 2, or 3)
var grid_of_area: Array[Array] = [
	[1, 1, 2, 1, 1, 1],
	[0, 0, 0, 0, 0, 1],
	[3, 1, 1, 1, 0, 1],
	[1, 0, 0, 1, 1, 1],
]
# i updated the map
# so anything referring to the map before will now be somewhat outdated
# i guess the concepts will be the same
# yeah idk why i named it "grid of area"


# lemme rethink this rq
# yap yap yap, we get stuck in the corner
# 3, 0 and 4, 0 are in the traceback_path array
# we are stuck in the corner, on a new space that isn't in any array yet
# since we returned an empty array (cuz stuck in the corner)

# we will switch to mode 1 (we were previously mode -1)
# we retry the move finder function
# since we are on mode 1 this time, we can go onto the traceback_path array spot (which is the only available spot) (it is 4, 0)
# we add the last spot we were on (5, 0) to the traceback_path2 array, and for fun (well, not really) (this could cause bugs),
# we remove that (last) spot from the traceback_path array, if it is in there (really could be buggy)
# we recheck the area for spots
# since we are on mode 1, we can go onto the traceback_path spot, which is 3, 0 (uh, maybe not using parentheses arounds coords could get confusing)
# we add that last spot (this is probably going to be done before "moving", but *maybe* still after finding the move) to the traceback_path2 array
# after reaching the 3, 0 spot, we can check around for spots again
# this is the hard part:
# obviously we can't go right (i could've said this before) because we are on mode 1 and that other spot is in the traceback_path2 array
# but upon checking left, we can see there is a spot, and checking that spot in the for loop that i definitely used and talked about,
# we can see that new spot is not in the traceback_path array, meaning that we should switch modes at the end of finding the spot
# uhh, not sure how that will be handled
# i'll fight that bridge when i can actually do thing in my code



# lemme think how this code should work
# we'll go right first (even though my code says left first), just because that's the wrong direction (dead end)
# (i just realized, i don't even have the code for moving yet. it just checks left first, but it doesn't actually move us)
# (dang, it really does check all available directions we can move onto)
# (i guess that makes sense though)
# moves to 4, 0
# 3, 0 is confirmed part of "traceback_path"
# code looks around
# up goes below 0
# left goes onto one of the traceback_path array values
# down goes into an obstacle (wait, right is calculated before up and down. uhhh)
# however, right allows us to go in an available space, 5, 0 (yeah i'm not putting parentheses around coords)
# 4, 0 should be added to the traceback_path array
# this time, we are boxed in
# left goes back onto the traceback_path
# right goes out of bounds
# up goes out of bounds
# and down goes onto an obstacle
# causing the move finder function to return an empty array
# i assume at this point, 5, 0 should be added to the traceback_path array
# which then causes the "path generator" (it might have a different name later, and there could be another function that calls it, while doing some other stuff)
# to switch the trace_travel_mode's mode (i forgot what it's called tbh) to the other mode, 1
# and then uhh the move checker function is called again
# but with a different mode this time
# so we look again, boxed around on most sides
# but this time, even though moving left overlaps a traceback_path coordinate
# since we are on mode 1, it's alright to go onto it
# we go back onto 4, 0, popping 5, 0 (which was part of the traceback_path array) and appending it onto the traceback_path2 array
# since we are on mode 1 this time, we can't go back onto traceback_path2 coords
# i guess the function should be called again btw (i don't think i said when it's called before, maybe?)
# we look around: up and down are still bad, right has a coord in traceback_path2, which is bad, since we're on mode 1
# left is checked first, but i just wanted to say the other options
# anyways, left to 3, 0 is all good, because i explained it already (while 3, 0 should be in the traceback_path array, we are on mode 1, so it's alright)
# now we move to 3, 0, whilst popping 4, 0 from the traceback_path array and appending it to the traceback_path2 array
# we look around again, (just realized, final path array could be optimized by removing sequences that put us back onto a space already gone to. probably just check the .count() or something or whenever the values have double, and then do some stuff) (not really sure the keywords and stuff to do that)
# obviously, the code says we check left first (and not right) (and it is an open space), but i don't care
# up and down are blocked
# right goes back to the traceback_path2
# so we have to go left, onto 2, 0 

# edit: lemme use some extra numbers to denote are thing
# 4 will be ones in the traceback_path array
# 5 will be ones in the traceback_path2 array
# i think
#[1, 1, 1, 2, 1, 1],
#[1, 0, 0, 0, 0, 0],
#[1, 0, 1, 1, 1, 3],
#[1, 1, 1, 0, 0, 1],
# ok im done with that

# it seems i will have to include whether the next space is part of an available one (for switching modes) (yeah nvm)
# so i guess we get another array added
# lemme go do that

# wait, i mean, i don't actually have to do that
# i could just check if the next space is in the traceback_path array (obviously, if it were in the traceback_path2 array, we wouldn't go on it, so that doesn't matter, since we are on mode 1 currently)
# so yes, when going onto a new (what was he going to say?)
# hmm, i can code something different...

# instead of just following the traceback_path blindly and checking for spots each step
# we can just allow the move finder to accept spots in the traceback_path array,
# but don't switch the mode if the selected coord is part of the traceback_path array
# (make sure to pop and put the coords of walked backwards of the traceback_path array into the traceback_path2 array) (i'm not actually sure what storing the traceback_path2 array's coords does, but it probably will be useful later?)
# however, if the selected move goes onto a space whose coords aren't in the traceback_path array, then we should switch modes
# not really sure what will happen to the traceback_path2 array (i could figure that out later)
# but then after finding a new space and going onto it while in mode 1,
# we switch modes, and append the last space onto the traceback_path array

# uhh, i hope the logic will work, cuz technically, on a different (larger) map, where we could just take multiple routes and get stuck in a dead end,
# our traceback_path array might not be fully emptied before finding a new space to switch back to mode -1
# so that might be a little scary
# maybe if that one also goes down a dead end, i think the code would still work?
# i think that code should work
# it sounds like it does

# so basically, when switching back to mode -1, we don't have to clear the traceback_path array
# seems good
# not sure, still, what happens to the traceback_path2 array when switching back to mode -1
# ok it seems like the logic worked out

# by the way, when checking whether the available space is part of the traceback_path array (for switching modes and retracing steps)
# we could just loop through the coords stored in the traceback_path array (might be unoptimized...)
# and see if the target position onto which we want to move matches
# wait a minute... will adding the last space before switching actually make sense?

# real thinking:
#start: 3, 0
#move right:
#3, 0 = 4
#4, 0 = 2
#move right:
#4, 0 = 4
#5, 0 = 2
#stuck
#move left:

# it seems upon switching modes, we might last end up on a new space (right? yeah, we can't go onto a traceback_path array coord, so we will have to end up on a new space (unless there's some scary bugs with traceback_path2...)
# ok, it's pretty likely we will up on a new space
# so when switching modes (-1 to 1), we will check if the current space is in the traceback_path array
# yeah, right. it's not going to be in there
# it might be in the traceback_path2 array, though...
# anyways, when switching modes (empty array received), we will append the current position to the traceback_path2 array
# ok




# thinking...
# well, it seems we'll have to do a lot of testing
# i guess we should choose a direction we want to go (prioritize right over left for the first one, because why not?) (yeah i didn't do that)
# we should keep track of the coordinates we've moved to, so we wouldn't infinitely go back and forth on the same squares
# when we are fully boxed in a corner, then retrace the path, whilst checking for new spots along the way
# and adding those new spots to the checked place (i assume he meant checking those new spots and adding them to the first traceback_path array?)
# keep moving until our tested position is the same as the end position
# this might be unoptimized when the map gets bigger...
# i guess it could start with trying to go closer, as along the spot isn't already traversed (i haven't implemented this yet)
# maybe?
# i can feel some potential bugs brewing...
# but i guess that's why this could be ran multiple times
# but that wouldn't be very optimal
# for now, my current logic should work
# and i'm not currently making a 3d game, so it might be alright
# though i could make a top down 2d game with a y/z (third) axis... (but it just had graphics that "look like" 2d)

# IMPORTANT:
# add some other failsafe thing that won't make us get stuck if we really got stuck in a corner
# like all around us, there were only obstacles or out of bounds (idk why i would design the map like that though)
# so instead of crashing godot with infinite loops, we just uhh terminate or something
# not sure how this would actually happen in legitimate "gameplay"

# when we compute the final path array with vector2 coords telling where to go, we should loop through the array, checking for later coords that match previous ones
# if we find one like that, then we should just delete all the coords from here to there (inclusive)

# hmmm, i wonder if i could add some thing that checks for obstacles...
# oh, wait, i can!
# i should add another parameter to the generate path array thing
# with some override variable
# oh, shoot, this is complicated
# steps:
# add some override to the things that first makes the path try to go closer to the end/target first
# then, try to generate a path that goes away from the target first (might be a little harder to implement)
# actually add the override parameters to the functions
# compare the lengths of the functions
# wait, maybe i don't have to do this, since my code already deletes extra steps if it finds double coords...
# hmmm...



# maybe i want the grid to be larger, so i'm going to add miximum values

# i should add more "print()" for debugging
# i'm going to do that

# i should probably use constant variables sometimes
# since they are constant



## checking the nearby spaces the turtle is allowed to move to, through vector2.direction.
## returns an array with the vector2 directions (not coordinates on a grid this time) that can be added onto a position.
## i probably should've made this async
func check_available_spaces_to_move_to(current_position: Vector2, obstacles: Array[Vector2], traceback_path: Array[Vector2], traceback_path2: Array[Vector2], trace_travel_mode: int, map_end_x_0_index: int, map_end_y_0_index: int, end: Vector2) -> Array[Vector2]:
	## note: this will (be used to) return some stuff at the end.
	## don't use yet
	## edit: "deprecated"
	#var available_directions: Dictionary[String, bool] = {
		#"left": false,
		#"right": false,
		#"up": false,
		#"down": false
	#}
	
	print()
	print("checking available spaces...")
	
	# if current_position + Vector2.LEFT < Vector2(0, current_position.y) or current_position + Vector2.LEFT > Vector2(map_end_x_0_index, current_position.y):
		# pass # placeholder code
	# if current_position + Vector2.RIGHT < Vector2(0, current_position.y) or current_position + Vector2.RIGHT > Vector2(map_end_x_0_index, current_position.y):
		# pass
	# if current_position + Vector2.UP < Vector2(current_position.x, 0) or current_position + Vector2.UP > Vector2(current_position.x, map_end_y_0_index):
		# pass
	# if current_position + Vector2.DOWN < Vector2(current_position.x, 0) or current_position + Vector2.DOWN > Vector2(current_position.x, map_end_y_0_index):
		# pass
	# bro, i was braindead
	# keeping that above for reference
	# i should not hide the coords inside vector2.whatever
	# so i guess i will use real coords now
	# yeah nvm it takes too long
	# i guess i should remember that going right (increasing x positive) doesn't really allow you go from 0 to -1
	# guess we know the process now
	# step 1: don't be braindead about how things work
	# step 2: since we want to loop or use a match statement, check what is the variable thing in the situation, and see what is static
	# step 3: code the stuff
	# step 4: debug
	# step 5: remember that one thing i forgot
	# step 6: debug
	# step 7: win
	# edit: that stuff is actually kind of bloated
	# and makes scrolling painful
	# too many comments
	
	
	
	# since we are looping, we are going to use the thing that changes as the thing that's being checked
	# which is the directions
	
	## this looks like an enum imo.
	## can't believe bro made a whole dictionary (object) for this
	## deprecated (well, i guess i commented it out) (maybe i should just say "cut" or "removed")
	#var check_1_available_directions: Dictionary[String, bool] = {
		#left = false,
		#right = false,
		#up = false,
		#down = false,
	#}
	
	## the current directions that have passed the steps.
	## i might be going crazy, but i think this could just replace that object above (by just returning this array)
	var direction_passed_steps: Array[Vector2] = []
	
	print()
	print("current directions that passed (it's probably just going to be 0): ", direction_passed_steps.size())
	
	print()
	print("starting step 1...")
	
	# step 1, does a tested direction go out of bounds? () (i think i might've said that already) () (why does " ' " bug out other things (like parenthesis) even inside of comments?)
	# i have to come clean
	# my code (above) sucked
	# and i had to use ai (that probably grabbed from someone else) to use this loop thing
	# (it's kind of obvious that a match statement would be used, but maybe how to use it is a little harder)
	for direction in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
		## the position calculated by the current direction
		var target_position = current_position + direction
		print()
		print("current direction in step 1: ", direction)
		print("current target position coords: ", target_position)
		
		# depending on which direction is currently being looped through, we use the match statement to check the conditions for that direction
		# idk why i thought i could go past the positive x map limit by going left
		# or vice versa for the other directions (might be using vice versa wrong, but my point should get across)
		# "when" keyword kind of acts like "if", but instead it's for this match statement stuff
		match direction:
			# if we go left and our target position doesn't go below zero, we can allow it
			# not sure why i decided to do left first
			# totally forgot about the equals sign
			# almost sold again (you might think i'm referring to that trash code i wrote above, but it was actually below, in step 2, when i wrote the wrong thing in the if statement)
			# 0 indexed might actually be selling
			# but that's be too inconsistent if i didn't use 0 indexing
			# hope there's never a case where going left would allow you to reach past the end of the map on the x axis (horizontal)
			Vector2.LEFT when target_position.x >= 0:
				# should this be lowercase or uppercase?
				# guess my variables and stuff should be lowercase, but vector2's are just gonna be uppercase cuz they are
				# 	edit: i totally forgot i put that (*those comments right above here) ("uppercase" refers to the properties or something of the Vector2 class thing that has capitalized directions)
				# instead of using strings as values in that one array, it was now just the directions themselves
				print("left move currently available")
				direction_passed_steps.append(Vector2.LEFT)
			Vector2.RIGHT when target_position.x <= map_end_x_0_index:
				print("right move currently available")
				direction_passed_steps.append(Vector2.RIGHT)
			Vector2.UP when target_position.y >= 0:
				print("up move currently available")
				direction_passed_steps.append(Vector2.UP)
			Vector2.DOWN when target_position.y <= map_end_y_0_index:
				print("down move currently available")
				direction_passed_steps.append(Vector2.DOWN)
			# uhh, maybe adding this "when" (below) might bug some things, but i guess it's alright
			# i don't think it's possible for vector2.left (or the other ones with their respective cases) to neither have the target_position go below zero nor have it equal or greater than zero, as the position should be a vector2 (that holds 2 integers) (but i was just looking at one axis at a time, so just 1 integer that couldn't be neither less than 0 nor greater/equal to 0)
			Vector2.LEFT when target_position.x < 0:
				#print("so, this condition should run when target_position.x < 0 (not allowed)")
				#print("should mean that the position going left does goes below row 0, the first row, which wouldn't be allowed")
				# print("uhh, yeah. i guess it (left direction) doesn't get added to the array by default")
				print("target_position tried to go too far to the left (target_position.x < 0)")
				print("left does not work")
			Vector2.RIGHT when target_position.x > map_end_x_0_index:
				#print("right condition should fail on this one, right? i think only one condition can win, from top to bottom, right?")
				#print("edit: i'm going to add some extra conditions that are the opposite of the \"winning\" ones")
				#print("these should become comments")
				# wait is it 0 indexed? the map end x and stuff
				# i just updated the parameter name, to remember it was 0 indexed
				print("target_position passed the end of the map (target_position.x > map_end_x_0_index)")
				print("right does not work")
			Vector2.UP when target_position.y < 0:
				print("target_position goes above the map (target_position.y < 0)")
				print("up does not work")
			Vector2.DOWN when target_position.y > map_end_y_0_index:
				print("target_position goes below the map (target_position.y > map_end_y_0_index)")
				print("down does not work")
			_:
				print("code is bugged :skull: :skull: :skull:")
	
	print()
	print("remember, step 1 doesn't account for anything other than out of bounds")
	
	## just look inside the loop, bruh
	## (the i stands for index)
	## yeah nvm this variable is kicked
	#var i_direction: int
	
	# this is the step 2 of "direction_passed_steps" (edit: it used to be called "direction_passed_step1_2" but then i just decided to use that array for all the steps) (maybe i could've used that ~~object~~ (<- strikethrough) dictionary at the top?)
	# could just be called "obstacle" instead of "obstacle_coord"
	print()
	#print("the amount of directions that passed, 0 indexed: ", direction_passed_steps.size() - 1)
	print("directions that passed step 1: ", direction_passed_steps.size())
	# yeah, i'll find spread operator later
	print("said directions: ", direction_passed_steps)
	
	print()
	print("starting step 2...")
	print()
	print("checking direction for obstacles...")
	
	
	#for obstacle_coord in obstacles:
		### index of the direction as we go through the while loop
		### whoops i should declare this outside of the for in loop
		### .size() returns the amount of elements/values, right?
		### or else i'd not have to do "- 1"
		#i_direction = direction_passed_steps.size() - 1
		##print("the amount of directions that passed, 0 indexed:", i_direction)
		## the while loop is basically a for loop (maybe in js), but i think gdscript doesn't have that
		## could've been like this: for(let i = directionArray.length - 1; i >= 0; i--)
		## loops backwards through the array (remember guys, the "- 1" is there because .length tells the amount of elements, not the last element's index) (for context, .length is always (i think) going to be last element's index +1, or the last element's index is one less than the length of the array) (so they are pretty similar, but off by one)
		## (i guess gdscript uses .size() instead)
		## what was the alternative to using this backwards looping array, again? (not including forwards looping)
		## it was something kind of magical, but it was like too uhh laggy or something for simple things
		## something like that
		## i think this should work though
		## this weird loop might have a fairly high chance to bug (in runtime) (especially since we're deleting things)
		## wonder if the normal for in loop with using the values (instead of index) could work with a backward loop
		## i could try the other array functions, too
		#
		### said direction, initialized outside of the loop for reasons. (yeah turns out it's still in the for in loop)
		### direction is something like Vector2.DIRECTION,
		### with that being replaced with up down left right.
		### at least i hope
		### this "direction" variable might bug everything out, so uhh, it could be removed (it was only used 1 time)
		### just noticed it was in the for in loop
		### guess it gotta get kicked (there's at least like 4 obstacles in that obstacle array; way too many (sarcasm/hyperbole) instances (there would only be 4, but that's pretty obvious to figure out) will be made of this variable (or something like that))
		## (uhh optimization, i guess) (did he mean optimization by deleting it?)
		##var direction: Vector2
		#
		## by the way, this loop is basically saying as long as the current index is greater than -1 (which wouldn't be nice to go through, since we already looped once "normally" (backwards from the last index)
		## >= 0 because we start with a positive index value (specifically (i think), the highest index value of the array)
		## and because 0 is an index of the array, we include it
		## -1 doesn't count because we've already checked the last index
		#while i_direction >= 0:
			##direction = direction_passed_steps[i_direction]
			#
			## if the [current value (through the index) of the array]'s vector2 coords are the same as one of the given obstacles,
			## then we remove that direction
			## bro im just kidding
			## wait this was just going to be something like Vector2(0, -1) probably
			## not the actually coordinate of the direction
			## whoops, let me fix that
			## old code:
			##if direction_passed_steps[i_direction] == obstacle_coord:
				##direction_passed_steps.remove_at(i_direction)
			## good thing i decided to reread my code for no reason
			## that could've taken, like, 10 years of debugging
			## turns out the logic is this:
			## 	if the chosen direction moves our current position (by adding vector2's, obviously)
			## onto the same vector2 coords as an obstacle, then we remove that direction from the array
			#if (direction_passed_steps[i_direction] + current_position) == obstacle_coord:
				#print(direction_passed_steps[i_direction], " is on an obstacle! (you'll have to convert to direction)")
				#direction_passed_steps.remove_at(i_direction)
			#
			## decrement (to go through the indices of the array)
			#i_direction -= 1
	## this code (^) should work, right?
	
	
	# yeah, that code wasn't cool enough
	# lemme rewrite it
	
	## uh, im just gonna add this variable for clarity.
	## something like that.
	## should probably give it a better name
	var obstacle_targeted_position_checker_variable_comparer: Vector2
	
	for direction in direction_passed_steps.duplicate():
		# might as well just call it obstacle_coord again (wait, again?)
		obstacle_targeted_position_checker_variable_comparer = current_position + direction
		for obstacle_coord in obstacles:
			if obstacle_targeted_position_checker_variable_comparer == obstacle_coord:
				print(direction, " goes onto an obstacle! said obstacle is at ", obstacle_coord)
				direction_passed_steps.erase(direction)
				break
	# wowwww
	# so much more simpler
	# i think this works
	
	
	print()
	print("starting step 2.5...")
	print("seeing if the end is right onto the next move...")	
	for direction in direction_passed_steps.duplicate():
		if direction + current_position == end:
			direction_passed_steps = [direction]
			print()
			print("are we there yet??")
			print()
			break
		else:
			print("nah")
	
	print()
	print("starting step 3...")
	
	
	# step 3
	# doing the stuff with traceback_path (kind of weird name imo)
	# and making the direction not count if it uhh was on one of those paths depending on the mode
	# something like that
	# uhh, i think it was like
	# removing the direction from the direction passed array
	# if the coordinate it goes to (remember to do current_position + direction for the tested space it wants to go to, rather than just the direction)
	# is one of the stored spaced in the array(s)
	print()
	print("checking for traceback_path logic...")
	print()
	
	
	match trace_travel_mode:
		# don't go along the traceback_path array
		# wonder if this code should also be affected (in some way) by the traceback_path2 array
		# hmmmm...
		-1: # first travel
			print("we are in mode -1; no traceback_path allowed")
			
			# uhh, maybe i could've done this (code below) before...
			# yeah cuz "bugs" is why the array has to be duplicated while looping
			
			## position coordinate we are trying to go to
			var target_position: Vector2
			for direction in direction_passed_steps.duplicate():
				# this should work, right?
				target_position = direction + current_position
				for coord in traceback_path:
					# this code should work, right?
					# i think the second condition is just cuz
					# it might bug things, though
					# erase the direction if the targeted position goes onto one of the coords in the traceback_path
					# i'm gonna delete the 2nd condition
					if target_position == coord: # and direction_passed_steps.has(direction):
						print(direction, " wasn't fit to live, since it was on the traceback_path, which is coord ", coord)
						direction_passed_steps.erase(direction)
						break # this should work, right? after the direction is deleted, there's no point in checking the rest of the coords in traceback_path
			
			
			## there could be some other stuff about interactions with traceback_path2, but i can add that later
			# is this all for mode -1?
		
		
		
		
		
		
		
		# don't go along the traceback_path2 array (check)
		
		# check if the available spots targeted by the movement directions aren't ones already in the traceback_path array
		# if so (there's a new spot), prioritize that direction (and delete the other ones) (check)
		# and somehow switch back to mode -1... (NOT DONE)
		# if not (there's only coords that go onto the traceback_path or traceback_path2 arrays)
		# then make sure (still) not to go onto traceback_path2, but instead go onto traceback_path
		# also, while in mode 1, after switching to mode 1 by returning an empty array (no available moves), make sure to append the current_position coords to the traceback_path2 array
		# also, after finding a move while in mode 1, make sure to append the current_position to the traceback_path2 array
		# i could just make it so if the current_position coords are already inside traceback_path2 (wait, that should be impossible in mode 1...), then don't append it
		# but that'd be too much work, and my logic should just fix it anyways, right?
		# because we want to check available spots vs spots already in traceback_path, we will need another array
		
		1: # second travel back
			print("mode 1; no traceback_path2 allowed")
			
			## the array for keeping track of directions that go to new spots instead of ones in traceback_path2,
			## so those directions will be prioritized
			## for mode 1 of step 3
			var new_spots_directions: Array[Vector2] = []
			
			## maybe we need this array?
			## failures
			## oops, i mean the available directions that go onto coords in the traceback_path array
			## this array might not be needed
			## yeah nvm
			# var traceback_path_directions: Array[Vector2]
			
			## position coordinate we are trying to go to
			var target_position: Vector2
			
			# step 1 filtering
			for direction in direction_passed_steps.duplicate():
				# this should work, right?
				target_position = direction + current_position
				for coord in traceback_path2:
					# this code should work, right?
					# i think the second condition is just cuz
					# it might bug things, though
					# erase the direction if the targeted position goes onto one of the coords in the traceback_path
					if target_position == coord and direction_passed_steps.has(direction):
						print(direction, " wasn't fit to live, since it was on the traceback_path2, which is coord ", coord)
						direction_passed_steps.erase(direction)
						break # hopefully this works, right?
			
			
			# step 2 checking if it's a new direction
			
			# don't really need to duplicate it
			# yeah who cares about "not nesting" when i could just spam the same thing over and over (cries)
			print()
			for direction in direction_passed_steps.duplicate():
				# innocent until proven guilty
				new_spots_directions.append(direction)
				# print(new_spots_directions, " is currently being tested, but the previous values are probably good")
				
				target_position = direction + current_position
				for coord in traceback_path:
					if target_position == coord:
						print("sadly, ", direction, " was NOT fit to go onto a new spot (just a minor inconvenience)")
						new_spots_directions.erase(direction)
						# this should work, right????
						break
				print("new spots: ", new_spots_directions, " after analyzing what available spots aren't on the traceback_path coords")
			
			
			# step 3 do some more stuff depending on whether there are new spots available
			
			# if there are new spots, then
			# hmm, i guess i could just do "if new_spots_directions:", but maybe that wouldn't be specific enough
			# i guess the comments would've told the purpose of the code, though
			if !new_spots_directions.is_empty():
				print()
				print("spots available: ", new_spots_directions)
				
				# loop through available directions
				for direction in direction_passed_steps.duplicate():
					
					# check whether the direction is NOT inside the new_spots_directions array
					if !new_spots_directions.has(direction):
						# if so (it's not in the new spot array), then we delete it (i guess it says "erase", but i don't really care)
						print(direction, " was, sadly, not cool enough")
						# this should be the right syntax, right? (<- strikethrough that) (i was trying to use str())
						# print(direction, ": *dies*")
						direction_passed_steps.erase(direction)
				
				
				# special code thing for giving the main function the new_spots_directions array
				# a little bit of a hodge-podge
				print()
				print("making the array confusing because i'm too lazy... (adding the new_spots_directions values to passed directions)")
				print("just gonna print it again, cuz why not?")
				print("new spots: ", new_spots_directions)
				direction_passed_steps.append(Vector2(-1, -1))
				direction_passed_steps.append_array(new_spots_directions)
				print("updated passed directions: ", direction_passed_steps)
	print()
	
	
	# i didn't even think i'd need this, but i just realized i could've went the wrong direction when right next to the end
	# probably would only work (or be useful) in this grid based thing
	
	# extra step: override if we are right next to the end (well, i could just handle this in the main function, but whatever)
	# yeah remember that: this can just be added to the "main" function
	# or whatever its "parent" function that's calling this is
	#for direction in direction_passed_steps.duplicate():
		#pass
	# nvm i'm just gonna handle this in the main function
	# too much work adding another argument
	# yeah nvm guys i handled it in this function (step 2.5)
	
	
	#return [] # wait returning this by default is actually goated, unless all the nearby spaces get taken
	# then i'd have to come up with more complicated/failsafe logic...
	# it seems i have partially come up with the more complicated/failsafe logic
	# uhh, i might not use this for returning anymore, since the direction_passed_steps could just be empty, and have the same function
	# seems i might need some code to see when "this" (get it?) function returns an empty array
	# so then i'd know to switch modes
	# seems i might have to return another value that has to be checked for if i wanted to change the mode from within this function, because the mode is handled inside the other function
	# yeah who knew what he was thinking as he wrote that
	
	# uhh yeah
	# anyways
	# time to return that array
	# i hope this works
	print("returning move options...")
	print(direction_passed_steps)
	return direction_passed_steps




## supposedly, nesting is bad
## and i should make extra functions
## converts an array of Vector2.directions to coords, from a starting position
func directions_to_coordinates(move_sequence_path: Array[Vector2], start: Vector2) -> Array[Vector2]:
	
	## passing the path by value, just cuz.
	## the path with the directions of moves inside it.
	## i could've gave it a better name than "path"
	## yeah i don't think this variable is necessary since i didn't edit anything
	#var path := move_sequence_path.duplicate()
	
	## array that holds the converted coords
	var coords: Array[Vector2] = []
	
	# how the conversion should work
	# get some array that holds the coords
	
	# keep track of position through a variable
	# for loop some thing that loops through the things of the path array
	# for every iteration of the loop, add the current position through a variable
	
	## the position being tracked, so we can do some array stuff
	var current_position := start
	
	# loop
	# was it really this easy?
	for direction in move_sequence_path:
		current_position += direction
		coords.append(current_position)
	
	
	
	
	# return the newly generated coords
	return coords




## time for more functions! (i had to add some sort of punctuation) (yeah, that's not really the right tone).
## this function will check for duplicates in an array,
## and then return the indices of the array at which doubles were found
func check_for_duplicate_values_in_array(array_to_check: Array):
	# how this might work??
	# loop through the array (probably using while loop that acts like my usual for loop)
	# use .count()
	# see if the value is a number greater than 1
	# we want to find the indices of the first occurance to the last occurance (idc about the ones in between for 3+ occurances)
	# uhh, yeah, i'll probably be able to do that
	# might have to loop using index, though
	# and have too many variables
	# well, i guess the value with the lowest index should be prioritized first
	# any "counted" duplicates between the 2 indices of the first value with duplicates should be removed
	
	pass



# definitely cool code that i should definitely push
func uhh():
	while(false):
		uhh()
		pass





## short function that just checks for repeated coordinates, and then deletes stuff if it finds repeating coordinates.
## yeah so far idk how this would actually work
func optimize_path(move_sequence_path: Array[Vector2], start: Vector2, end: Vector2) -> Array[Vector2]:
	# yeah idk how to do this
	# steps:
	# read the move_sequence_path array
	# convert to coordinates (into a new array)
	var coords = directions_to_coordinates(move_sequence_path, start)
	
	
	# check for coordinates that have duplicates
	# index them
	# using magical code (that has backwards functionality, maybe like getting some values to do a "reverse" .slice()),
	# delete the extra coords
	# if the first coord in the converted coordinate array is the start coord, undo it
	# uhh, somehow convert the coords back into moves?
	# wait, nvm, i can just delete the same amount of values from the move_sequence_path array, since they should have the same ones
	# i guess do that thing with the first move being "Vector2(0, 0)" in the move_sequence_path array having to be deleted
	return move_sequence_path # update this












## function for creating the path the turtle will take
func generate_path(grid: Array[Array], max_loop_iterations_argument: int) -> Array[Vector2]:
	# dang, this function really just does take the grid as its only argument
	# guess not anymore
	
	## i updated this to a [variable] to avoid accidentally (somehow) mutating the original grid.
	## i mean a [variable that was passed by value].
	## this was added at the same time i added the second parameter/argument...
	## whoops i had a typo
	var grid_copy = grid.duplicate(true)
	
	
	## where the turtle starts
	var start: Vector2 = Vector2(0,0)
	
	## uhh, where the turtle stops moving?
	var end: Vector2 = Vector2(0,0)
	
	## spaces (coordinates?) of which the turtle cannot go onto
	var obstacles: Array[Vector2] = []
	
	## the amount of 0 indexed columns in the grid
	var y_column_count = 0
	## the amount of 0 indexed rows in the grid
	var x_row_count = 0
	
	for i in grid_copy.size(): # vertical, y
		if i > y_column_count:
			y_column_count = i;
		for j in grid_copy[i].size(): # horizontal, x
			if j > x_row_count:
				x_row_count = j
			# 	the current row column value (grid[i][j]) being looped through
			# is equal to 2, signifying it's the starting square
			if grid_copy[i][j] == 2:
				start = Vector2(j, i)
				print("start: ", start)
			# current value being read = 3, the end
			if grid_copy[i][j] == 3:
				end = Vector2(j, i)
				print("end: ", end)
			# obstacles, which are 0
			if grid_copy[i][j] == 0:
				obstacles.append(Vector2(j,i))
	
	for value in obstacles:
		print("obstacle: ", value)
	
	## the technical position we are imagining our turtle in, without actually moving the turtle
	var tested_position: Vector2 = start
	
	## the path we've moved along so far.
	## should i include our starting square?
	## might as well, since it's going to get included sooner or later.
	## nvm, just realized adding the starting square would bug it, since the uhh moving already adds it.
	## well, i guess i added the starting square anyways in the end
	var traceback_path: Array[Vector2] = [] # something about appending
	# 	as we are rerouting by going backwards along the path, i should pop the values from this
	# traceback_path to another traceback array like it, but instead it starts the moment on the coord we get stuck
	# 	doing this to avoid accidentally going back on the path we've just gone as we recheck for new spaces to go to
	# 	there's definitely going to be bugs with trying to go to a different area, or as we're going along the first traceback path,
	# my logic might break and bug and stuff with the connections to the 2nd traceback_path
	
	## the second traceback path, not actually sure how this will work, mb.
	## i guess the code has comments somewhere about how it works
	var traceback_path2: Array[Vector2] = []
	
	## 	 it seems we are going to have 2 modes.
	## 	 when the coords in traceback_path cannot be traversed
	## and another one, when the coords in traceback_path2 cannot be traversed, and we have to go back.
	## 	 along our original traceback_path and check for available other spaces every step.
	## 	 sounds a little complicated and unoptimized imo.
	## -1 = we are on traceback_path, just exploring and not moving back.
	## 1 = it's time to go back, actually. try to travel along theO traceback_path, while not going on traceback_path2, and 
	## uhh what was he going to say
	var trace_travel_mode: int = -1
	# it seems gdscript doesn't have unions
	# so hopefully we'll remember it will only take -1 or 1
	# i decided to put -1 and 1 just so i can flip the sign
	# or do something like trace_travel_mode *= -1 to flip the state
	# that was a little unnecessary
	# yeah im going to call travel mode "trace_travel_mode" now
	# so you know it's related to the traceback_path
	
	
	## i don't wanna reopen godot,
	## so i'm going to make this next loop explode after a set number of iterations
	var loop_iteration_count = 0
	
	## variable cuz why not
	var max_loop_iterations = max_loop_iterations_argument
	
	# probably put some loop code here
	# that runs the one function above
	
	## variable that receives the returned array of the move finder
	var returned_moves: Array[Vector2] = []
	
	## index for counting the one thing with Vector2(-1, -1)
	var returned_moves_index: int = 0
	
	## new spots directions, but transported over here
	var new_spots_directions: Array[Vector2] = []
	
	## random variable to store a copy of traceback_path2, cuz why not
	var _traceback_path2_copy: Array[Vector2] = []
	
	## array that holds the sequence of moves
	var optimize_this_array: Array[Vector2] = []
	
	while (tested_position != end) and (loop_iteration_count < max_loop_iterations):
		loop_iteration_count += 1 # yeah im just gonna put it at the top
		print()
		# uhh, zero indexed, trust?
		# yeah idk about this actually
		print()
		print("loop iteration #: ", loop_iteration_count - 1, " + 1")
		print()
		
		# this print statement (below) says that because i put another print statement that tells if the function (check available spaces to move to) is running
		# so this one tells when it runs inside of the while loop, which is in the "main" function
		# maybe someday it wouldn't be the main function
		# when (or if) this function has to be run multiple times itself... (i might just recursion)
		print("running the function, but in the loop...")
		returned_moves = check_available_spaces_to_move_to(tested_position, obstacles, traceback_path, traceback_path2, trace_travel_mode, x_row_count, y_column_count, end)
		# i guess move order will be left, right, up, down
		# for spots of equal value
		# maybe i should've given those spots a weight value...
		# uhh, i'll do that "next time" (if i remember)
		# dang, this could've been pretty useful, actually
		# since i could just modify some integer instead of having to rewrite and add code
		# reminder: for anything that could look like it has randomization, but i didn't actually want "random"-ness, use a value weight (or something like that)
		# i mean, it shouldn't be too hard to rewrite rn
		# because the move selection is just down there
		# but i don't actually need to do move weight selection currently
		
		if returned_moves.is_empty():
			print("no available spaces to go to")
			print("switching to trace_travel_mode 1...")
			trace_travel_mode = 1
			print("adding current spot to traceback_path2 array...")
			traceback_path2.append(tested_position)
			
			# i wonder if i should check if the spot could be removed from the traceback_path array in this code
			# it wouldn't really make sense, since you would have to get stuck in a corner, which requires going onto a new spot
			# but it would be a nice failsafe for a condition that is pretty much impossible (do i even know what a failsafe is?)
			# i mean, might as well
			# (it might make it multiplicatively (or just additively) laggier)
			# (those are words, right?)
			if(traceback_path.has(tested_position)):
				traceback_path.erase(tested_position)
			continue
		
		if loop_iteration_count <= 1:
			print()
			# this makes sense, right?
			# might be a little ambiguous to what i actually mean
			print("by the way, if the returned move count has only 1 value, then a move won't need to be chosen (it will just be the one returned move)")
			# evil single quotes
			print('also, since the move hierarchy goes "left, right, up, down", you can probably infer what move is going to be chosen')
			print()
		
		
		# might just have to empty this array
		new_spots_directions = []
		
		# second condition is pretty optional
		# since the returned_moves array is only going to have "Vector2(-1, -1)" while we're in mode 1
		if returned_moves.has(Vector2(-1, -1)) and trace_travel_mode == 1:
			while returned_moves_index < returned_moves.size():
				if returned_moves[returned_moves_index] == Vector2(-1, -1):
					# i could lessen this (i assume he meant "shorten the text")
					print("index of returned_moves starts at ", returned_moves_index, ", meaning the index with the Vector2(-1, -1) marker is at returned_moves_index[", returned_moves_index, "]")
					break
				returned_moves_index += 1
			new_spots_directions = returned_moves.slice(returned_moves_index + 1)
			print("new spots: ", new_spots_directions)
			print()
		
		
		elif returned_moves.size() > 1:
			for direction in returned_moves:
				match direction:
					Vector2.LEFT:
						returned_moves = [Vector2.LEFT]
						print("left chosen to move!")
						break
					Vector2.RIGHT:
						returned_moves = [Vector2.RIGHT]
						print("right chosen to move!")
						break
					Vector2.UP:
						returned_moves = [Vector2.UP]
						print("up chosen to move!")
						break
					Vector2.DOWN:
						returned_moves = [Vector2.DOWN]
						print("down chosen to move!")
						break
					_:
						print("this shouldn't be possible?!!")
						print("bro's code is bugged (again)")
						break
		
		if !new_spots_directions.is_empty():
			print("choosing from a New spot (imagine \"new\" was extra wavy and cool)...")
			print("(not one of the stinky traceback_path2 spots)")
			for direction in new_spots_directions:
				match direction:
					# i copy-pasted it
					Vector2.LEFT:
						returned_moves = [Vector2.LEFT]
						print("left chosen to move!")
						break
					Vector2.RIGHT:
						returned_moves = [Vector2.RIGHT]
						print("right chosen to move!")
						break
					Vector2.UP:
						returned_moves = [Vector2.UP]
						print("up chosen to move!")
						break
					Vector2.DOWN:
						returned_moves = [Vector2.DOWN]
						print("down chosen to move!")
						break
					_:
						print("this shouldn't be possible?!!")
						print("bro's code is bugged (again)")
						break
			print("resetting trace_travel_mode back to -1...")
			trace_travel_mode = -1
			# imo, i should just gonna reset the traceback_path2 array
			# might be a little dangerous...
			# actually, lemme copy it for no reason first
			# uhh, not sure if it was nested (it has a very high chance of not being nested), but i'm gonna do .duplicate(true) anyways
			# more like "not sure if it had nested arrays/(other things passed by reference) in it/as one or more of its values"
			# yeah nvm
			# uhh, im just gonna comment this out for now
			#_traceback_path2_copy.append_array(traceback_path2)
			traceback_path2 = []
		
		print("moving turtle...")
		if trace_travel_mode == -1:
			print("added last spot to the traceback_path array")
			traceback_path.append(tested_position)
		elif trace_travel_mode == 1:
			if traceback_path.has(tested_position):
				print("removing last spot from traceback_path...")
				traceback_path.erase(tested_position)
			# yeah, nvm. (the process of) finding synonyms is too crazy (for me to handle?)
			print("reclassify the last spot into traceback_path2...")
			traceback_path2.append(tested_position)
		tested_position += returned_moves[0] # wait, why was it an array, again? (looks kind of ugly)
		print("turtle's position, probably: ", tested_position) # "probably" because the turtle actually hasn't moved yet. it was astral projecting itself along the path to find the way through
		# totally forgot i had to turn the moves into a sequence
		optimize_this_array.append(returned_moves[0])
	print()
	if tested_position != end:
		print("cooked :skull:")
		# heh, heh
		# time for some recursion
		# this will work, right?
		# this doesn't seem very optimized...
		return generate_path(grid_copy, max_loop_iterations+10)
	print("end reached!")
		
	
	
	# start position is automatically going to be part of the returned array, for optimization reasons
	# depending on if the optimization worked and if the start coord wasn't already deleted,
	# if the returned arrays starts with the start coord (implying that we didn't go on a wrong path and re-reached the start),
	# we should delete the start coord if the first value (0th index) has it, since we already start on that coord
	# i should use slice somehow (optionally) (for fun)
	# turns out i decided to do that in another function
	# uh yeah who knows what i was talking about there
	print()
	print("getting move sequence...")
	optimize_this_array.push_front(Vector2(0, 0))
	print(optimize_this_array)
	print("(that first move isn't technically part of it)")
	
	
	print()
	print("optimizing path...")
	optimize_path(optimize_this_array, start, end)
	
	return [] # fix this to do some stuff



# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	for i in 50:
		print()
	print("running...")
	var _turtle_path = []
	generate_path(grid_of_area, 20)
	# pass
