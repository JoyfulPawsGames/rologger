--[[
    Implementation of Rologger.
]]

----- Types -----
local types = script.Types
local Rologger = require(types.Rologger)

----- Module Tables -----
local LogLevel: Rologger.LogLevel = {
    DEBUG = 10,
    INFO = 20,
    WARN = 30,
    ERROR = 40,
}

local RologgerProperties: Rologger.RologgerProperties = {
    Name = "root",
    LogLevel = LogLevel.DEBUG,
}

local RologgerMethods: Rologger.RologgerMethods = {
    SetLevel = function(self, level)
        for name, value in pairs(LogLevel) do
            if value == level then
                self.LogLevel = level
                return true
            end
        end
        warn(`Unknown log level with value {level}!`)
        return false
    end,

    Debug = function(self, message)
        local shouldLog = self.LogLevel <= LogLevel.DEBUG
        if shouldLog then
            print(`[DEBUG] {self.Name} {message}`)
        end
        return shouldLog
    end,

    Info = function(self, message)
        local shouldLog = self.LogLevel <= LogLevel.DEBUG
        if shouldLog then
            print(`[INFO] {self.Name} {message}`)
        end
        return shouldLog
    end,

    Warn = function(self, message)
        local shouldLog = self.LogLevel <= LogLevel.DEBUG
        if shouldLog then
            warn(`[WARN] {self.Name} {message}`)
        end
        return shouldLog
    end,
    Error = function(self, message)
        local shouldLog = self.LogLevel <= LogLevel.DEBUG
        if shouldLog then
            warn(`[ERROR] {self.Name} {message}`)
        end
        return shouldLog
    end,
}

local RologgerMetatable: Rologger.RologgerMetatable = {
    __index = RologgerMethods,
}

local RologgerModule: Rologger.RologgerModule = {
    Logger = {},
    DefaultLogLevel = LogLevel.DEBUG,
    LogLevel = LogLevel,

    new = function(self, name)
        local doesLoggerExist = self.Logger[name]
        if doesLoggerExist then
            return doesLoggerExist
        end
        local rologger = table.clone(RologgerProperties)
        setmetatable(rologger, RologgerMetatable)
        rologger.Name = name
        rologger:SetLevel(self.DefaultLogLevel)
        self.Logger[name] = rologger
        return rologger
    end,

    SetDefaultLogLevel = function(self, level)
        for name, value in pairs(LogLevel) do
            if value == level then
                self.DefaultLogLevel = level
                return true
            end
        end
        warn(`Unknown log level with value {level}!`)
        return false
    end,
}

return RologgerModule
