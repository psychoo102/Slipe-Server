-- Generated by CSharp.lua Compiler
local System = System
local SlipeLuaMtaDefinitions = SlipeLua.MtaDefinitions
local SlipeLuaSharedElements = SlipeLua.Shared.Elements
local SlipeLuaClientGui
System.import(function (out)
  SlipeLuaClientGui = SlipeLua.Client.Gui
end)
System.namespace("SlipeLua.Client.Gui", function (namespace)
  --/ <summary>
  --/ Represents a Cegui tab (use with tab panel)
  --/ </summary>
  namespace.class("Tab", function (namespace)
    local Delete, addOnOpen, removeOnOpen, __ctor1__, __ctor2__
    __ctor1__ = function (this, element)
      SlipeLuaClientGui.GuiElement.__ctor__(this, element)
      this.parentPanel = SlipeLuaSharedElements.ElementManager.getInstance():GetElement(SlipeLuaMtaDefinitions.MtaShared.GetElementParent(element), SlipeLuaClientGui.TabPanel)
    end
    __ctor2__ = function (this, title, panel)
      __ctor1__(this, SlipeLuaMtaDefinitions.MtaClient.GuiCreateTab(title, panel:getMTAElement()))
    end
    Delete = function (this)
      return SlipeLuaMtaDefinitions.MtaClient.GuiDeleteTab(this.element, this.parentPanel:getMTAElement())
    end
    addOnOpen, removeOnOpen = System.event("OnOpen")
    return {
      base = function (out)
        return {
          out.SlipeLua.Client.Gui.GuiElement
        }
      end,
      Delete = Delete,
      addOnOpen = addOnOpen,
      removeOnOpen = removeOnOpen,
      __ctor__ = {
        __ctor1__,
        __ctor2__
      },
      __metadata__ = function (out)
        return {
          fields = {
            { "parentPanel", 0x1, out.SlipeLua.Client.Gui.TabPanel }
          },
          methods = {
            { ".ctor", 0x106, __ctor1__, out.SlipeLua.MtaDefinitions.MtaElement },
            { ".ctor", 0x206, __ctor2__, System.String, out.SlipeLua.Client.Gui.TabPanel },
            { "Delete", 0x86, Delete, System.Boolean }
          },
          class = { 0x6, System.new(out.SlipeLua.Shared.Elements.DefaultElementClassAttribute, 2, 25 --[[ElementType.GuiTab]]) }
        }
      end
    }
  end)
end)