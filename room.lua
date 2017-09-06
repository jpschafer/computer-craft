local tArgs = {...}
local length = tonumber(tArgs[1]) 
local width = tonumber(tArgs[2])
local height = tonumber(tArgs[3])
local turnRight = true
local slot = 1
local wallSide = 0
local NUM_SLOTS = 16

--Helper Functions
function nextSlot()
	if slot < NUM_SLOTS then
		slot = slot + 1
	else
		slot = 1
	end
      turtle.select(slot)
end

function refuel()
	if turtle.getFuelLevel() == 0 then
		for i = 1, NUM_SLOTS, 1 do
			nextSlot()
			turtle.refuel()
		end
	end
end

function place()
	block = turtle.inspectDown()
	if block then
		if not turtle.compareDown() then
			turtle.digDown()
			turtle.placeDown()
		end
	else 
		turtle.placeDown()
	end
end

function forward()
	if turtle.detect() then
		turtle.dig()
	end
	turtle.forward()
end

function up()
	if turtle.detectUp() then
		turtle.digUp()
	end
	turtle.up()
end

function buildFloor() 
	turtle.select(slot)

	for i = 1, width, 1 do
	  
		--Move Forward X Blocks and clear for Floor
		for j = 1, length, 1 do
			if turtle.getItemCount(slot) == 0 then
				nextSlot()
				place()
			else
				place()
			end
			
			if j < length then
				forward()
			end
	  
		end
	  
	  if i < width then
	  
		if wallSide == 1 then
			turtle.turnRight()
			forward()
			turtle.turnRight()
		else 
			turtle.turnLeft()
			forward()
			turtle.turnLeft()
		end
		wallSide = (wallSide + 1) % 2
	  end
	end
end

function buildWalls() 
	turtle.select(slot)
	turtle.turnRight()
	
	--Deal with oddities on which end I'm on.
	if wallSide == 1 then
		turtle.turnRight()
	end
	
	for i = 1, (height-1), 1 do
		up()
		
		for j = 1, 4, 1 do 
			-- Determine Wall Size
			wallSize = width
			if wallSide == 1 then
				wallSize = length
			end
			
			for k = 1, wallSize, 1 do
				if turtle.getItemCount(slot) == 0 then
					nextSlot()
					place()
				else
					place()
				end
				if k < wallSize then
					forward()
				end
			end
			
			turtle.turnRight()
			wallSide = (wallSide + 1) % 2
		end
	end
end

function buildRoof()
	up()
	buildFloor()
end

-- Main Function --
function main()
	
	if width == nil then
		print("1. Place turtle facing direction of said platform on left side.")
		print("2. Load turtle with materials for the platform.")
		print("3. Type 'platform <length> <width> <height>'")
		return 0
	end
	-- Look For Fuel if empty
	refuel()
	
	-- Build floor
	buildFloor()
	
	-- Build Walls
	buildWalls()
	
	-- BuildRoof
	buildRoof()
end

main()

