﻿using SlipeServer.Packets.Definitions.Player;
using SlipeServer.Packets.Enums;
using SlipeServer.Server.Elements;
using SlipeServer.Server.Enums;
using SlipeServer.Server.ElementCollections;

namespace SlipeServer.Server.PacketHandling.Handlers.Player;

public class PlayerWastedPacketHandler : IPacketHandler<PlayerWastedPacket>
{
    private readonly IElementCollection elementRepository;

    public PacketId PacketId => PacketId.PACKET_ID_PLAYER_WASTED;

    public PlayerWastedPacketHandler(
        IElementCollection elementRepository
    )
    {
        this.elementRepository = elementRepository;
    }

    public void HandlePacket(IClient client, PlayerWastedPacket packet)
    {
        var damager = this.elementRepository.Get(packet.KillerId);
        client.Player.Kill(
            damager, (WeaponType)packet.WeaponType, (BodyPart)packet.BodyPart,
            packet.AnimationGroup, packet.AnimationId
        );
    }
}
