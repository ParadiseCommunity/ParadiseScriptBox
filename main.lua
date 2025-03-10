local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scriptbox.lua"))()

for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end
