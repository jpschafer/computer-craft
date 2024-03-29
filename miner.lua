local tArgs = { ... }
local length = tonumber(tArgs[1])
local width = tonumber(tArgs[2])
local height = tonumber(tArgs[3])
local turnRight = true
local slot = 1

--Helper Functions
function nextSlot()
	if slot < 16 then
		slot = slot + 1
	else
		slot = 1
	end
	turtle.select(slot)
end

function place()
	block = turtle.inspectDown()
	if block then
		if not turtle.compareDown() then
			turtle.digDown()
			turtle.placeDown()
		end
	end
end



-- Main Function --

function main()
	
	if width == nil then
		print("1. Place turtle (with pickaxe) facing direction of said mining (cube) area on left side and above the first layer you want to mine.")
		print("2. Load turtle with enough fuel for mining.")
		print("3. Type 'platform <length> <width> <height>'")
		return 0
	end
	
	turtle.select(slot)
	turtle.refuel();

	turtle.dig()
	turtle.forward()

	-- For Every 3 Levels of Height
	for k = 0, height, 3 do
		-- For Every block of width
		for j = 1, width, 1 do

			-- For every block of length
			for i = 1, length, 1 do
				if turtle.getItemCount(slot) == 0 then
					nextSlot()
				else
					turtle.refuel()
				end

				turtle.digUp()
				turtle.digDown()

				if i < length then
					turtle.dig()
					turtle.forward()
				end
			end

			if j < width then

				if turnRight == true then
					turtle.turnRight()
					turtle.dig()
					turtle.forward()
					turtle.turnRight()
					turnRight = false
				else
					turtle.turnLeft()
					turtle.dig()
					turtle.forward()
					turtle.turnLeft()
					turnRight = true
				end
			end
		end

		if k < height then
			turtle.digUp()
			turtle.up()
			turtle.digUp()
			turtle.up()
			turtle.digUp()
			turtle.up()
			turtle.turnRight()
			turtle.turnRight()

			-- due to orientation magic, we don't need to 'not' our turnRight variable
		end
	end
end

main()