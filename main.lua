--Why u tryna steal a fucking menu
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Paradise Script Selection",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "Loading Paradise Hub",
    LoadingSubtitle = "by Paradise Team",
    Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "nil"
    },
 
    Discord = {
       Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "zFbwfmpCuc", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 local ScriptsTab = Window:CreateTab("Scripts")
 local InformationTab = Window:CreateTab("Information")

 local ScriptsSection = ScriptsTab:CreateSection("Scripts")
 
-- Define the allowed PlaceIds
local placeIds = {
    Admin = "any",
    Greenville = 891852901, -- Change this to Greenville's PlaceId
    Ragblood = 18722757961,  -- Change this to Ragblood's PlaceId
    Fisch = 16732694052  -- Change this to Ragblood's PlaceId
}

-- Define the scripts
local scripts = {
    Admin = "https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scripts/admin.lua",
    Greenville = "https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scripts/greenville.lua",
    Ragblood = "https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scripts/ragblood.lua",
    Fisch = "https://raw.githubusercontent.com/ParadiseCommunity/ParadiseScriptBox/refs/heads/main/scripts/fisch.lua"
}

-- Function to check PlaceId and execute the correct script
local function executeScript(name)
    if placeIds[name] == "any" or game.PlaceId == placeIds[name] then
        if scripts[name] then
            local success, err = pcall(function()
                loadstring(game:HttpGet(scripts[name]))()
            end)
            if not success then
                Rayfield:Notify({
                    Title = "Execution Error",
                    Content = "An error occurred: " .. tostring(err),
                    Duration = 5,
                    Type = "Error"
                })
            end
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Script not found!",
                Duration = 5,
                Type = "Error"
            })
        end
    else
        Rayfield:Notify({
            Title = "Incorrect Script For This Game",
            Content = "This script cannot be executed in this game.",
            Duration = 5,
            Type = "Warning"
        })
    end
end

ScriptsTab:CreateButton({
    Name = "Execute Admin Script",
    Callback = function()
        executeScript("Admin")
    end
})

ScriptsTab:CreateButton({
    Name = "Execute Greenville Script",
    Callback = function()
        executeScript("Greenville")
    end
})

ScriptsTab:CreateButton({
    Name = "Execute Ragblood Script",
    Callback = function()
        executeScript("Ragblood")
    end
})

ScriptsTab:CreateButton({
    Name = "Execute Fisch Script",
    Callback = function()
        executeScript("Fisch")
    end
})

local InformationSection = InformationTab:CreateSection("Thank you for using Paradise Hub, Enjoy your experience!")

Rayfield:LoadConfiguration()
