g_ScriptTitle = "ShootBeforeFreeze"
g_ScriptInfo = "Automatically fire upward with the grenade or laser to avoid freeze tiles"

aim = false

function OnSnapInput()
	if aim then
		if Game.LocalTee.Weapon ~= 5 then
			for i = 0,32 do
				local mur = i+32
				if Game.Collision:GetTile(Game.LocalTee.Pos.x, Game.LocalTee.Pos.y-i) == 4 or Game.Collision:GetTile(Game.LocalTee.Pos.x, Game.LocalTee.Pos.y-i) == 9 then
					if Game.LocalTee.Weapon == 4 then
						wall = vec2(Game.LocalTee.Pos.x, Game.LocalTee.Pos.y-368)
						if Game.Collision:IntersectLine(Game.LocalTee.Pos , wall, nil, nil, false) == 1 then
							Game.Input.TargetX = 0
							Game.Input.TargetY = -1
							Game.Input.Fire = Game.Input.Fire+2%64
						end
					elseif Game.LocalTee.Weapon == 3 then
						if Game.Collision:GetTile(Game.LocalTee.Pos.x, Game.LocalTee.Pos.y-mur) == 1 or Game.Collision:GetTile(Game.LocalTee.Pos.x, Game.LocalTee.Pos.y-mur) == 3 then
							Game.Input.TargetX = 0
							Game.Input.TargetY = -1
							Game.Input.Fire = Game.Input.Fire+2%64
						end
					end
				end
			end
		end
	end
end

function OnKeyPress(key)
	if key == "mouse3" then
		if aim then
			aim = false
			Game.Chat:Print(-1, 0, "→→ Safe-Mode disable", true)
		else
			aim = true
			Game.Chat:Print(-1, 0, "→→ Safe-Mode enable", true)
		end
	end
end