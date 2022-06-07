﻿using SlipeServer.Packets.Definitions.Resources;
using SlipeServer.Packets.Structs;
using SlipeServer.Server.Elements;
using SlipeServer.Server.Extensions;
using System.Collections.Generic;
using System.Linq;

namespace SlipeServer.Server.Resources;

public class Resource
{
    private readonly MtaServer server;

    public DummyElement Root { get; }
    public DummyElement DynamicRoot { get; }
    public ushort NetId { get; set; }
    public int PriorityGroup { get; set; }
    public List<string> Exports { get; }
    public List<ResourceFile> Files { get; init; }
    public Dictionary<string, byte[]> NoClientScripts { get; init; }
    public string Name { get; }
    public string Path { get; }

    public Resource(
        MtaServer server, 
        RootElement root, 
        string name, 
        string? path = null
    )
    {
        this.server = server;
        this.Name = name;
        this.Path = path ?? $"./{name}";

        this.Files = new();
        this.NoClientScripts = new();

        this.Root = new DummyElement()
        {
            Parent = root,
            ElementTypeName = name,
        }.AssociateWith(server);
        this.DynamicRoot = new DummyElement()
        {
            Parent = this.Root,
            ElementTypeName = name,
        }.AssociateWith(server);

        this.Exports = new List<string>();
    }

    public void Start()
    {
        this.server.BroadcastPacket(new ResourceStartPacket(
            this.Name, this.NetId, this.Root.Id, this.DynamicRoot.Id, 0, null, null, false, this.PriorityGroup, this.Files, this.Exports)
        );

        this.server.BroadcastPacket(new ResourceClientScriptsPacket(
            this.NetId, this.NoClientScripts.ToDictionary(x => x.Key, x => CompressFile(x.Value)))
        );
    }

    public void Stop()
    {
        this.server.BroadcastPacket(new ResourceStopPacket(this.NetId));
    }

    public void StartFor(Player player)
    {
        new ResourceStartPacket(this.Name, this.NetId, this.Root.Id, this.DynamicRoot.Id, (ushort)this.NoClientScripts.Count, null, null, false, this.PriorityGroup, this.Files, this.Exports)
            .SendTo(player);

        new ResourceClientScriptsPacket(this.NetId, this.NoClientScripts.ToDictionary(x => x.Key, x => CompressFile(x.Value)))
            .SendTo(player);
    }

    public void StopFor(Player player)
    {
        new ResourceStopPacket(this.NetId).SendTo(player);
    }

    private byte[] CompressFile(byte[] input)
    {
        var compressed = Ionic.Zlib.ZlibStream.CompressBuffer(input);

        var result = new byte[] {
                (byte)((input.Length >> 24) & 0xFF),
                (byte)((input.Length >> 8) & 0xFF),
                (byte)((input.Length >> 24) & 0xFF),
                (byte)(input.Length & 0xFF)
            }.Concat(compressed).ToArray();

        return result;
    }
}
