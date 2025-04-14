-- Day 3 Part 1

local input = debug.getinfo(1, "S").source:sub(2):match("(.*/)") .. "input.txt"

local sum = 0

local function mul(a, b)
        local product = a * b

        sum = product + sum
end


for line in io.lines(input) do
	for x, y in line:gmatch("mul%((%d+),%s*(%d+)%)") do
		mul(tonumber(x), tonumber(y))
	end
end

print("part01: " .. sum)
