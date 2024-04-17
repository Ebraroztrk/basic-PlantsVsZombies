-- zombie.lua

local Zombie = {}

function Zombie.new(x, y, image)
  local self = {
      x = x,
      y = y,
      health = 100,
      point = 30,
      image = image
  }

  function self:update(dt)
    self.x = self.x - 50 * dt
  end

  function self:draw()
    love.graphics.draw(self.image, self.x, self.y)
  end

  function self:collidesWithPlants(plant)
    if self.x < plant.x + 50 and self.x + 50 > plant.x and self.y < plant.y + 50 and self.y + 50 > plant.y then
      return true
    end
    return false
  end
  
  function self:shooted(projectile, damage)
    if(projectile) then
      if (projectile.x >= self.x)then
        self.health = self.health - damage
        return true
      end
    end
    
    return false
  end
  
  function self:killed()
    return self.health <= 0
  end

  return self
end

return Zombie