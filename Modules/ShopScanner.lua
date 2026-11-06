local BSS = getgenv().BSS

-- Безопасное чтение свойства ContentText
local function getContentText(obj)
    if not obj then return nil end
    local success, text = pcall(function() return obj.ContentText end)
    if success and text ~= "" then return text end
    local success2, text2 = pcall(function() return obj.Text end)
    if success2 then return text2 end
    return nil
end

function BSS.OpenShop()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    local screenGui = playerGui and playerGui:FindFirstChild("ScreenGui")
    local activateButton = screenGui and screenGui:FindFirstChild("ActivateButton")
    
    if activateButton then
        pcall(function() firesignal(activateButton.MouseButton1Click) end)
        task.wait(1.5) -- Ждем загрузки
        return true
    end
    return false
end

function BSS.CloseShop()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    local shop = playerGui and playerGui.ScreenGui and playerGui.ScreenGui:FindFirstChild("Shop")
    local closeBtn = shop and shop:FindFirstChild("Close")
    if closeBtn then
        pcall(function() firesignal(closeBtn.MouseButton1Click) end)
    end
end

function BSS.GetShopTimer()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    local shop = playerGui and playerGui.ScreenGui and playerGui.ScreenGui:FindFirstChild("Shop")
    local scroller = shop and shop:FindFirstChild("Scroller")
    local timerObj = scroller and scroller:FindFirstChild("Timer")
    local clockObj = timerObj and timerObj:FindFirstChild("Clock")
    
    return getContentText(clockObj) or "Таймер не найден"
end

function BSS.GetEquippedSprinkler()
    local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
    local shop = playerGui and playerGui.ScreenGui and playerGui.ScreenGui:FindFirstChild("Shop")
    if not shop then return nil, nil end

    local itemInfo = shop:FindFirstChild("ItemInfo")
    local itemNameObj = itemInfo and itemInfo:FindFirstChild("ItemName")
    local sprinklerName = getContentText(itemNameObj)

    local scroller = shop:FindFirstChild("Scroller")
    local buyButtonObj = scroller and scroller:FindFirstChild("BuyButton")
    local status = getContentText(buyButtonObj)

    return sprinklerName, status
end
