﻿namespace SlipeServer.LuaControllers.Attributes;

[AttributeUsage(AttributeTargets.Class)]
public class LuaControllerAttribute : Attribute
{
    public string EventPrefix { get; }

    public LuaControllerAttribute(string eventPrefix)
    {
        this.EventPrefix = eventPrefix;
    }
}
