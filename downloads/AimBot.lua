g_ScriptTitle = "AimBot"
g_ScriptInfo = "Aim your closest ennemy"

target = -1
aim = false
noTeam = false
autoShoot = false

function GetClosestID()
	ClosestID = -1
	ClosestDist = Game.Tuning().laser_reach.Value/100
	rayon = 800
	for i = 0, Game.ServerInfo.MaxPlayers do
		if Game.Players(i).Name ~= "" then
			if i ~= Game.LocalCID and Game.Players(i).Tee.Weapon ~= 5 and Game.Players(Game.LocalCID).Tee.Weapon ~= 5 then
				if Game.Players(i).Team ~= Game.Players(Game.LocalCID).Team then
					local dist = Game.Collision:Distance(Game.LocalTee.Pos, Game.Players(i).Tee.Pos)
					if dist < rayon then
						if ClosestID == -1 or dist < ClosestDist then
							if Game.Collision:IntersectLine(Game.LocalTee.Pos, Game.Players(i).Tee.Pos, nil, nil, false) == 0 then
								if noTeam then
									if Game.Players(i).Team ~= Game.Players(Game.LocalCID).Team then
										ClosestID = i
										ClosestDist = dist
									end
								else
									ClosestID = i
									ClosestDist = dist
								end
							end
						end
					end
				end
			end
		end
	end
  return ClosestID
end

function OnSnapInput()
	target = GetClosestID()
	if target ~= -1 then
		if aim then
			Game.Input.WantedWeapon = 4
			Game.Input.TargetX = Game.Players(target).Tee.Pos.x - Game.LocalTee.Pos.x
			Game.Input.TargetY = Game.Players(target).Tee.Pos.y - Game.LocalTee.Pos.y
			if autoShoot then
				Game.Input.Fire = Game.Input.Fire+2%64
			end
		end
	end
end

function OnChatSend(team,msg)
	if msg == ".team" then
		if noTeam then
			noTeam = false
			Game.Chat:Print(-1, 0, "Team aim set to : true", true)
		else
			noTeam = true
			Game.Chat:Print(-1, 0, "Team aim set to : false", true)
		end
		return true
	elseif msg == ".autoshot" then
		if autoShoot then
			autoShoot = false
			Game.Chat:Print(-1, 0, "AutoShoot set to : false", true)
		else
			autoShoot = true
			Game.Chat:Print(-1, 0, "AutoShoot set to : true", true)
		end
		return true
	end
end
end

function OnKeyPress(key)
	if key == "mouse3" then
		if aim then
			aim = false
			Game.Chat:Print(-1, 0, "→→ Aimbot disable", true)
		else
			aim = true
			Game.Chat:Print(-1, 0, "→→ Aimbot enable", true)
		end
	end
end