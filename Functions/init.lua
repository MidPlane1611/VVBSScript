getgenv().BSS = getgenv().BSS or {}
local BSS = getgenv().BSS

BSS.Features = {}
BSS.FeatureList = {}
BSS.Running = false

function BSS.RegisterFeature(category, section, name, runFn)
    local f = { category = category, section = section, name = name, enabled = false, run = runFn }
    table.insert(BSS.FeatureList, f)
    return f
end

function BSS.getHRP()
    local c = game.Players.LocalPlayer.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end
