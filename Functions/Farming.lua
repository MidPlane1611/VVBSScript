local BSS = getgenv().BSS

-- Секция Farming
BSS.RegisterFeature("Farming", "Farming", "Autofarm", function()
    -- Заглушка для будущего фарма
end)

BSS.RegisterFeature("Farming", "Farming", "Auto Sprinkler", function()
    -- Вызываем нашу функцию расстановки
    BSS.PlaceSprinklers()
    task.wait(5) -- Пауза, чтобы не спамить
end)
