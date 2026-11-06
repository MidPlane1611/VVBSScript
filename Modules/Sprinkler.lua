local BSS = getgenv().BSS

local SprinklerData = {
    ["Basic Sprinkler"] = 1,
    ["Silver Soakers"] = 2,
    ["Golden Gushers"] = 3,
    ["Diamond Drenchers"] = 4,
    ["The Supreme Saturator"] = 1,
}

function BSS.PlaceSprinklers()
    -- Открываем магазин, чтобы узнать, что надето
    if BSS.OpenShop() then
        local sName, sStatus = BSS.GetEquippedSprinkler()
        BSS.CloseShop()

        if sName and sStatus == "Equipped" then
            local maxCount = SprinklerData[sName] or 1
            print("[BSS] Ставим спринклеры: " .. sName .. " (Кол-во: " .. maxCount .. ")")

            local rs = game:GetService("ReplicatedStorage")
            local eventFolder = rs:FindFirstChild("Event")
            if not eventFolder then return end

            for i = 1, maxCount do
                local itemEvent = eventFolder:FindFirstChild("ItemPackageEvent")
                if itemEvent then
                    pcall(function()
                        itemEvent:InvokeServer("Equip", { Category = "Sprinkler", Type = sName })
                    end)
                end
                task.wait(0.3)

                local activeEvent = eventFolder:FindFirstChild("PlayerActivesCommand")
                if activeEvent then
                    pcall(function()
                        activeEvent:FireServer({ Name = "Sprinkler Builder" })
                    end)
                end
                if i < maxCount then task.wait(1.0) end
            end
        else
            warn("[BSS] Спринклер не надет или не найден.")
        end
    end
end
