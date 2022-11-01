-- Generated by CSharp.lua Compiler
local System = System
local SlipeLuaSharedElements
System.import(function (out)
  SlipeLuaSharedElements = SlipeLua.Shared.Elements
end)
System.namespace("SlipeLua.Shared.Elements", function (namespace)
  namespace.class("DefaultElementClassAttribute", function (namespace)
    local getElementType, __ctor1__, __ctor2__
    __ctor1__ = function (this, type)
      System.base(this).__ctor__(this)
      this.elementType = type
    end
    __ctor2__ = function (this, type)
      System.base(this).__ctor__(this)
      this.elementType = type:EnumToString(SlipeLuaSharedElements.ElementType):ToLower()
      this.elementType = this.elementType:Replace("gui", "gui-")
    end
    getElementType = function (this)
      return this.elementType
    end
    return {
      base = function (out)
        return {
          System.Attribute
        }
      end,
      getElementType = getElementType,
      __ctor__ = {
        __ctor1__,
        __ctor2__
      },
      __metadata__ = function (out)
        return {
          fields = {
            { "elementType", 0x1, System.String }
          },
          methods = {
            { ".ctor", 0x106, __ctor1__, System.String },
            { ".ctor", 0x106, __ctor2__, System.Int32 }
          },
          properties = {
            { "ElementType", 0x206, System.String, getElementType }
          },
          class = { 0x6 }
        }
      end
    }
  end)
end)