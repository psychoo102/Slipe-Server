-- Generated by CSharp.lua Compiler
local System = System
local SlipeLuaMtaDefinitions = SlipeLua.MtaDefinitions
System.namespace("SlipeLua.Shared.Cryptography", function (namespace)
  --/ <summary>
  --/ Represents static wrappers for Md5 methods
  --/ </summary>
  namespace.class("Md5", function (namespace)
    local Hash, Verify
    Hash = function (input)
      return SlipeLuaMtaDefinitions.MtaShared.Hash("md5", input)
    end
    Verify = function (input, hash)
      return (Hash(input) == hash)
    end
    return {
      Hash = Hash,
      Verify = Verify,
      __metadata__ = function (out)
        return {
          methods = {
            { "Hash", 0x18E, Hash, System.String, System.String },
            { "Verify", 0x28E, Verify, System.String, System.String, System.Boolean }
          },
          class = { 0xE }
        }
      end
    }
  end)
end)