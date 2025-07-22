-- Day 15 Part 1

local solution = {
	map = {},
	moves = {},
	robot = {},
}

-- read and parse input file
local function read_input(input)
	io.input(input)
	local content = io.read("*all")
	return content
end

local function parse_map(map_str)
	local map = {}
	local line = {}
	for i = 1, #map_str do
		local c = map_str:sub(i, i)
		if c == "\n" then
			table.insert(map, line)
			line = {}
		else
			table.insert(line, c)
		end
	end
	return map
end

local function parse_moves(movement_str)
	local moves = {}
	for i = 1, #movement_str do
		table.insert(moves, movement_str:sub(i, i))
	end
	return moves
end

local function find_robot(map)
	for i = 1, #map do
		for j = 1, #map[1] do
			if map[i][j] == "@" then
				return { i, j }
			end
		end
	end
	return nil
end

-- utils
local function apply_force(pos, force)
	return { pos[1] + force[1], pos[2] + force[2] }
end

local function apply_opposite_force(pos, force)
	return { pos[1] - force[1], pos[2] - force[2] }
end

local function in_bounds(pos, map)
	return pos[1] >= 1 and pos[1] <= #map and pos[2] >= 1 and pos[2] <= #map[1]
end

local function char_at(map, pos)
	return map[pos[1]][pos[2]]
end

local function set_char(map, pos, char)
	map[pos[1]][pos[2]] = char
end

local function equals(pos1, pos2)
	return pos1[1] == pos2[1] and pos1[2] == pos2[2]
end

local function calculate_gps(map)
	local gps = 0
	for i = 1, #map do
		for j = 1, #map[1] do
			if map[i][j] == "O" then
				gps = gps + (100 * (i - 1) + j - 1)
			end
		end
	end
	return gps
end

local function print_map(map)
	for i = 1, #map do
		io.write(table.unpack(map[i]))
		io.write("\n")
	end
end

-- simulate all moves
local function simulate_moves(map, moves, robot)
	local directions = {
		["^"] = { -1, 0 },
		["v"] = { 1, 0 },
		["<"] = { 0, -1 },
		[">"] = { 0, 1 },
	}

	for _, move in ipairs(moves) do
		local force = directions[move]
		local period = apply_force(robot, force)

		-- look for period
		while in_bounds(period, map) and char_at(map, period) == "O" do
			period = apply_force(period, force)
		end

		if in_bounds(period, map) and char_at(map, period) == "." then
			-- period found
			while not equals(period, robot) do
				set_char(map, period, "O")
				period = apply_opposite_force(period, force)
			end
			-- update robot position
			set_char(map, robot, ".")
			set_char(map, apply_force(robot, force), "@")
			robot = apply_force(robot, force)
		end
	end
end

local function main()
	local input = "/home/kim/embedded_linux/aoc2024/day15/input.txt"
	local content = read_input(input)

	-- separate the input into map and moves
	local split = content:find("\n\n")
	local map_str = content:sub(1, split)
	local movement_str = content:sub(split + 2, #content - 1):gsub("\n", "")

	-- parse map and moves
	solution.map = parse_map(map_str)
	solution.moves = parse_moves(movement_str)

	-- find robot position
	solution.robot = find_robot(solution.map)

	-- simulate moves
	simulate_moves(solution.map, solution.moves, solution.robot)

	-- print GPS
	print(calculate_gps(solution.map))
	print_map(solution.map)
end

main()
