-- Plant.lua

local Plant = {}

function Plant.new(x, y, image)
  local self = {
      x = x,
      y = y,
      projectiles = {},
      damage = 50,
      clicked = false,
      readyToShoot = false,
      image = image
  }

  function self:update(dt)
    self.cooldown = (self.cooldown or 0) + dt
    
    if (self.cooldown >=1 ) then 
      self.readyToShoot = true
    end 
    
    if self.clicked and self.readyToShoot then
      local projectile = {x = self.x + 25, y = self.y + 25, speed = 25}
      table.insert(self.projectiles, projectile)
      self.readyToShoot = false
      self.clicked = false
      self.cooldown = 0
    end
    
    for _, projectile in ipairs(self.projectiles) do
      projectile.x = projectile.x + projectile.speed * dt
    end
  end

  function self:draw()
    love.graphics.draw(self.image, self.x, self.y)

    -- Draw projectiles
    love.graphics.setColor(255, 255, 255)
    for _, projectile in ipairs(self.projectiles) do
      love.graphics.rectangle("fill", projectile.x, projectile.y, 10, 5)
    end
  end


  return self
  
end

return Plant
