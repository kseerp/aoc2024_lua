-- Day 8 Part 2

local file = "input.txt"
local antenna = {}
local row, col

local i = 1
for line in io.lines(file) do
        col = #line
        for j = 1, #line do
                local char = line:sub(j, j)
                if char ~= "." then
                        local node_pos = { i, j }
                        if antenna[char] then
                                table.insert(antenna[char], node_pos)
                        else
                                antenna[char] = { node_pos }
                        end
                end
        end
        i = i + 1
end

row = i - 1

local function is_outside(x, y)
        return x < 1 or x > row or y < 1 or y > col
end

local uniq_anti = {}
for _, positions in pairs(antenna) do
        for j = 1, #positions do
                local current_node = positions[j]
                for k = j + 1, #positions do
                        local partner_node = positions[k]

                        local diff = { current_node[1] - partner_node[1], current_node[2] - partner_node[2] }
                        local possible_antinode = {}

                        local factor = 1
                        while true do
                                possible_antinode = { current_node[1] + diff[1] * factor, current_node[2] + diff[2] * factor }
                                if is_outside(possible_antinode[1], possible_antinode[2]) then
                                        break
                                end
                                uniq_anti[possible_antinode[1] .. "," .. possible_antinode[2]] = true
                                factor = factor + 1
                        end

                        factor = 1
                        while true do
                                possible_antinode = { current_node[1] - diff[1] * factor, current_node[2] - diff[2] * factor }
                                if is_outside(possible_antinode[1], possible_antinode[2]) then
                                        break
                                end
                                uniq_anti[possible_antinode[1] .. "," .. possible_antinode[2]] = true
                                factor = factor + 1
                        end
                end
        end

        if #positions > 1 then
                uniq_anti[positions[1][1] .. "," .. positions[1][2]] = true
        end
end

local ans = 0
for _, _ in pairs(uniq_anti) do
        ans = ans + 1
end

print(ans)
