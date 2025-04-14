-- Day 4 Part 1

local file = "/home/kim/embedded_linux/aoc2024/day04/input.txt"
local input = { }
local total = 0

for line in io.lines(file) do
        local row = {}
	for i = 1, #line do
		row[i] = line:sub(i, i)
	end

	table.insert(input, row)
end

local length = #input

--  x axis
for i = 1, length do
	local j = 1
	while j <= length - 3 do
		local char = input[j][i]

		if char == "X" then
			if (input[j + 1][i] == "M" and
			    input[j + 2][i] == "A" and
			    input[j + 3][i] == "S") then
				total = total + 1
			end
		elseif char == "S" then
			if (input[j + 1][i] == "A" and
			    input[j + 2][i] == "M" and
			    input[j + 3][i] == "X") then
				total = total + 1
			end
		end

		j = j + 1
	end
end

-- y axis
for i = 1, length do
	local j = 1
	while j <= length - 3 do
		local char = input[i][j]

		if char == "X" then
			if (input[i][j + 1] == "M" and
			    input[i][j + 2] == "A" and
			    input[i][j + 3] == "S") then
				total = total + 1
			end
		elseif char == "S" then
			if (input[i][j + 1] == "A" and
			    input[i][j + 2] == "M" and
			    input[i][j + 3] == "X") then
				total = total + 1
			end
		end

		j = j + 1
	end
end

-- diagonal \
for i = 1, length - 3 do
	local j = 1
	while j <= length - 3 do
		local char = input[i][j]

		if char == "X" then
			if (input[i + 1][j + 1] == "M" and
			    input[i + 2][j + 2] == "A" and
			    input[i + 3][j + 3] == "S") then
				total = total + 1
			end
		elseif char == "S" then
			if (input[i + 1][j + 1] == "A" and
			    input[i + 2][j + 2] == "M" and
			    input[i + 3][j + 3] == "X") then
				total = total + 1
			end
		end

		j = j + 1
	end
end

-- diagonal /
for i = 1, length - 3 do
	local j = length
	while j >= 4 do
		local char = input[i][j]

		if char == "X" then
			if (input[i + 1][j - 1] == "M" and
			    input[i + 2][j - 2] == "A" and
			    input[i + 3][j - 3] == "S") then
				total = total + 1
			end
		elseif char == "S" then
			if (input[i + 1][j - 1] == "A" and
			    input[i + 2][j - 2] == "M" and
			    input[i + 3][j - 3] == "X") then
				total = total + 1
			end
		end

		j = j - 1
	end
end

print ("part01: " .. total)
