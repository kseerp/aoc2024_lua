-- Day 4 Part 2

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

for i = 1, length do
	local j = 1
	while j <= length do
		local char = input[j][i]

		if char == "A" and j > 1 and i > 1 and j < length and i < length then
                        local tl = input[j - 1][i - 1]
                        local tr = input[j - 1][i + 1]
                        local bl = input[j + 1][i - 1]
                        local br = input[j + 1][i + 1]

			if ((tl == "M" and br == "S") or (tl == "S" and br == "M")) and
                            ((bl == "M" and tr == "S") or (bl == "S" and tr == "M")) then
				total = total + 1
			end
                end
		j = j + 1
	end
end

print("part02: " .. total)
