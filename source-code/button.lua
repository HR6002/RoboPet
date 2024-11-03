---@class Button
---@field text string
---@field width number 
---@field height number
---@field x number 
---@field y number 
Button = {}
Button.__index = Button

-- Instatiator for the Button Class
function Button:new(text, width, height, x, y)
    local instance = setmetatable({}, Button)
    instance.text = text
    instance.width = width
    instance.height = height
    instance.x = x
    instance.y = y
    return instance
end 

-- Draws the button with centered text 
function Button:draw()
    love.graphics.setColor(1, 1, 1)
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(self.text)
    local textHeight = font:getHeight()
    local textX = (self.x + self.width/2) - (textWidth/2)
    local textY = (self.y + self.height/2) - (textHeight/2)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(self.text, textX, textY)
end 

-- Checks to see if the button is clicked
---@param mouseX number
---@param mouseY number
---@return boolean
function Button:isClick(mouseX, mouseY)
    if mouseX > self.x and mouseX < self.x + self.width and mouseY > self.y and mouseY < self.y + self.height then
        return true
    end
    return false
end

return Button