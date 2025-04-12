-- Day 2 Part 1 and Part 2

local input = debug.getinfo(1, "S").source:sub(2):match("(.*/)") .. "input.txt"

local part1_safe = 0
local part2_safe = 0

local function is_row_safe(rows)
	local is_increasing = true
	local is_decreasing = true

	for i = 2, #rows do
		local diff = rows[i] - rows[i - 1]

		if diff < 1 or diff > 3 then
			is_increasing = false
		end

		if diff > -1 or diff < -3 then
			is_decreasing = false
		end
	end

	return is_increasing or is_decreasing
end

for line in io.lines(input) do
	local rows = { }

	for num in string.gmatch(line, "%d+") do
	        table.insert(rows, tonumber(num))
    	end

	-- Check if the row is safe without removing any level
	if is_row_safe(rows) then
		part1_safe = part1_safe + 1
		part2_safe = part2_safe + 1
	else
		-- Check if removing one level makes the row safe
		for remove_index = 1, #rows do
			local temp_rows = { }
			for i, num in ipairs(rows) do
				if i ~= remove_index then
					table.insert(temp_rows, num)
				end
			end

			if is_row_safe(temp_rows) then
				part2_safe = part2_safe + 1
				break
			end
		end
    	end
end

print("part01: " .. part1_safe)
print("part02: " .. part2_safe)
