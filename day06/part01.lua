-- Day 6 Part 1

local file = "input.txt"
local input = { }
local count = 0

for line in io.lines(file) do
	local row = {}
	for i = 1, #line do
		row[i] = line:sub(i, i)
	end

	table.insert(input, row)
end

local function arrow_up()
	for i, row in ipairs(input) do
		for j, char in ipairs(row) do
			if char == "^" then
				input[i][j] = "X"
				for k = i - 1, 1, -1 do
					if input[k][j] == "#" then
						if input[k + 1][j] == "X" then
							input[k + 1][j] = ">"
						end
						return
					elseif input[k][j] == "." then
						input[k][j] = "X"
					end
				end
				return
			end
		end
	end
end

local function arrow_right()
	for i, row in ipairs(input) do
		for j, char in ipairs(row) do
			if char == ">" then
				input[i][j] = "X"
				for k = j + 1, #row do
					if input[i][k] == "#" then
						if input[i][k - 1] == "X" then
							input[i][k - 1] = "v"
						end
						return
					elseif input[i][k] == "." then
						input[i][k] = "X"
					end
				end
				return
			end
		end
	end
end

local function arrow_down()
	for i = #input, 1, -1 do
		for j, char in ipairs(input[i]) do
			if char == "v" then
				input[i][j] = "X"
				for k = i + 1, #input do
					if input[k][j] == "#" then
						if input[k - 1][j] == "X" then
							input[k - 1][j] = "<"
						end
						return
					elseif input[k][j] == "." then
						input[k][j] = "X"
					end
				end
				return
			end
		end
	end
end

local function arrow_left()
	for i, row in ipairs(input) do
		for j, char in ipairs(row) do
			if char == "<" then
				input[i][j] = "X"
				for k = j - 1, 1, -1 do
					if input[i][k] == "#" then
						if input[i][k + 1] == "X" then
							input[i][k + 1] = "^"
						end
						return
					elseif input[i][k] == "." then
						input[i][k] = "X"
					end
				end
				return
			end
		end
	end
end

while true do
	local found = false
	local arrow_i, arrow_j

	for i, row in ipairs(input) do
		for j, char in ipairs(row) do
			if char == "^" or char == ">" or char == "v" or char == "<" then
				found = true
				arrow_i, arrow_j = i, j
				break
			end
		end
		if found then break end
	end

	if not found then break end

	if input[arrow_i][arrow_j] == "^" then
		arrow_up()
	elseif input[arrow_i][arrow_j] == ">" then
		arrow_right()
	elseif input[arrow_i][arrow_j] == "v" then
		arrow_down()
	elseif input[arrow_i][arrow_j] == "<" then
		arrow_left()
	end
end

-- -- print grid
-- for _, row in ipairs(input) do
-- 	print(table.concat(row))
-- end

for _, row in ipairs(input) do
	for _, char in ipairs(row) do
		if char == "X" then
			count = count + 1
		end
	end
end

print("part01: " .. count)
