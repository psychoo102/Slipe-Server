-- Generated by CSharp.lua Compiler
local System = System
local SlipeLuaMtaDefinitions = SlipeLua.MtaDefinitions
local SlipeLuaSharedUtilities = SlipeLua.Shared.Utilities
local SystemNumerics = System.Numerics
local SlipeLuaClientDx
System.import(function (out)
  SlipeLuaClientDx = SlipeLua.Client.Dx
end)
System.namespace("SlipeLua.Client.Dx", function (namespace)
  --/ <summary>
  --/ Represents a drawable image
  --/ </summary>
  namespace.class("Image", function (namespace)
    local getDimensions, setDimensions, getFilePath, setFilePath, getMaterial, setMaterial, getRotation, setRotation, 
    getRotationCenter, setRotationCenter, Draw, internal, __ctor1__, __ctor2__, __ctor3__, __ctor4__, 
    __ctor5__, __ctor6__
    internal = function (this)
      this.Dimensions = System.default(SystemNumerics.Vector2)
      this.RotationCenter = System.default(SystemNumerics.Vector2)
    end
    __ctor1__ = function (this, position, dimensions, filePath, rotation, rotationCenter, color, postGUI)
      internal(this)
      SlipeLuaClientDx.Dx2DObject.__ctor__(this)
      this:setPosition(position:__clone__())
      this.Dimensions = dimensions:__clone__()
      setFilePath(this, filePath)
      this.Rotation = rotation
      this.RotationCenter = rotationCenter:__clone__()
      this.Color = color
      this.PostGUI = postGUI
      this.usePath = true
    end
    __ctor2__ = function (this, position, dimensions, filePath, rotation, rotationCenter)
      __ctor1__(this, position:__clone__(), dimensions:__clone__(), filePath, rotation, rotationCenter:__clone__(), SlipeLuaSharedUtilities.Color.getWhite(), false)
    end
    __ctor3__ = function (this, position, dimensions, filePath, rotation)
      __ctor2__(this, position:__clone__(), dimensions:__clone__(), filePath, rotation, SystemNumerics.Vector2.getZero())
    end
    __ctor4__ = function (this, position, dimensions, imageMaterial, rotation, rotationCenter, color, postGUI)
      internal(this)
      SlipeLuaClientDx.Dx2DObject.__ctor__(this)
      this:setPosition(position:__clone__())
      this.Dimensions = dimensions:__clone__()
      setMaterial(this, imageMaterial)
      this.Rotation = rotation
      this.RotationCenter = rotationCenter:__clone__()
      this.Color = color
      this.PostGUI = postGUI
      this.usePath = false
    end
    __ctor5__ = function (this, position, dimensions, imageMaterial, rotation, rotationCenter)
      __ctor4__(this, position:__clone__(), dimensions:__clone__(), imageMaterial, rotation, rotationCenter:__clone__(), SlipeLuaSharedUtilities.Color.getWhite(), false)
    end
    __ctor6__ = function (this, position, dimensions, imageMaterial, rotation)
      __ctor5__(this, position:__clone__(), dimensions:__clone__(), imageMaterial, rotation, SystemNumerics.Vector2.getZero())
    end
    getDimensions, setDimensions = System.property("Dimensions")
    getFilePath = function (this)
      return this.filePath
    end
    setFilePath = function (this, value)
      this.filePath = value
      this.usePath = true
    end
    getMaterial = function (this)
      return this.material
    end
    setMaterial = function (this, value)
      this.material = value
      this.usePath = false
    end
    getRotation, setRotation = System.property("Rotation")
    getRotationCenter, setRotationCenter = System.property("RotationCenter")
    Draw = function (this, source, eventArgs)
      if this.usePath then
        return SlipeLuaMtaDefinitions.MtaClient.DxDrawImage(this:getPosition().X, this:getPosition().Y, this.Dimensions:__clone__().X, this.Dimensions:__clone__().Y, getFilePath(this), this.Rotation, this.RotationCenter:__clone__().X, this.RotationCenter:__clone__().Y, this.Color:getHex(), this.PostGUI)
      else
        local default = getMaterial(this)
        if default ~= nil then
          default = default:getMaterialElement()
        end
        return SlipeLuaMtaDefinitions.MtaClient.DxDrawImage(this:getPosition().X, this:getPosition().Y, this.Dimensions:__clone__().X, this.Dimensions:__clone__().Y, default, this.Rotation, this.RotationCenter:__clone__().X, this.RotationCenter:__clone__().Y, this.Color:getHex(), this.PostGUI)
      end
    end
    return {
      base = function (out)
        return {
          out.SlipeLua.Client.Dx.Dx2DObject,
          out.SlipeLua.Client.Dx.IDrawable
        }
      end,
      usePath = false,
      getDimensions = getDimensions,
      setDimensions = setDimensions,
      getFilePath = getFilePath,
      setFilePath = setFilePath,
      getMaterial = getMaterial,
      setMaterial = setMaterial,
      Rotation = 0,
      getRotation = getRotation,
      setRotation = setRotation,
      getRotationCenter = getRotationCenter,
      setRotationCenter = setRotationCenter,
      Draw = Draw,
      __ctor__ = {
        __ctor1__,
        __ctor2__,
        __ctor3__,
        __ctor4__,
        __ctor5__,
        __ctor6__
      },
      __metadata__ = function (out)
        return {
          fields = {
            { "filePath", 0x3, System.String },
            { "material", 0x3, out.SlipeLua.Client.Dx.Material },
            { "usePath", 0x3, System.Boolean }
          },
          properties = {
            { "Dimensions", 0x106, System.Numerics.Vector2, getDimensions, setDimensions },
            { "FilePath", 0x106, System.String, getFilePath, setFilePath },
            { "Material", 0x106, out.SlipeLua.Client.Dx.Material, getMaterial, setMaterial },
            { "Rotation", 0x106, System.Single, getRotation, setRotation },
            { "RotationCenter", 0x106, System.Numerics.Vector2, getRotationCenter, setRotationCenter }
          },
          methods = {
            { ".ctor", 0x706, __ctor1__, System.Numerics.Vector2, System.Numerics.Vector2, System.String, System.Single, System.Numerics.Vector2, out.SlipeLua.Shared.Utilities.Color, System.Boolean },
            { ".ctor", 0x506, __ctor2__, System.Numerics.Vector2, System.Numerics.Vector2, System.String, System.Single, System.Numerics.Vector2 },
            { ".ctor", 0x406, __ctor3__, System.Numerics.Vector2, System.Numerics.Vector2, System.String, System.Single },
            { ".ctor", 0x706, __ctor4__, System.Numerics.Vector2, System.Numerics.Vector2, out.SlipeLua.Client.Dx.Material, System.Single, System.Numerics.Vector2, out.SlipeLua.Shared.Utilities.Color, System.Boolean },
            { ".ctor", 0x506, __ctor5__, System.Numerics.Vector2, System.Numerics.Vector2, out.SlipeLua.Client.Dx.Material, System.Single, System.Numerics.Vector2 },
            { ".ctor", 0x406, __ctor6__, System.Numerics.Vector2, System.Numerics.Vector2, out.SlipeLua.Client.Dx.Material, System.Single },
            { "Draw", 0x286, Draw, out.SlipeLua.Client.Elements.RootElement, out.SlipeLua.Client.Rendering.Events.OnRenderEventArgs, System.Boolean }
          },
          class = { 0x6 }
        }
      end
    }
  end)
end)