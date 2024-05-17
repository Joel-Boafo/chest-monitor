-- URLs voor de scripts
local chestMonitorUrl = "https://raw.githubusercontent.com/<username>/<repository>/main/chest_monitor.lua"
local chestMonitorFile = "chest_monitor.lua"
local startupFile = "startup.lua"

-- Functie om een bestand te downloaden
local function download(url, filename)
    local response = http.get(url)
    if response then
        local file = fs.open(filename, "w")
        file.write(response.readAll())
        file.close()
        response.close()
        print("Gedownload: " .. filename)
        return true
    else
        print("Fout bij downloaden: " .. filename)
        return false
    end
end

-- Controleer of HTTP is ingeschakeld
if not http then
    print("HTTP API is niet ingeschakeld. Schakel HTTP in de configuratie in.")
    return
end

-- Download het chest monitor script
local success = download(chestMonitorUrl, chestMonitorFile)
if not success then
    print("Kan het chest_monitor.lua script niet downloaden. Controleer de URL en probeer opnieuw.")
    return
end

-- Creëer het startup script
local startupScript = [[
shell.run("chest_monitor.lua")
]]

local file = fs.open(startupFile, "w")
file.write(startupScript)
file.close()
print("Aangemaakt: " .. startupFile)

-- Herstart de computer
print("Herstarten...")
os.reboot()
