-- Generated by CSharp.lua Compiler
local System = System
local SlipeLuaMtaDefinitions = SlipeLua.MtaDefinitions
local SlipeLuaSharedElements = SlipeLua.Shared.Elements
local SystemNumerics = System.Numerics
local SlipeLuaClientSounds
System.import(function (out)
  SlipeLuaClientSounds = SlipeLua.Client.Sounds
end)
System.namespace("SlipeLua.Client.Sounds", function (namespace)
  --/ <summary>
  --/ Represents a sound played at a certain location in the world
  --/ </summary>
  namespace.class("WorldSound", function (namespace)
    local getPosition, setPosition, getDimension, setDimension, getMaxDistance, setMaxDistance, getMinDistance, setMinDistance, 
    getPanningEnabled, setPanningEnabled, AttachTo, AttachTo1, Detach, getToAttached, getIsAttached, __ctor1__, 
    __ctor2__, __ctor3__, __ctor4__, __ctor5__
    __ctor1__ = function (this, element)
      SlipeLuaClientSounds.Sound.__ctor__[1](this, element)
    end
    __ctor2__ = function (this, pathOrUrl, position, looped, throttled)
      __ctor1__(this, SlipeLuaMtaDefinitions.MtaClient.PlaySound3D(pathOrUrl, position.X, position.Y, position.Z, looped, throttled))
    end
    __ctor3__ = function (this, container, bankId, soundId, position, looped)
      __ctor1__(this, SlipeLuaMtaDefinitions.MtaClient.PlaySFX3D(container:EnumToString(SlipeLuaClientSounds.SoundContainer):ToLower(), bankId, soundId, position.X, position.Y, position.Z, looped))
    end
    __ctor4__ = function (this, station, trackId, position, looped)
      __ctor1__(this, SlipeLuaMtaDefinitions.MtaClient.PlaySFX3D("radio", SlipeLuaMtaDefinitions.MtaClient.GetRadioChannelName(station), trackId, position.X, position.Y, position.Z, looped))
    end
    __ctor5__ = function (this, station, trackId, position, looped)
      __ctor1__(this, SlipeLuaMtaDefinitions.MtaClient.PlaySFX3D("radio", station:EnumToString(SlipeLuaClientSounds.ExtraStations), trackId, position.X, position.Y, position.Z, looped))
    end
    getPosition = function (this)
      local position = SlipeLuaMtaDefinitions.MtaShared.GetElementPosition(this.element)
      return SystemNumerics.Vector3(position[1], position[2], position[3])
    end
    setPosition = function (this, value)
      SlipeLuaMtaDefinitions.MtaShared.SetElementPosition(this.element, value.X, value.Y, value.Z, false)
    end
    getDimension = function (this)
      return SlipeLuaMtaDefinitions.MtaShared.GetElementDimension(this.element)
    end
    setDimension = function (this, value)
      SlipeLuaMtaDefinitions.MtaShared.SetElementDimension(this.element, value)
    end
    getMaxDistance = function (this)
      return SlipeLuaMtaDefinitions.MtaClient.GetSoundMaxDistance(this.element)
    end
    setMaxDistance = function (this, value)
      SlipeLuaMtaDefinitions.MtaClient.SetSoundMaxDistance(this.element, value)
    end
    getMinDistance = function (this)
      return SlipeLuaMtaDefinitions.MtaClient.GetSoundMinDistance(this.element)
    end
    setMinDistance = function (this, value)
      SlipeLuaMtaDefinitions.MtaClient.SetSoundMinDistance(this.element, value)
    end
    getPanningEnabled = function (this)
      return SlipeLuaMtaDefinitions.MtaClient.IsSoundPanningEnabled(this.element)
    end
    setPanningEnabled = function (this, value)
      SlipeLuaMtaDefinitions.MtaClient.SetSoundPanningEnabled(this.element, value)
    end
    AttachTo = function (this, toElement, offset)
      SlipeLuaMtaDefinitions.MtaShared.AttachElements(this.element, toElement:getMTAElement(), offset.X, offset.Y, offset.Z, 0, 0, 0)
    end
    AttachTo1 = function (this, toElement)
      AttachTo(this, toElement, SystemNumerics.Vector3.getZero())
    end
    Detach = function (this)
      SlipeLuaMtaDefinitions.MtaShared.DetachElements(this.element, nil)
    end
    getToAttached = function (this)
      return SlipeLuaSharedElements.ElementManager.getInstance():GetElement(SlipeLuaMtaDefinitions.MtaShared.GetElementAttachedTo(this.element), SlipeLuaSharedElements.PhysicalElement)
    end
    getIsAttached = function (this)
      return SlipeLuaMtaDefinitions.MtaShared.IsElementAttached(this.element)
    end
    return {
      base = function (out)
        return {
          out.SlipeLua.Client.Sounds.Sound
        }
      end,
      getPosition = getPosition,
      setPosition = setPosition,
      getDimension = getDimension,
      setDimension = setDimension,
      getMaxDistance = getMaxDistance,
      setMaxDistance = setMaxDistance,
      getMinDistance = getMinDistance,
      setMinDistance = setMinDistance,
      getPanningEnabled = getPanningEnabled,
      setPanningEnabled = setPanningEnabled,
      AttachTo = AttachTo,
      AttachTo1 = AttachTo1,
      Detach = Detach,
      getToAttached = getToAttached,
      getIsAttached = getIsAttached,
      __ctor__ = {
        __ctor1__,
        __ctor2__,
        __ctor3__,
        __ctor4__,
        __ctor5__
      },
      __metadata__ = function (out)
        return {
          properties = {
            { "Dimension", 0x106, System.Int32, getDimension, setDimension },
            { "IsAttached", 0x206, System.Boolean, getIsAttached },
            { "MaxDistance", 0x106, System.Int32, getMaxDistance, setMaxDistance },
            { "MinDistance", 0x106, System.Int32, getMinDistance, setMinDistance },
            { "PanningEnabled", 0x106, System.Boolean, getPanningEnabled, setPanningEnabled },
            { "Position", 0x106, System.Numerics.Vector3, getPosition, setPosition },
            { "ToAttached", 0x206, out.SlipeLua.Shared.Elements.PhysicalElement, getToAttached }
          },
          methods = {
            { ".ctor", 0x106, __ctor1__, out.SlipeLua.MtaDefinitions.MtaElement },
            { ".ctor", 0x406, __ctor2__, System.String, System.Numerics.Vector3, System.Boolean, System.Boolean },
            { ".ctor", 0x506, __ctor3__, System.Int32, System.Int32, System.Int32, System.Numerics.Vector3, System.Boolean },
            { ".ctor", 0x406, __ctor4__, System.Int32, System.Int32, System.Numerics.Vector3, System.Boolean },
            { ".ctor", 0x406, __ctor5__, System.Int32, System.Int32, System.Numerics.Vector3, System.Boolean },
            { "AttachTo", 0x206, AttachTo, out.SlipeLua.Shared.Elements.PhysicalElement, System.Numerics.Vector3 },
            { "AttachTo", 0x106, AttachTo1, out.SlipeLua.Shared.Elements.PhysicalElement },
            { "Detach", 0x6, Detach }
          },
          class = { 0x6 }
        }
      end
    }
  end)
end)