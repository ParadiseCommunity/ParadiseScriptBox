--Fuck Skidders
local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "8233176adfca4a25ba18486ab653b2e4"
local falseData = "1b9a2fa9f1504f73aa9758132e403b1c"

KeyGuardLibrary.Set({
	publicToken = "c0bf4b311d4c4ea7931b19c484e7d95c",
	privateToken = "c87038d332f240928a80e13cd8096f9e",
	trueData = trueData,
	falseData = falseData,
})

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local key = ""

local Window = Fluent:CreateWindow({
    Title = "Key System",
    SubTitle = "Paradise Hub for Greenville",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 340),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    KeySys = Window:AddTab({ Title = "Key System", Icon = "key" }),
}

local Entkey = Tabs.KeySys:AddInput("Input", {
    Title = "Enter Key",
    Description = "Enter Key Here",
    Default = "",
    Placeholder = "Enter key…",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        key = Value
    end
})

local Checkkey = Tabs.KeySys:AddButton({
    Title = "Check Key",
    Description = "Enter Key before pressing this button",
    Callback = function()
        local response = KeyGuardLibrary.validateDefaultKey(key)
        if response == trueData then
           print("Key is valid")
           
loadstring(game:HttpGet(('https://pastebin.com/raw/srv0jQGX'),true))()

        else
           print("Key is invalid")
        end
    end
})

Window:SelectTab(1)
