local BASE_URL = "https://raw.githubusercontent.com/ВАШ_НИК/BSS-AutoFarm/main/"

local MODULES = {
    "Functions/init.lua",
    "Modules/ShopScanner.lua",
    "Modules/Sprinkler.lua",
    "Functions/Farming.lua",
    "gui/init.lua",
}

local function fetch(path)
    return game:HttpGet(BASE_URL .. path .. "?t=" .. tostring(tick()))
end

for _, path in ipairs(MODULES) do
    local src = fetch(path)
    if src and src ~= "" then
        local chunk, err = loadstring(src, path)
        if chunk then
            local ok, runErr = pcall(chunk)
            if not ok then warn("[BSS] Ошибка в " .. path .. ": " .. tostring(runErr)) end
        else
            warn("[BSS] Синтаксис " .. path .. ": " .. tostring(err))
        end
    else
        warn("[BSS] Пустой файл: " .. path)
    end
    task.wait(0.05)
end
print("[BSS] Загрузка завершена!")
