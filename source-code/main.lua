_G.love = require("love")
Button = require('button')
Monitor = require('monitor')
Anim8 = require('lib/anim8')
-- Import the neccssary modules and classes 

-- Loads all the variables and objects before the game starts 
function love.load()
-- Plater Object
    Player = {}
    Player.birth = os.time()
    Player.lastFed = os.time()
    Player.lastInteraction = os.time()
    Player.colorR = 1
    Player.colorG = 1
    Player.colorB = 1

-- Sprite object
    Sprite={}
    Sprite.happy={
        spriteSheet = love.graphics.newImage('sprites/happy.png'),
        animation = Anim8.newAnimation(Anim8.newGrid(288, 284, 3456,  3692)('1-12', '1-12'), 0.05)
    }

    Sprite.normal={
        spriteSheet = love.graphics.newImage('sprites/normal.png'),
        animation = Anim8.newAnimation(Anim8.newGrid(288, 284, 3456,  3692)('1-12', '1-12'), 0.05)
    }

    Sprite.sad={
        spriteSheet = love.graphics.newImage('sprites/sad.png'),
        animation = Anim8.newAnimation(Anim8.newGrid(288, 284, 3456,  3408)('1-12', '1-12'), 0.05)
    }

    Sprite.sleep={
        spriteSheet = love.graphics.newImage('sprites/sleep.png'),
        animation = Anim8.newAnimation(Anim8.newGrid(288, 284, 3456,  3692)('1-12', '1-12'), 0.05)
    }

    Sprite.star={
        spriteSheet = love.graphics.newImage('sprites/star.png'),
        animation = Anim8.newAnimation(Anim8.newGrid(288, 284, 3456,  3692)('1-12', '1-12'), 0.05)
    }

-- Creating Monitor objects
    MonitorBars = {}
    MonitorBars.hunger = Monitor:new({red = 1, green = 0, blue = 0}, 'Hunger')
    MonitorBars.sleep = Monitor:new({red = 0, green = 0, blue = 1}, 'Sleep')
    MonitorBars.happy = Monitor:new({red = 0, green = 1, blue = 0}, 'Happiness')
    MonitorBars.health = Monitor:new({red = 1, green = 1, blue = 0}, 'Health')

-- Creating Button objects 
    InteractiveButtons = {}
    InteractiveButtons.feed = Button:new('Feed', 100, 40, 190, 530)
    InteractiveButtons.play = Button:new('Play', 100, 40, 300, 530)
    InteractiveButtons.wakeUp = Button:new('Wake Up', 100, 40, 410, 530)
    InteractiveButtons.exercise = Button:new('Exercise', 100, 40, 520, 530)
end

-- This function runs wahtever inside dt times persecond default is 60FPS
function love.update(dt)
-- Checks the current state if the player emotion and animates the corresponding sprite
    if Player.currentEmotion == 'normal' then
        Sprite.normal.animation:update(dt) 
    elseif Player.currentEmotion == 'sad' then
        Sprite.sad.animation:update(dt)
    elseif Player.currentEmotion == 'sleeping' then
        Sprite.sleep.animation:update(dt)
    elseif Player.currentEmotion == 'happy' then
        Sprite.happy.animation:update(dt)
    elseif Player.currentEmotion == 'star' then
        Sprite.star.animation:update(dt)
    end 

-- Checks the current stats of the player and updates the emotion accrodginly 
    if MonitorBars.hunger.progress < 20 or MonitorBars.happy.progress < 20 or MonitorBars.health.progress < 20 and Player.currentEmotion ~= 'sleeping' then
        Player.currentEmotion = 'sad'
    elseif MonitorBars.hunger.progress > 95 and MonitorBars.happy.progress > 95 and MonitorBars.health.progress > 95 and Player.currentEmotion ~= 'sleeping' then
        Player.currentEmotion = 'star'
    elseif MonitorBars.hunger.progress > 70 and MonitorBars.happy.progress > 70 and MonitorBars.health.progress > 70 and Player.currentEmotion ~= 'sleeping' then
        Player.currentEmotion = 'happy'
    elseif MonitorBars.hunger.progress > 50 and MonitorBars.happy.progress > 50 and MonitorBars.health.progress > 50 and Player.currentEmotion ~= 'sleeping' then
        Player.currentEmotion = 'normal'
    end 

-- Changes the players stats as time progressess
    if MonitorBars.hunger.progress > 5 and Player.currentEmotion ~= 'sleeping' then 
        MonitorBars.hunger.progress = MonitorBars.hunger.progress - 0.029
    end

    if MonitorBars.sleep.progress > 5 and Player.currentEmotion ~= 'sleeping' then 
         MonitorBars.sleep.progress = MonitorBars.sleep.progress - 0.015
    elseif MonitorBars.sleep.progress < 99 then
        MonitorBars.sleep.progress = MonitorBars.sleep.progress + 0.025
    end

    if MonitorBars.happy.progress > 5 and Player.currentEmotion ~= 'sleeping' then 
        MonitorBars.happy.progress = MonitorBars.happy.progress - 0.0058
    end

    if MonitorBars.health.progress > 5 and Player.currentEmotion ~= 'sleeping' then 
        MonitorBars.health.progress = MonitorBars.health.progress - 0.009
    end

    if MonitorBars.sleep.progress < 5 or MonitorBars.hunger.progress < 5 or MonitorBars.health.progress < 5 then
        Player.currentEmotion = 'sleeping'
    end

-- Makes the Player go ranbrainbow mode if the user has not interacted for long time
    if os.time() - Player.lastInteraction > 30 and Player.currentEmotion ~= 'sleeping'then 
        math.randomseed(os.time())
        Player.colorR = math.random(1, 100)/100
        Player.colorG = math.random(1, 100)/100
        Player.colorB = math.random(1, 100)/100
    end 
end


-- This function draws everyting thats inside of it 
function love.draw()
-- Draws the Player depending on its emotion 
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local x = (windowWidth / 2) - (288 / 2)
    local y = (windowHeight / 2) - (284 / 2) 
    love.graphics.setColor(Player.colorR, Player.colorG, Player.colorB)
    if Player.currentEmotion == 'normal' then
        Sprite.normal.animation:draw(Sprite.normal.spriteSheet, x, y)
    elseif Player.currentEmotion == 'sad' then
        Sprite.sad.animation:draw(Sprite.sad.spriteSheet, x, y)
    elseif Player.currentEmotion == 'sleeping' then
        Sprite.sleep.animation:draw(Sprite.sleep.spriteSheet, x, y)
    elseif Player.currentEmotion == 'happy' then
        Sprite.happy.animation:draw(Sprite.happy.spriteSheet, x, y)
    elseif Player.currentEmotion == 'star' then
        Sprite.star.animation:draw(Sprite.star.spriteSheet, x, y)
    end

-- Displays the monitor bars to show the Players Stats 
    MonitorBars.hunger:draw(10, 10)
    MonitorBars.sleep:draw(120, 10)
    MonitorBars.happy:draw(230, 10)
    MonitorBars.health:draw(340, 10)

-- Displays player is dead if its dead
    if MonitorBars.hunger.progress < 5 or MonitorBars.health.progress < 5 or MonitorBars.happy.progress < 5 then 
        love.graphics.print('Robot Is DEAD', 10, 65)
        love.graphics.print('Robot Is DEAD', 10, 85)
        love.graphics.print('Robot Is DEAD', 10, 105)
        love.graphics.setFont(love.graphics.newFont(22))
        love.graphics.print('ROBOT IS DEAD', 320, 450)
        love.graphics.setFont(love.graphics.newFont(12))
    else 
        love.graphics.print('Robot Age: '..os.time() - Player.birth..' day old', 10, 65)
        love.graphics.print('Robot Last Fed: '..os.time() - Player.lastFed.. ' seconds ago', 10, 85)
        love.graphics.print('Robot Last Interacted: '..os.time() - Player.lastInteraction.. ' seconds ago', 10, 105)
        if Player.currentEmotion =='sleeping' then
            love.graphics.setFont(love.graphics.newFont(22))
            love.graphics.print('Robot is Sleeping wait for sleep go up above 50% then wake it up', 50, 450)
            love.graphics.setFont(love.graphics.newFont(12))
        end 
    end 

-- Displays the different button 
    InteractiveButtons.feed:draw()
    InteractiveButtons.play:draw()
    InteractiveButtons.wakeUp:draw()
    InteractiveButtons.exercise:draw()

-- Lets the user know the Player is bored and needs to be interacted with
    if os.time() - Player.lastInteraction > 30 and Player.currentEmotion ~= 'sleeping'then
        love.graphics.setColor(1,1,1)
        love.graphics.setFont(love.graphics.newFont(22))
        love.graphics.print('I am Bored! Play with Me or give me some Excercise!', 100, 450)
        love.graphics.setFont(love.graphics.newFont(12))
    end 
end

-- Function checks if the mouse is clicked and on which position 
function love.mousepressed(x, y, button)
-- Feed button is clicked and 
    if button == 1 and InteractiveButtons.feed:isClick(x,y) and MonitorBars.hunger.progress < 95 and Player.currentEmotion ~= 'sleeping' then
        MonitorBars.hunger.progress = MonitorBars.hunger.progress + 5
        Player.lastFed = os.time()
    end

-- Play button is clicked 
    if button == 1 and InteractiveButtons.play:isClick(x,y) and MonitorBars.happy.progress < 95 and Player.currentEmotion ~= 'sleeping' then
        MonitorBars.happy.progress = MonitorBars.happy.progress + 5
        Player.lastInteraction = os.time()
        Player.colorR = 1
        Player.colorG = 1
        Player.colorB = 1
    end

-- Excercise  button is clicked 
    if button == 1 and InteractiveButtons.exercise:isClick(x,y) and MonitorBars.health.progress < 95 and Player.currentEmotion ~= 'sleeping' then
        MonitorBars.health.progress = MonitorBars.health.progress + 5
        Player.lastInteraction = os.time()
        Player.colorR = 1
        Player.colorG = 1
        Player.colorB = 1
    end

-- Wake up button clicked only works once the player sleep is above 50%
    if button == 1 and InteractiveButtons.wakeUp:isClick(x,y) and MonitorBars.sleep.progress > 50 and Player.currentEmotion == 'sleeping' then
        Player.currentEmotion = 'normal'
    end 
end
