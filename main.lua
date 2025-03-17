local scripts = {
    [891852901] = "https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scripts/greenville.lua", --Greenville
    [16732694052] = "https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scripts/fisch.lua", --Fisch
    [18722757961] = "https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scripts/ragblood.lua", --Ragblood
}

local gameId = game.PlaceId

if scripts[gameId] then
    local success, response = pcall(function()
        return game:HttpGet(scripts[gameId], true)
    end)
    
    if success and response then
        loadstring(response)()
    else
        print("Failed to fetch or execute script for Game ID: " .. gameId)
    end
else
    print("No script found for this Game ID: " .. gameId)
end
