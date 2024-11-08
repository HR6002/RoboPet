---@class Monitor
---@field colorArgs table
---@field label string 
---@field color table 
---@field progress number
Monitor= {}
Monitor.__index = Monitor

-- instantiator for the Monitor class
function Monitor:new(colorArgs, label)
    local instance = setmetatable({}, Monitor)
    instance.color = colorArgs
    instance.label = label
    instance.progress = 100
    return instance
end 

-- Draws the monitor bar and the progress and the label
function Monitor:draw(x,y)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('line', x, y, 100, 20)
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.rectangle('fill', x, y, self.progress, 20)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.label, x, y + 23)
end 

return Monitor