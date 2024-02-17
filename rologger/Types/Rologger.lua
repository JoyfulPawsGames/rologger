--[[
    Type definition of Rologger.
]]

do
    -- to fix linter type docstring bug.
end

--[[
    Log levels available for use.
]]
export type LogLevel = {
    DEBUG: number,
    INFO: number,
    WARN: number,
    ERROR: number,
}

export type RologgerProperties = {
    Name: string,
    LogLevel: number,
}

export type RologgerMethods = {
    --[[
        Set level for the logger.
    ]]
    SetLevel: (self: Rologger, level: number) -> boolean,

    --[[
        Log message with severity `DEBUG`.
    ]]
    Debug: (self: Rologger, mesasge: string) -> boolean,

    --[[
        Log message with severity `INFO`.
    ]]
    Info: (self: Rologger, mesasge: string) -> boolean,

    --[[
        Log message with severity `WARN`.
    ]]
    Warn: (self: Rologger, mesasge: string) -> boolean,

    --[[
        Log message with severity `ERROR`
    ]]
    Error: (self: Rologger, mesasge: string) -> boolean,
}

export type RologgerMetatable = {
    __index: RologgerMethods,
}

export type Rologger = typeof(setmetatable({} :: RologgerProperties, {} :: RologgerMetatable))

export type RologgerModule = {
    Logger: { [string]: Rologger },
    DefaultLogLevel: number,
    LogLevel: LogLevel,

    new: (self: RologgerModule, name: string) -> Rologger,
    SetDefaultLogLevel: (self: RologgerModule, level: number) -> boolean,
}
return {}
