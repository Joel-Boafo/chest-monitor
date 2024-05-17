yStep = 0

function increment(yStep)
    return yStep + 1
end

function ucfirst(str)
    return (str:gsub("^%l", string.upper))
end

function removeUnderscore(str)
    return str:gsub("_", " ")
end

function printInventoryOnMonitor(chest, monitor)
    local width, height = monitor.getSize()

    for _, item in pairs(chest.list()) do
        local name = removeUnderscore(ucfirst(string.sub(item.name, 11, string.len(item.name))))
        height = height / 2
        monitor.setCursorPos((width - string.len(name)) / 2, height)
        monitor.write(string.format(" %s", name))
        height = height + 1
        monitor.setCursorPos((width - string.len(tostring(item.count))) / 2, height)
        monitor.setTextColor(colors.gray)
        monitor.write(string.format("%dx", item.count))
        monitor.setTextColor(colors.white)
    end
end

while true do
    local monitor = peripheral.find("monitor")
    local chest = peripheral.find("minecraft:chest")

    if monitor and chest then
        printInventoryOnMonitor(chest, monitor)
    else
        print("monitor or chest not found")
    end

    sleep(10)
end