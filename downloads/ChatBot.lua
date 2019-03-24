g_ScriptTitle = "ChatBot"
g_ScriptInfo = "Send any msg with a specific delay"

h = 0
ph = ""
t = 100 --5 sec
Game.Chat:Print(-1, 0, "Set your msg with .msg", true)
Game.Chat:Print(-1, 0, "Set your delay with .d", true)
Game.Chat:Print(-1, 0, "Default delay : "..t/50.."seconds", true)
ok = false

function OnTick()
	h = h+1
	if h == t then
		h = 0
		if ok then
			Game.Chat:Say(0, ph)
		end
	end
end

function OnChatSend(team, msg)
	if msg:sub(1,5) == ".msg " then
		ph = msg:sub(6)
		Game.Chat:Print(-1, 0, "Msg set : "..msg:sub(6), true)
		ok = true
		h = 0
		return true
	elseif msg:sub(1,3) == ".d " then
		t = tonumber(msg:sub(4)*50)
		h = 0
		Game.Chat:Print(-1, 0, "Delay set : "..msg:sub(4).." seconds", true)
		return true
	end
end