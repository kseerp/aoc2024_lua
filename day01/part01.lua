-- Day 1 Part 1 and Part 2

local input = debug.getinfo(1, "S").source:sub(2):match("(.*/)") .. "input.txt"

local list1 = {}
local list2 = {}

for line in io.lines(input) do
	local x = string.match(line, "^(%d+)")
	local y = string.match(line, "%s(%d+)$")

	table.insert(list1, x)
	table.insert(list2, y)
end

local function solve_part1()
	local sum = 0

	table.sort(list1, function(a, b) return a < b end)
	table.sort(list2, function(a, b) return a < b end)

	for i = 1, math.min(#list1, #list2) do
		local diff = math.abs(tonumber(list1[i]) - tonumber(list2[i]))

		sum = (sum or 0) + diff
	end

	print("part1:", sum)
end

local function solve_part2()
	local sum = 0
	for i = 1, math.min(#list1, #list2) do
		local count = 0
		for _, value in ipairs(list2) do
			if list1[i] == value then
				count = count + 1
			end
		end
		sum = (sum or 0) + (tonumber(list1[i]) * count)
	end

	print("part2:", sum)
end

solve_part1()
solve_part2()
