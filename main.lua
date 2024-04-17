-- main.lua

local Plant = require("plant")
local Zombie = require("zombie")

local plants = {}
local zombies = {}
local gameOver = false

local score = 0

function love.load()
  math.randomseed(os.time())

  -- Initialize plants, left side
  floverImage = love.graphics.newImage("flover.png")
  for i = 1, 5 do
    table.insert(plants, Plant.new(math.random(0, 4)*50, i * 100, floverImage))
  end

  -- Initialize zombies, right side
  zombieImage = love.graphics.newImage("zombie.png")
  for i = 1, 5 do
    table.insert(zombies, Zombie.new(math.random(8,16)*50, i * 100, zombieImage))
  end
end

function love.mousepressed(x, y)
  for i, plant in ipairs(plants) do
    if x >= plant.x and x <= plant.x + 50 and y >= plant.y and y <= plant.y + 50 then
      plants[i].clicked = true
    end
  end
end

function love.update(dt)
  if not gameOver then
    for _, plant in ipairs(plants) do
      plant:update(dt)
    end
    -- Update zombies
    for i, zombie in ipairs(zombies) do
      zombie:update(dt)
      
      if zombie:collidesWithPlants(plants[i]) then
        gameOver = true
      end
      
      if zombie:shooted(plants[i].projectiles[1], plants[i].damage) then
        table.remove(plants[i].projectiles, 1)
      end
      
      if zombie:killed() then
        score = score + zombie.point
        table.remove(zombies,i)
        table.insert(zombies,i,Zombie.new(math.random(8,16)*50, i * 100, zombieImage))
      end
    end
  end
end

function love.draw()
  love.graphics.print("Score:".. score , 20, 20)
  -- Draw plants
  for _, plant in ipairs(plants) do
    plant:draw()
  end

  -- Draw zombies
  for _, zombie in ipairs(zombies) do
    zombie:draw()
  end

  if gameOver then
    love.graphics.print("Game Over", 400, 300)
  end
end
